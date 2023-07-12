function New-CitrixTemplateRegistry {
    <#
    .SYNOPSIS
    Creates a new Windows Registry definition in the Citrix Optimizer template.

    .DESCRIPTION
    This function will create a Registry Definition in the Citrix Optimizer template.
    
    .PARAMETER Path
    Specifies the Path to the template file

    .PARAMETER GroupName
    Specifies the Group in the template file to add the Registry Entry to

    .PARAMETER EntryName
    The Display Name for the Registry Entry in Citrix Optimizer

    .PARAMETER EntryDescription
    The Display Description for the Registry Entry in Citrix Optimizer

    .PARAMETER ItemName
    The Registry Item Name to add

    .PARAMETER ItemPath
    The Registry Item Path to add

    .PARAMETER ItemValue
    The Registry Item Value to add

    .PARAMETER ItemType
    The Registry Item Type to add ("Dword","Binary","ExpandString","MultiString","String","Qword")

    .INPUTS
    This function will take inputs via pipeline as string

    .OUTPUTS
    Returns $true or $false depending on the Scheduled Task creation state

    .EXAMPLE
    PS> New-CitrixTemplateRegistry -Path 'template.xml' -GroupName 'Group1' -EntryName 'Add Edge Update Registry Entry' -EntryDescription 'Disable Edge Updates via HKLM' -ItemName 'UpdatesEnabled' -ItemPath 'HKLM\Software\Microsoft\Edge' -ItemValue '0' -ItemType 'Dword'
    Adds an entry to disable the Edge Updates in the template file.
    .EXAMPLE
    PS> New-CitrixTemplateRegistry -Path $Template.Path -GroupName 'Group1' -EntryName 'Add Edge Update Registry Entry' -EntryDescription 'Disable Edge Updates via HKLM' -ItemName 'UpdatesEnabled' -ItemPath 'HKLM\Software\Microsoft\Edge' -ItemValue '0' -ItemType 'Dword'
    Adds an entry to disable the Edge Updates in the template file based on the return value in $Template.Path
    .EXAMPLE
    PS> New-CitrixTemplateRegistry -Path $Template.Path -GroupName $Group.Name -EntryName 'Add Edge Update Registry Entry' -EntryDescription 'Disable Edge Updates via HKLM' -ItemName 'UpdatesEnabled' -ItemPath 'HKLM\Software\Microsoft\Edge' -ItemValue '0' -ItemType 'Dword'
    Adds an entry to disable the Edge Updates in the template file based on the return value in $Template.Path and $Group.Name
    .EXAMPLE
    PS> New-CitrixTemplateRegistry -Path $Template.Path -GroupName 'System Optimizations' -EntryName 'Remove Edge Item 1' -EntryDescription 'Remove Edge Item 1' -ItemName 'Item1' -ItemPath 'HKLM\Software\Microsoft\Edge' -DeleteValue
    Deletes a registry value from the master image
    .EXAMPLE
    PS> New-CitrixTemplateRegistry -Path $Template.Path -GroupName 'System Optimizations' -EntryName 'Remove Edge Key 1' -EntryDescription 'Remove Edge Key 1' -ItemPath 'HKLM\Software\Microsoft\Edge1' -DeleteKey
    Deletes a registry key from the master image

    .LINK
    https://github.com/dbretty/Citrix.Optimizer.Template/blob/main/Help/New-CitrixTemplateRegistry.MD
#>

[CmdletBinding()]

Param (
    [Parameter(
        ValuefromPipelineByPropertyName = $true,mandatory=$true
    )]
    [System.String]$Path,
    [Parameter(
        ValuefromPipelineByPropertyName = $true,mandatory=$true
    )]
    [System.String]$GroupName,
    [Parameter(
        ValuefromPipelineByPropertyName = $true,mandatory=$true
    )]
    [System.String]$EntryName,
    [Parameter(
        ValuefromPipelineByPropertyName = $true,mandatory=$true
    )]
    [System.String]$EntryDescription,
    [Parameter(
        ValuefromPipelineByPropertyName = $true,mandatory=$false
    )]
    [System.String]$ItemName,
    [Parameter(
        ValuefromPipelineByPropertyName = $true,mandatory=$true
    )]
    [System.String]$ItemPath,
    [Parameter(
        ValuefromPipelineByPropertyName = $true,mandatory=$false
    )]
    [System.String]$ItemValue,
    [Parameter(
        ValuefromPipelineByPropertyName = $true,mandatory=$false
    )]
    [ValidateSet("Dword","Binary","ExpandString","MultiString","String","Qword")]
    [System.String]$ItemType,
    [switch]$DeleteValue,
    [switch]$DeleteKey
)

begin {

        # Set strict mode and initial return value
        Set-StrictMode -Version Latest

        # Set up PSCustom Object for return
        $Return = New-Object -TypeName psobject 
        $Return | Add-Member -MemberType NoteProperty -Name "Complete" -Value $false

} # begin

process {

    # Check if the template already exists
    if(Get-Template -Path $Path){

        write-verbose "Citrix Optimizer Template $($Path) found"
        write-verbose "Load Citrix Optimizer Template"

        # Load Template and check for existing Group"
        [XML]$xmlfile = Get-Content $Path

        # Check that the Group Exists
        if(Get-TemplateGroup -Path $Path -GroupName $GroupName){

            write-verbose "Group $($GroupName) found"

            # Check that the entry does not already exist
            if(!(Get-TemplateEntry -Path $Path -EntryName $EntryName)){

                write-verbose "Registry Entry $($EntryName) not found, adding"

                # Get the Group XML details into a variable
                $Group = $xmlfile.root.group | where-object {$_.id -eq $($GroupName)}

                # Create the Entry element
                write-verbose "Create Entry element"
                $Entry = $XMLFile.CreateElement("entry")

                    # Create the Entry header element
                    write-verbose "Create Name, Description and Execute element"
                    $Name = $XMLFile.CreateElement("name")
                    $Name.InnerText = $EntryName
                    $Entry.AppendChild($Name)

                    $Description = $xmlfile.CreateElement("description")
                    $Description.InnerText = $EntryDescription
                    $Entry.AppendChild($Description)

                    $Execute = $xmlfile.CreateElement("execute")
                    $Execute.InnerText = "1"
                    $Entry.AppendChild($Execute)

                    # Create the action element
                    write-verbose "Create Action element"
                    $Action = $XMLFile.CreateElement("action")

                        # Create the plugin element
                        write-verbose "Create Plugin element"
                        $Plugin = $XMLFile.CreateElement("plugin")
                        $Plugin.InnerText = "Registry"
                        $Action.AppendChild($Plugin)

                        # Create the params element
                        write-verbose "Create Params element"
                        $Params = $XMLFile.CreateElement("params")

                            # Check if DeleteKey was passed in, if so then skip this write
                            if(!($DeleteKey)){
                                $ParamName = $XMLFile.CreateElement("name")
                                $ParamName.InnerText = $ItemName
                                $Params.AppendChild($ParamName)
                            }

                            # Write the Path element
                            $ParamPath = $XMLFile.CreateElement("path")
                            $ParamPath.InnerText = $ItemPath
                            $Params.AppendChild($ParamPath)

                            # If DeleteValue was passed in then set the value to DeleteValue
                            if($DeleteValue){
                                $ParamValue = $XMLFile.CreateElement("value")
                                $ParamValue.InnerText = "CTXOE_DeleteValue"
                                $Params.AppendChild($ParamValue)
                            } else {
                                # If DeleteKey was passed in then set the value to DeleteKey
                                if($DeleteKey){
                                    $ParamValue = $XMLFile.CreateElement("value")
                                    $ParamValue.InnerText = "CTXOE_DeleteKey"
                                    $Params.AppendChild($ParamValue)
                                } else {
                                    # Set the value to the parameter passed in
                                    $ParamValue = $XMLFile.CreateElement("value")
                                    $ParamValue.InnerText = $ItemValue
                                    $Params.AppendChild($ParamValue)
                                }
                            }

                            # If neither DeleteKey or DeleteValue was passed in then set the value type
                            if((!($DeleteValue)) -and (!($DeleteKey))){
                                $ParamValueType = $XMLFile.CreateElement("valuetype")
                                $ParamValueType.InnerText = $ItemType
                                $Params.AppendChild($ParamValueType)
                            }

                        $Action.AppendChild($Params)

                    $Entry.AppendChild($Action)

                $Group.AppendChild($Entry)

                # Close and save the XML file
                $XMLFile.Save($Path)
                write-verbose "Registry Entry $($EntryName) added"
                $Return.Complete = $true

            } else {

                # Entry name is already present
                write-verbose "Entry $($EntryName) already found - quitting"
                write-error "Entry $($EntryName) already found - quitting"

            }

        } else {

            # Group was not found in template
            write-verbose "Group $($GroupName) not found - quitting"
            write-error "Group $($GroupName) not found - quitting"

        }
    } else {

        # Template file not found
        write-verbose "Template $($Path) not found - quitting"
        write-error "Template $($Path) not found - quitting"

    }

} # process

end {
    
    # Pass back return object
    return $Return

} # end

}
