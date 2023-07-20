function Set-PowerShellFormat {
    <#
    .SYNOPSIS
    Sets the PowerShell Script to Citrix Optimizer Standards.

    .DESCRIPTION
    This function will take in a ps1 Script File and Format it to work with Citrix Optimizer
    
    .PARAMETER ScriptData
    Specifies the PScript Contents

    .INPUTS
    This function will take inputs via pipeline as string

    .OUTPUTS
    Returns the fotmatted PowerShell Script

    .EXAMPLE
    PS> Set-PowerShellFormat -ScriptData $Script -EntryName 'Disable Windows Updates'
    Formats the script in $Script for the Citrix Optimizer.
#>

[CmdletBinding()]

Param (
    [Parameter(
        ValuefromPipelineByPropertyName = $true,mandatory=$true
    )]
    $ScriptData
)

begin {

    Set-StrictMode -Version Latest

} # begin

process {

    # Build the formatted script
    $FormattedScript = ""
    $FormattedScript = $FormattedScript + "`ttry {`n"

    # Add the script contents
    foreach($Line in $ScriptData){
        $FormattedScript = $FormattedScript + "`t`t$($Line)`n"
    }

    # Add the true return value
    $FormattedScript = $FormattedScript + "`t`t" + '$Global' + ":CTXOE_Details = " + """Complete"";`n"
    $FormattedScript = $FormattedScript + "`t`t" + '$Global' + ":CTXOE_Result = " + '$True;' + "`n"
    $FormattedScript = $FormattedScript + "`t} catch {`n"

    # Add the false return value
    $FormattedScript = $FormattedScript + "`t`t" + '$Global' + ":CTXOE_Details = " + """Errored"";`n"
    $FormattedScript = $FormattedScript + "`t`t" + '$Global' + ":CTXOE_Result = " + '$False;' + "`n"
    $FormattedScript = $FormattedScript + "`t}`n"

} # process

end {

    # Pass back return object
    return $FormattedScript
    
} # end

}
