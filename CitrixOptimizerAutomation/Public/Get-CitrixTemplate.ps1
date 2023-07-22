function Get-CitrixTemplate {
    <#
    .SYNOPSIS
    Gets a Citrix Optimizer Template.

    .DESCRIPTION
    This function will get a Citrix Optimizer Template and return the Template Path and Template Contents.
    
    .PARAMETER Path
    Specifies the Path to the template file

    .INPUTS
    This function will take inputs via pipeline as string

    .OUTPUTS
    Returns an object with the template path and contents

    .EXAMPLE
    PS> Get-CitrixTemplate -Path 'template.xml'
    Gets 'template.xml' and returns the XML as part of the Object'.

    .LINK
    https://github.com/dbretty/CitrixOptimizerAutomation/blob/main/Help/Get-CitrixTemplate.MD
#>

[CmdletBinding()]

Param (
    [Parameter(
        ValuefromPipelineByPropertyName = $true,mandatory=$true
    )]
    [System.String]$Path
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
    if((Get-Template -Path $Path)){

        write-verbose "The template file $($Path) was found"

        write-verbose "Reading XML template"
        [xml]$xmlDoc = Get-Content $Path
        $Return | Add-Member -MemberType NoteProperty -Name "XML" -Value $xmlDoc

        # Set return value
        $Return.complete = $true

    } else {

        # Template already exists, write verbose and error stream
        write-verbose "The template file $($Path) was not found"
        write-error "The template file $($Path) was not found"

    }

} # process

end {

    # Add the template path and pass back return object
    $Return | Add-Member -MemberType NoteProperty -Name "Path" -Value $Path
    return $Return

} # end

}
