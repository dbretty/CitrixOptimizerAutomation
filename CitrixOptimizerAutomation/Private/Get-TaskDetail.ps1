function Get-TaskDetail {
    <#
    .SYNOPSIS
    Strips a Scheduled Task into the Path and Task Name.

    .DESCRIPTION
    This function will strip a Scheduled Task into the Path and Task Name.
    
    .PARAMETER TaskPath
    Specifies the full path to the Scheduled Task

    .INPUTS
    This function will take inputs via pipeline as string

    .OUTPUTS
    Returns a custom PSObject with the Path and TaskName values

    .EXAMPLE
    PS> Get-TaskDetail -TaskPath '/Microsoft/Windows/AppID'
    Decodes the Task Path passed in to a Task Path and Task Name.
#>

[CmdletBinding()]

Param (
    [Parameter(
        ValuefromPipelineByPropertyName = $true,mandatory=$true
    )]
    [System.String]$TaskPath
)

begin {

    Set-StrictMode -Version Latest

    # Set up PSCustom Object for return
    $Return = New-Object -TypeName psobject 

} # begin

process {

    # Trim any Trailing \ chatacters
    if($TaskPath -notmatch '\\$'){
        $TaskTrimmed = $TaskPath.Substring(0,$TaskPath.Length)
    } else {
        $TaskTrimmed = $TaskPath.Substring(0,$TaskPath.Length - 1)
    }
    
    if(!($TaskTrimmed.StartsWith("\"))){
        $TaskTrimmed = "\$($TaskTrimmed)"
    }

    # Get The Task Name
    $TaskName = $TaskTrimmed.Substring($TaskTrimmed.lastIndexOf('\') + 1)

    # Get The Task Path 
    $TaskPathReturn = $TaskTrimmed.Substring(0,$TaskTrimmed.lastIndexOf('\') + 1)

    # Build the Return Object
    $Return | Add-Member -MemberType NoteProperty -Name "TaskName" -Value $TaskName
    $Return | Add-Member -MemberType NoteProperty -Name "TaskPath" -Value $TaskPathReturn

} # process

end {

    # Pass back return object
    return $Return

} # end

}
