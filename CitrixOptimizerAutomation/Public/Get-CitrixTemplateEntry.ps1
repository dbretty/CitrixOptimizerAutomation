function Get-CitrixTemplateEntry {
    <#
    .SYNOPSIS
    Gets Entries from the Citrix Optimizer template.

    .DESCRIPTION
    This function will get the Entries from a Citrix Optimizer Template passed in
    
    .PARAMETER Path
    Specifies the Path to the template file

    .PARAMETER EntryName
    The Specific Entry Name that you want to return

    .INPUTS
    This function will take inputs via pipeline as string

    .OUTPUTS
    Returns a custom powershell object with all the entries passed in

    .EXAMPLE
    PS> Get-CitrixTemplateEntry -Path 'template.xml' -EntryName "Optimize Internet Explorer"
    Gets the entry details for the entry "Optimize Internet Explorer".
    .EXAMPLE
    PS> Get-CitrixTemplateEntry -Path 'template.xml' -Registry
    Gets all the Registry Entries from the Template File.
    .EXAMPLE
    PS> $Entries = Get-CitrixTemplateEntry -Path 'template.xml' -Service
    Gets all the Service Entries from the template and assigns the result to the $Entries variable.

    .LINK
    https://github.com/dbretty/Citrix.Optimizer.Template/blob/main/Help/Get-CitrixTemplateEntry.MD
#>

[CmdletBinding()]

Param (
    [Parameter(
        ValuefromPipelineByPropertyName = $true,mandatory=$true
    )]
    [System.String]$Path,
    [Parameter(
        ValuefromPipelineByPropertyName = $true,mandatory=$false
    )]
    [System.String]$EntryName,
    [switch]$Registry,
    [switch]$ScheduledTask,
    [switch]$Service,
    [switch]$PowerShell
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
        [XML]$xmlfile = Get-Content $Path

        # Check the variables passed in and gather the entries for the specific parameter
        if($Registry) {
            write-verbose "Loading all entry types (Registry) to the return object"
            $EntryDetail = $xmlfile.SelectNodes("/root//group//entry") | where-object {$_.action.plugin -like "Registry*"}
        } else {
            if($ScheduledTask){
                write-verbose "Loading all entry types (Scheduled Tasks) to the return object"
                $EntryDetail = $xmlfile.SelectNodes("/root//group//entry") | where-object {$_.action.plugin -like "SchTasks*"}
            } else {
                if($Service){
                    write-verbose "Loading all entry types (Service) to the return object"
                    $EntryDetail = $xmlfile.SelectNodes("/root//group//entry") | where-object {$_.action.plugin -like "Service*"}
                } else {
                    if($PowerShell){
                        write-verbose "Loading all entry types (PowerShell) to the return object"
                        $EntryDetail = $xmlfile.SelectNodes("/root//group//entry") | where-object {$_.action.plugin -like "PowerShell*"}
                    } else {
                        if($null -eq ($xmlfile.SelectNodes("/root//group//entry") | where-object {$_.name -eq $($EntryName)})){
                            write-verbose "Entry $($EntryName) not found"
                            $EntryDetail = "None"
                        } else {
                            write-verbose "Loading Entry Detail for $($EntryName) Details to Object"
                            $EntryDetail = $xmlfile.SelectNodes("/root//group//entry") | where-object {$_.name -eq $($EntryName)}
                        }
                    }
                }
            }
        }

        # Assign the return value to the custom psobject
        $Return | Add-Member -MemberType NoteProperty -Name "Entry" -Value $EntryDetail
        $Return.Complete = $true

    } else {

        # Template file not found
        write-verbose "Citrix Optimizer Template $($Path) not found - quitting"
        write-error "Citrix Optimizer Template $($Path) not found - quitting"

    }

} # process

end {
    
    # Pass back return object
    return $Return

} # end

}
