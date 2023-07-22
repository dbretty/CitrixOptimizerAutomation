function Get-CitrixTemplateGroup {
    <#
    .SYNOPSIS
    Gets Group Entries from the Citrix Optimizer template.

    .DESCRIPTION
    This function will get the Group Entries from a Citrix Optimizer Template passed in
    
    .PARAMETER Path
    Specifies the Path to the template file

    .PARAMETER GroupName
    Specifies the Group Name to gather the information for

    .INPUTS
    This function will take inputs via pipeline as string

    .OUTPUTS
    Returns $true or $false depending on the Group creation state as well as the Group Entries

    .EXAMPLE
    PS> Get-CitrixTemplateGroup -Path 'template.xml' -GroupName 'OS Optimizations'
    Gets the Group called "OS Optimizations"
    .EXAMPLE
    PS> Get-CitrixTemplateGroup -Path $Template.Path -GroupName 'System Optimizations' 
    Gets the Group called "System Optimizations" in the template file based on the result of a New-CitrixTemplate return object.
    .EXAMPLE
    PS> $Group = Get-CitrixTemplateGroup -Path $Template.Path -GroupName 'System Optimizations' 
    Gets the Group called "System Optimizations" in the template file based on the result of a New-CitrixTemplate return object and pipes this into the variable $Group.

    .LINK
    https://github.com/dbretty/Citrix.Optimizer.Template/blob/main/Help/Get-CitrixTemplateGroup.MD
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

    # Check if the template already exists
    if(Get-Template -Path $Path){

        write-verbose "Citrix Optimizer Template $($Path) found"
        write-verbose "Load Citrix Optimizer Template"

        # Load Template and check for existing Group"
        [XML]$xmlfile = Get-Content $Path

        if($null -eq ($xmlfile.root.group | where-object {$_.id -eq $($GroupName)})){
            write-verbose "Group $($GroupName) not found"
        } else {
            # Add the Group Entries to the return object
            write-verbose "Loading Group $($GroupName) Details to Object"
            $GroupDetail = $xmlfile.root.group | where-object {$_.id -eq $($GroupName)}
            $Return | Add-Member -MemberType NoteProperty -Name "GroupDetail" -Value $GroupDetail
            $Return.Complete = $true
        }

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
