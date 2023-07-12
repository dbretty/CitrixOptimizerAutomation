function New-CitrixTemplateScript {
    <#
    .SYNOPSIS
    Creates a new PowerShell Script definition in the Citrix Optimizer template.

    .DESCRIPTION
    This function will create PowerShell Script Definition in the Citrix Optimizer template to disable.
    
    .PARAMETER Path
    Specifies the Path to the template file

    .PARAMETER GroupName
    The existing Group to add the Service to

    .PARAMETER EntryName
    The Display Name in Citrix Optimizer

    .PARAMETER EntryDescription
    The Description in Citrix Optimizer

    .PARAMETER ScriptFile
    The Service Name to Disable

    .INPUTS
    This function will take inputs via pipeline as string

    .OUTPUTS
    Returns $true or $false depending on the Script creation state

    .EXAMPLE
    PS> New-CitrixTemplateScript -Path 'template.xml' -GroupName 'Group 1' -EntryName 'Stop Windows Update Services' -EntryDescription 'Stops and disables the Windows Update Service' -ScriptFile './disablewu.ps1'
    Adds a script entry to disable the Windows Update service in the template file.
    .EXAMPLE
    PS> New-CitrixTemplateScript -Path $Template.Path -GroupName 'Group 1' -EntryName 'Stop Windows Update Services' -EntryDescription 'Stops and disables the Windows Update Service' -ScriptFile './disablewu.ps1'
    Adds a script entry to disable the Windows Update service in the template file using the $Template.Path return value.
    .EXAMPLE
    PS> New-CitrixTemplateScript -Path $Template.Path -GroupName $Group.Name -EntryName 'Stop Windows Update Services' -EntryDescription 'Stops and disables the Windows Update Service' -ScriptFile './disablewu.ps1'
    Adds a script entry to disable the Windows Update service in the template file using the $Template.Path return value and the $Group.Name return value.

    .LINK
    https://github.com/dbretty/Citrix.Optimizer.Template/blob/main/Help/New-CitrixTemplateScript.MD
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
        ValuefromPipelineByPropertyName = $true,mandatory=$true
    )]
    [System.String]$ScriptFile
)

begin {

        # Set strict mode and initial return value
        Set-StrictMode -Version Latest

        # Set up PSCustom Object for return
        $Return = New-Object -TypeName psobject 
        $Return | Add-Member -MemberType NoteProperty -Name "Complete" -Value $false

} # begin

process {

    # Check if the Script File Passed in is valid
    if(Test-Path -Path $ScriptFile){

        # Check if the template already exists
        if(Get-Template -Path $Path){

            write-verbose "Citrix Optimizer Template $($Path) found"
            write-verbose "Load Citrix Optimizer Template"

            # Load Template and check for existing Group and Service"
            [XML]$xmlfile = Get-Content $Path

            # Check that the Group exists
            if(Get-TemplateGroup -Path $Path -GroupName $GroupName){

                write-verbose "Group $($GroupName) found"

                # Check the Entry is not already present
                if(!(Get-TemplateEntry -Path $Path -EntryName $EntryName)){

                    write-verbose "Script $($EntryName) not found, adding"

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
                            $Plugin.InnerText = "PowerShell"
                            $Action.AppendChild($Plugin)

                            # Create the executeparams element
                            write-verbose "Create ExecuteParams element"
                            $Params = $XMLFile.CreateElement("executeparams")

                                # Format the PowerShell to Citrix Optimizer Standard
                                $ScriptData = Get-Content $ScriptFile
                                $FinalScript = Set-PowerShellFormat -ScriptData $ScriptData

                                # Write the PowerShell Formatted Script
                                $ParamValue = $XMLFile.CreateElement("value")
                                $ParamValue.InnerText = $FinalScript
                                $ParamValue.AppendChild($XMLFile.CreateCDataSection($FinalScript))
                                $Params.AppendChild($ParamValue)

                            $Action.AppendChild($Params)

                        $Entry.AppendChild($Action)

                    $Group.AppendChild($Entry)

                    # Close and save the XML file
                    $XMLFile.Save($Path)
                    write-verbose "Script $($EntryName) added"
                    $Return.Complete = $true

                } else {

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
    } else {

        # Script file not found
        write-verbose "Script $($ScriptFile) not found - quitting"
        write-error "Script $($ScriptFile) not found - quitting"

    }

} # process

end {
    
    # Pass back return object
    return $Return

} # end

}
