function Get-Template {
    <#
    .SYNOPSIS
    Checks if a Citrix Optimizer template already exists.

    .DESCRIPTION
    This function will take in a Citrix Optimizer template file path and check if that template already exists.
    
    .PARAMETER Path
    Specifies the Path to the template file

    .INPUTS
    This function will take inputs via pipeline as string

    .OUTPUTS
    Returns true or false base on the result of the Citrix Optimizer template lookup

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

    # Check for the existence of the template file
    $Return = Test-Path $Path

} # process

end {

    # Pass back return object
    return $Return
    
} # end

}
