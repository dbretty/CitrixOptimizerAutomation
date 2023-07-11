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

    .INPUTS
    This function will take inputs via pipeline as string

    .OUTPUTS
    Returns $true or $false depending on the Service creation state

    .EXAMPLE
    PS> New-CitrixTemplateService -Path 'template.xml' -EntryName 'Disable the Print Spooler' -ServiceName 'spooler' -ServiceDescription 'Windows Print Service' -GroupName 'Group 1'
    Adds an entry to disable the Print Spooler service in the template file.
    .EXAMPLE
    PS> New-CitrixTemplateService -Path $Template.Path -EntryName 'Disable the Print Spooler' -ServiceName 'spooler' -ServiceDescription 'Windows Print Service' -GroupName 'Group 1'
    Adds an entry to disable the Print Spooler service in the template file passed in via the output from the New-CitrixTemplate cmdlet.
    .EXAMPLE
    PS> New-CitrixTemplateService -Path 'template.xml' -EntryName 'Disable the Print Spooler' -ServiceName 'spooler' -ServiceDescription 'Windows Print Service' -GroupName $Group.GroupName
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
    [System.String]$GroupName
)

begin {

        # Set strict mode and initial return value
        Set-StrictMode -Version Latest

        # Set up PSCustom Object for return
        $Return = New-Object -TypeName psobject 
        $Return | Add-Member -MemberType NoteProperty -Name "Complete" -Value $false

} # begin

process {

    if(Get-Template -Path $Path){

        write-verbose "Citrix Optimizer Template $($Path) found"
        write-verbose "Load Citrix Optimizer Template"

        # Load Template and check for existing Group and Service"
        [XML]$xmlfile = Get-Content $Path

        if(Get-TemplateGroup -Path $Path -GroupName $GroupName){

            write-verbose "Group $($GroupName) found"

            if(!(Get-TemplateEntry -Path $Path -EntryName $EntryName)){

                write-verbose "Service $($EntryName) not found, adding"

                $Group = $xmlfile.root.group | where-object {$_.id -eq $($GroupName)}
                
                write-verbose "Create Entry element"
                $Entry = $XMLFile.CreateElement("entry")

                    write-verbose "Create Name element"
                    $Name = $XMLFile.CreateElement("name")
                    $Name.InnerText = $EntryName
                    $Entry.AppendChild($Name)

                    $Description = $xmlfile.CreateElement("description")
                    $Description.InnerText = $ServiceDescription
                    $Entry.AppendChild($Description)

                    $Execute = $xmlfile.CreateElement("execute")
                    $Execute.InnerText = "1"
                    $Entry.AppendChild($Execute)

                    write-verbose "Create Action element"
                    $Action = $XMLFile.CreateElement("action")

                        $Plugin = $XMLFile.CreateElement("plugin")
                        $Plugin.InnerText = "Services"
                        $Action.AppendChild($Plugin)

                        $Params = $XMLFile.CreateElement("params")

                            $ParamName = $XMLFile.CreateElement("name")
                            $ParamName.InnerText = $ServiceName
                            $Params.AppendChild($ParamName)

                            $ParamValue = $XMLFile.CreateElement("value")
                            $ParamValue.InnerText = "Disabled"
                            $Params.AppendChild($ParamValue)

                        $Action.AppendChild($Params)

                    $Entry.AppendChild($Action)

                $Group.AppendChild($Entry)

                $XMLFile.Save($Path)
                write-verbose "Service $($EntryName) added"
                $Return.Complete = $true

            } else {

                write-verbose "Entry $($EntryName) already found - quitting"
                write-error "Entry $($EntryName) already found - quitting"

            }
            
        } else {

            write-verbose "Group $($GroupName) not found - quitting"
            write-error "Group $($GroupName) not found - quitting"

        }
    } else {

        write-verbose "Template $($Path) not found - quitting"
        write-error "Template $($Path) not found - quitting"

    }

} # process

end {
    
    return $Return

} # end

}
