function New-CitrixTemplateTask {
    <#
    .SYNOPSIS
    Creates a new Windows Scheduled Task definition in the Citrix Optimizer template.

    .DESCRIPTION
    This function will create a Scheduled Task Definition in the Citrix Optimizer template.
    
    .PARAMETER Path
    Specifies the Path to the template file

    .PARAMETER GroupName
    Specifies the Group in the template file to add the Scheduled Task to

    .PARAMETER TaskName
    The Display Name for the Scheduled Task in Citrix Optimizer

    .PARAMETER TaskPath
    The Full Path to the Scheduled Task

    .PARAMETER TaskDescription
    The Description for the Scheduled Task

    .PARAMETER State
    The Service State (Enabled / Disabled)

    .INPUTS
    This function will take inputs via pipeline as string

    .OUTPUTS
    Returns $true or $false depending on the Scheduled Task creation state

    .EXAMPLE
    PS> New-CitrixTemplateTask -Path 'template.xml' -GroupName 'Group1' -TaskName 'SchTask - AppID' -TaskPath '\Microsoft\Windows\AppID\' -TaskDescription 'This is the AppID Scheduled Task' -State "Disabled"
    Adds an entry to disable the AppID Scheduled Task in the template file.
    .EXAMPLE
    PS> New-CitrixTemplateTask -Path $Template.Path -GroupName 'Group1' -TaskName 'SchTask - AppID' -TaskPath '\Microsoft\Windows\AppID\' -TaskDescription 'This is the AppID Scheduled Task' -State "Disabled"
    Adds an entry to disable the AppID Scheduled Task in the template file based on the return value in $Template.Path
    .EXAMPLE
    PS> New-CitrixTemplateTask -Path $Template.Path -GroupName $Group.Name -TaskName 'SchTask - AppID' -TaskPath '\Microsoft\Windows\AppID\' -TaskDescription 'This is the AppID Scheduled Task' -State "Disabled"
    Adds an entry to disable the AppID Scheduled Task in the template file based on the return value in $Template.Path and $Group.Name

    .LINK
    https://github.com/dbretty/Citrix.Optimizer.Template/blob/main/Help/New-CitrixTemplateTask.MD
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
    [System.String]$TaskName,
    [Parameter(
        ValuefromPipelineByPropertyName = $true,mandatory=$true
    )]
    [System.String]$TaskPath,
    [Parameter(
        ValuefromPipelineByPropertyName = $true,mandatory=$true
    )]
    [System.String]$TaskDescription,
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

    if(Get-Template -Path $Path){

        write-verbose "Citrix Optimizer Template $($Path) found"
        write-verbose "Load Citrix Optimizer Template"

        # Load Template and check for existing Group"
        [XML]$xmlfile = Get-Content $Path

        if(Get-TemplateGroup -Path $Path -GroupName $GroupName){

            write-verbose "Group $($GroupName) found"

            if(!(Get-TemplateEntry -Path $Path -EntryName $TaskName)){

                write-verbose "Scheduled Task $($TaskName) not found, adding"

                $Group = $xmlfile.root.group | where-object {$_.id -eq $($GroupName)}

                # Decode Task Path
                $Task = Get-TaskDetail -TaskPath $TaskPath
                write-verbose "Create Entry element"
                $Entry = $XMLFile.CreateElement("entry")

                    write-verbose "Create Name element"
                    $Name = $XMLFile.CreateElement("name")
                    $Name.InnerText = $TaskName
                    $Entry.AppendChild($Name)

                    $Description = $xmlfile.CreateElement("description")
                    $Description.InnerText = $TaskDescription
                    $Entry.AppendChild($Description)

                    $Execute = $xmlfile.CreateElement("execute")
                    $Execute.InnerText = "1"
                    $Entry.AppendChild($Execute)

                    write-verbose "Create Action element"
                    $Action = $XMLFile.CreateElement("action")

                        $Plugin = $XMLFile.CreateElement("plugin")
                        $Plugin.InnerText = "SchTasks"
                        $Action.AppendChild($Plugin)

                        $Params = $XMLFile.CreateElement("params")

                            $ParamName = $XMLFile.CreateElement("name")
                            $ParamName.InnerText = $Task.TaskName
                            $Params.AppendChild($ParamName)

                            $ParamPath = $XMLFile.CreateElement("path")
                            $ParamPath.InnerText = $Task.TaskPath
                            $Params.AppendChild($ParamPath)

                            $ParamValue = $XMLFile.CreateElement("value")
                            $ParamValue.InnerText = $State
                            $Params.AppendChild($ParamValue)

                        $Action.AppendChild($Params)

                    $Entry.AppendChild($Action)

                $Group.AppendChild($Entry)

                $XMLFile.Save($Path)
                write-verbose "Scheduled Task $($TaskName) added"
                $Return.Complete = $true

            } else {

                write-verbose "Entry $($TaskName) already found - quitting"
                write-error "Entry $($TaskName) already found - quitting"

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
