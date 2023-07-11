function Get-TemplateGroup {
    <#
    .SYNOPSIS
    Checks if a template group already exists.

    .DESCRIPTION
    This function will take in a template file path and group name check if the group already exists.
    
    .PARAMETER Path
    Specifies the XML template path

    .PARAMETER GroupName
    Specifies the Group Name

    .INPUTS
    This function will take inputs via pipeline as string

    .OUTPUTS
    Returns true or false base on the result of the template group lookup

    .EXAMPLE
    PS> Get-TemplateGroup -Path $xmlFile.path -GroupName 'Group1'
    Checks for 'Group1' in template.xml.
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

    Set-StrictMode -Version Latest

} # begin

process {

    $Return = $false
    [XML]$xmlgroups = Get-Content $Path
    
    if(($xmlgroups.SelectNodes("/root//group")).Count -eq 0){
        $Return = $false
    } else {
        if($null -eq ($xmlfile.root.group | where-object {$_.id -eq $($GroupName)})){
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
