function Get-TemplateEntry {
    <#
    .SYNOPSIS
    Checks if a template <entry> already exists.

    .DESCRIPTION
    This function will take in a template file path and entry name check if the <entry> already exists.
    
    .PARAMETER Path
    Specifies the XML template path

    .PARAMETER EntryName
    Specifies the Entry Name

    .INPUTS
    This function will take inputs via pipeline as string

    .OUTPUTS
    Returns true or false base on the result of the template entry lookup

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

    # Set the default return value
    $Return = $false

    # Get the contents of the XML file passed in
    [XML]$xmlentries = Get-Content $Path
    
    # Check if there are no entries yet and return false
    if(($xmlentries.SelectNodes("/root//group//entry")).Count -eq 0){
        $Return = $false
    } else {
        # Get the entry name details from the XML variable
        $Entries = $xmlentries.SelectNodes("/root//group//entry") | where-object {$_.name -eq $($EntryName)}
        if($Null -eq $Entries){
            # Entry not found, return false
            $Return = $false
        } else {
            # Entry already in XML variable, return true
            $Return = $true 
        } 
    }

} # process

end {

    # Pass back return object
    return $Return
    
} # end

}
