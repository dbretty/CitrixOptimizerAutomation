function Get-TemplateEntry {
    <#
    .SYNOPSIS
    Checks if a template entry already exists.

    .DESCRIPTION
    This function will take in a template file path and entry name check if the entry already exists.
    
    .PARAMETER Path
    Specifies the XML template path

    .PARAMETER EntryName
    Specifies the Entry Name

    .INPUTS
    This function will take inputs via pipeline as string

    .OUTPUTS
    Returns true or false base on the result of the template group lookup

    .EXAMPLE
    PS> Get-TemplateEntry -Path $Path -EntryName 'Disable Print Spooler'
    Checks for a entry called 'Disable Print Spooler' in template.xml.
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
    [System.String]$EntryName
)

begin {

    Set-StrictMode -Version Latest

} # begin

process {

    $Return = $false
    [XML]$xmlentries = Get-Content $Path
    
    if(($xmlentries.SelectNodes("/root//group//entry")).Count -eq 0){
        $Return = $false
    } else {
        $Entries = $xmlentries.SelectNodes("/root//group//entry") | where-object {$_.name -eq $($EntryName)}
        if($Null -eq $Entries){
            $Return = $false
        } else {
            $Return = $true 
        } 
    }

} # process

end {

    return $Return
    
} # end

}
