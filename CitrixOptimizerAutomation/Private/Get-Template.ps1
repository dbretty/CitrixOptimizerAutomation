function Get-Template {
    <#
    .SYNOPSIS
    Checks if a template already exists.

    .DESCRIPTION
    This function will take in a template file path and check if that template already exists.
    
    .PARAMETER Path
    Specifies the Path to the template file

    .INPUTS
    This function will take inputs via pipeline as string

    .OUTPUTS
    Returns true or false base on the result of the template lookup

    .EXAMPLE
    PS> Get-Template -Path 'template.xml'
    Checks for a template called template.xml.
#>

[CmdletBinding()]

Param (
    [Parameter(
        ValuefromPipelineByPropertyName = $true,mandatory=$true
    )]
    [System.String]$Path
)

begin {

    Set-StrictMode -Version Latest

} # begin

process {

    $Return = Test-Path $Path

} # process

end {

    return $Return
    
} # end

}
