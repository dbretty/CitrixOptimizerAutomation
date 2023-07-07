function New-CitrixTemplateService {
    <#
    .SYNOPSIS
    Creates a new Windows Service definition in the Citrix Optimizer template.

    .DESCRIPTION
    This function will create Service Definition in the Citrix Optimizer template.
    
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

    .LINK
    https://github.com/dbretty/Citrix.Optimizer.Template/blob/main/Help/New-CitrixTemplateService.MD
#>

[CmdletBinding(SupportsShouldProcess=$true)]

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
    [Switch] $Force
)

begin {

        # Set strict mode and initial return value
        Set-StrictMode -Version Latest

        # Set up PSCustom Object for return
        $Return = New-Object -TypeName psobject 
        $Return | Add-Member -MemberType NoteProperty -Name "Complete" -Value $false

} # begin

process {

    if ($Force -or $PSCmdlet.ShouldProcess())
    {

        if(Get-Template -Path $Path){

            write-verbose "Template $($Path) found"
            write-verbose "Load Template"

            # Load Template and check for existing Group"
            [XML]$xmlfile = Get-Content $Path

            # Check that the Group specified exists
            $Found = $false
            foreach($Group in $XMLFile.root.group){
                if($Group.id -eq $GroupName){
                    $Found = $true
                }
            }
        
            if($Found){
                write-verbose "Group $($GroupName) found, adding service"

                $Entry = $XMLFile.CreateElement("entry")

                    $Name = $XMLFile.CreateElement("name")
                    $Name.InnerText = $EntryName
                    $Entry.AppendChild($Name)

                    $Description = $xmlfile.CreateElement("description")
                    $Description.InnerText = $ServiceDescription
                    $Entry.AppendChild($Description)

                    $Execute = $xmlfile.CreateElement("execute")
                    $Execute.InnerText = "1"
                    $Entry.AppendChild($Execute)

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
                write-verbose "Service $($ServiceName) added"
                $Return.Complete = $true
                
            } else {

                write-verbose "Group not found - quitting"
                write-error "Group not found - quitting"

            }
        } else {

            write-verbose "Template not found - quitting"
            write-error "Template not found - quitting"

        }

    }

} # process

end {
    
    return $Return

} # end

}
