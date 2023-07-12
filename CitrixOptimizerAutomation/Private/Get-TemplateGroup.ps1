function Get-TemplateGroup {
    <#
    .SYNOPSIS
    Checks if a template <group> already exists.

    .DESCRIPTION
    This function will take in a template file path and group name check if the <group> already exists.
    
    .PARAMETER Path
    Specifies the XML template path

    .PARAMETER GroupName
    Specifies the Group Name

    .INPUTS
    This function will take inputs via pipeline as string

    .OUTPUTS
    Returns true or false base on the result of the template group lookup

    .EXAMPLE
    PS> Get-TemplateGroup -Path 'template.xml' -GroupName 'Group1'
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

    # Set the default return value
    $Return = $false

    # Get the contents of the XML file passed in
    [XML]$xmlgroups = Get-Content $Path
    
    # Check if there are no groups yet and return false
    if(($xmlgroups.SelectNodes("/root//group")).Count -eq 0){
        $Return = $false
    } else {
        # Get the group name details from the XML variable
        if($null -eq ($xmlfile.root.group | where-object {$_.id -eq $($GroupName)})){
            # Group not found, return false
            $Return = $false
        } else {
            # Group already in XML variable, return true
            $Return = $true 
        } 
    }

} # process

end {

    # Pass back return object
    return $Return
    
} # end

}
