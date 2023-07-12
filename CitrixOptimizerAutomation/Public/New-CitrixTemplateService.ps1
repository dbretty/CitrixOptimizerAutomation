function New-CitrixTemplateService {
    <#
    .SYNOPSIS
    Creates a new Windows Service definition in the Citrix Optimizer template.

    .DESCRIPTION
    This function will create Service Definition in the Citrix Optimizer template to disable.
    
    .PARAMETER Path
    Specifies the Path to the template file

    .PARAMETER EntryName
    The Display Name in Citrix Optimizer

    .PARAMETER ServiceName
    The Service Name to Disable

    .PARAMETER ServiceDescription
    The Description for the service to disable

    .PARAMETER GroupName
    The existing Group to add the Service to

    .PARAMETER State
    The Service State (Enabled / Disabled)

    .INPUTS
    This function will take inputs via pipeline as string

    .OUTPUTS
    Returns $true or $false depending on the Service creation state

    .EXAMPLE
    PS> New-CitrixTemplateService -Path 'template.xml' -EntryName 'Disable the Print Spooler' -ServiceName 'spooler' -ServiceDescription 'Windows Print Service' -GroupName 'Group 1' -State "Disabled"
    Adds an entry to disable the Print Spooler service in the template file.
    .EXAMPLE
    PS> New-CitrixTemplateService -Path $Template.Path -EntryName 'Disable the Print Spooler' -ServiceName 'spooler' -ServiceDescription 'Windows Print Service' -GroupName 'Group 1' -State "Disabled"
    Adds an entry to disable the Print Spooler service in the template file passed in via the output from the New-CitrixTemplate cmdlet.
    .EXAMPLE
    PS> New-CitrixTemplateService -Path 'template.xml' -EntryName 'Disable the Print Spooler' -ServiceName 'spooler' -ServiceDescription 'Windows Print Service' -GroupName $Group.GroupName -State "Disabled"
    Adds an entry to disable the Print Spooler service in the template file passed in via the output from the New-CitrixTemplate cmdlet and the Group Name passed in via the output $Group.GroupName.

    .LINK
    https://github.com/dbretty/Citrix.Optimizer.Template/blob/main/Help/New-CitrixTemplateService.MD
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
    [System.String]$EntryName,
    [Parameter(
        ValuefromPipelineByPropertyName = $true,mandatory=$true
    )]
    [System.String]$ServiceName,
    [Parameter(
        ValuefromPipelineByPropertyName = $true,mandatory=$true
    )]
    [System.String]$ServiceDescription,
    [Parameter(
        ValuefromPipelineByPropertyName = $true,mandatory=$true
    )]
    [System.String]$GroupName,
    [Parameter(
        ValuefromPipelineByPropertyName = $true,mandatory=$true
    )]
    [ValidateSet("Enabled","Disabled")]
    $State
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

        # Load Template and check for existing Group and Service"
        [XML]$xmlfile = Get-Content $Path

        # Check that the Group exists
        if(Get-TemplateGroup -Path $Path -GroupName $GroupName){

            write-verbose "Group $($GroupName) found"

            # Check the Entry is not already present
            if(!(Get-TemplateEntry -Path $Path -EntryName $EntryName)){

                write-verbose "Service $($EntryName) not found, adding"

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
                    $Description.InnerText = $ServiceDescription
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
                        $Plugin.InnerText = "Services"
                        $Action.AppendChild($Plugin)

                        # Create the params element
                        write-verbose "Create Params element"
                        $Params = $XMLFile.CreateElement("params")

                            # Write the service name
                            $ParamName = $XMLFile.CreateElement("name")
                            $ParamName.InnerText = $ServiceName
                            $Params.AppendChild($ParamName)

                            # Write the desired state
                            $ParamValue = $XMLFile.CreateElement("value")
                            $ParamValue.InnerText = $State
                            $Params.AppendChild($ParamValue)

                        $Action.AppendChild($Params)

                    $Entry.AppendChild($Action)

                $Group.AppendChild($Entry)

                # Close and save the XML file
                $XMLFile.Save($Path)
                write-verbose "Service $($EntryName) added"
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

} # process

end {
    
    # Pass back return object
    return $Return

} # end

}
