function New-CitrixTemplateReport {
    <#
    .SYNOPSIS
    Creates a new Citrix Optimizer Template report.

    .DESCRIPTION
    This function will create a markdown report based on the template passed in.
    
    .PARAMETER Path
    Specifies the Path to the template file

    .INPUTS
    This function will take inputs via pipeline as string

    .OUTPUTS
    Returns $true or $false depending on the Group creation state as well as the Group Entries

    .EXAMPLE
    PS> New-CitrixTemplateReport -Path 'template.xml' 
    Creates a new report from the template.xml file
    .EXAMPLE
    PS> New-CitrixTemplateReport -Path 'template.xml' -Registry
    Creates a new report from the template.xml file with only the Registry entries present
    .EXAMPLE
    PS> New-CitrixTemplateReport -Path 'template.xml' -Registry -Service
    Creates a new report from the template.xml file with the Registry and Service entries present

    .LINK
    https://github.com/dbretty/Citrix.Optimizer.Template/blob/main/Help/New-CitrixTemplateReport.MD
#>

[CmdletBinding()]

Param (
    [Parameter(
        ValuefromPipelineByPropertyName = $true,mandatory=$true
    )]
    [System.String]$Path,
    [switch]$Registry,
    [switch]$ScheduledTask,
    [switch]$Service,
    [switch]$PowerShell,
    [switch]$All
)

begin {

        # Set strict mode and initial return value
        Set-StrictMode -Version Latest

        # Set up PSCustom Object for return
        $Return = New-Object -TypeName psobject 
        $Return | Add-Member -MemberType NoteProperty -Name "FileName" -Value "README.MD"
        $Return | Add-Member -MemberType NoteProperty -Name "Detail" -Value ""

} # begin

process {

    # Set the param value options
    if($All){
        $Registry = $true
        $ScheduledTask = $true
        $Service = $true
        $PowerShell = $true
    }

    if(!($Registry)){ $Registry = $false }
    if(!($ScheduledTask)){ $ScheduledTask = $false }
    if(!($Service)){ $Service = $false }
    if(!($PowerShell)){ $PowerShell = $false }

    # Check if the template already exists
    if(Get-Template -Path $Path){

        write-verbose "Citrix Optimizer Template $($Path) found"
        write-verbose "Load Citrix Optimizer Template"

        # Create the File path and initial file
        $mdFile = "REPORT.MD"
        if(!(Test-Path -Path $mdFile)){
            write-verbose "Creating Markdown File: $($mdFile)"
            $mdOutput = New-Item -Name $mdFile -ItemType File
        } else {
            write-error "Markdown File: $($mdFile) Already Exists, Please Delete and Re-run Script"
            write-verbose "Markdown File: $($mdFile) Already Exists, Please Delete and Re-run Script"
            break
        }

        # Load Template 
        write-verbose "Loading XML Template"
        [XML]$xmlfile = Get-Content $Path

        # Write Report Metadata
        $MetaData = $xmlfile.root.metadata
        write-verbose "Writing Metadata Detail"
        Add-Content $mdFile "# Citrix Optimizer Report for $($MetaData.displayname)"
        Add-Content $mdFile ""
        Add-Content $mdFile "## Metadata Detail"
        Add-Content $mdFile ""
        Add-Content $mdFile "| Item | Value |"
        Add-Content $mdFile "| --- | --- |"
        Add-Content $mdFile "| **Display Name** | $($MetaData.displayname) |"
        Add-Content $mdFile "| **Description** | $($MetaData.description) |"
        Add-Content $mdFile "| **Category** | $($MetaData.category) |"
        Add-Content $mdFile "| **Author** | $($MetaData.author) |"
        Add-Content $mdFile "| **Last Update** | $($MetaData.lastupdatedate) |"

        # Optimization Details
        write-verbose "Writing Optimization Details"
        Add-Content $mdFile "## Optimization Details"
        # Get the top level groups
        $Groups = $xmlfile.root.group

        # Loop through the groups
        foreach($Group in $Groups){

            # Write the Group Header information
            write-verbose "Adding Group $($Group.displayname)"
            Add-Content $mdFile "### $($Group.displayname)"
            Add-Content $mdFile "$($Group.description)"

            # Loop through the group entries
            $Entries = $Group.entry

            foreach($Entry in $Entries){
                $Action = $Entry.action
                
                # Check if process Registry
                if(($Action.plugin -eq "Registry") -and $Registry){
                    write-verbose "Adding Registry $($Entry.name)"
                    $Params = $Action.params
                    Add-Content $mdFile "#### $($Entry.name)"
                    Add-Content $mdFile "| **Registry** | $($Params.name) |"
                    Add-Content $mdFile "| :--- | :--- |"
                    Add-Content $mdFile "| **Description** | $($Entry.description) |"
                    if($Entry.execute -eq "1"){
                        Add-Content $mdFile "| **Default** | True |"
                    } else {
                        Add-Content $mdFile "| **Default** | False |"
                    }
                    Add-Content $mdFile "| **Name** | $($Params.name) |"
                    Add-Content $mdFile "| **Path** | $($Params.path) |"
                    if($Params.value -eq "CTXOE_DeleteValue"){
                        Add-Content $mdFile "| **Value** | Delete Value |"
                    } else {
                        Add-Content $mdFile "| **Value** | $($Params.value) |"
                        Add-Content $mdFile "| **Value Type** | $($Params.valuetype) |"
                    }  
                }

                # Check if process Scheduled Task
                if(($Action.plugin -eq "SchTasks") -and $ScheduledTask){
                    write-verbose "Adding Scheduled Task $($Entry.name)"
                    $Params = $Action.params
                    Add-Content $mdFile "#### $($Entry.name)"
                    Add-Content $mdFile "| **Scheduled Task** | $($Params.name) |"
                    Add-Content $mdFile "| :--- | :--- |"
                    Add-Content $mdFile "| **Description** | $($Entry.description) |"
                    if($Entry.execute -eq "1"){
                        Add-Content $mdFile "| **Default** | True |"
                    } else {
                        Add-Content $mdFile "| **Default** | False |"
                    }
                    Add-Content $mdFile "| **Task Path** | $($Params.path) |"
                    Add-Content $mdFile "| **Task State** | $($Params.value) |"
                }

                # Check if process Service
                if(($Action.plugin -eq "Services") -and $Service){
                    write-verbose "Adding Service $($Entry.name)"
                    $Params = $Action.params
                    Add-Content $mdFile "#### $($Entry.name)"
                    Add-Content $mdFile "| **Service** | $($Params.name) |"
                    Add-Content $mdFile "| :--- | :--- |"
                    Add-Content $mdFile "| **Description** | $($Entry.description) |"
                    if($Entry.execute -eq "1"){
                        Add-Content $mdFile "| **Default** | True |"
                    } else {
                        Add-Content $mdFile "| **Default** | False |"
                    }
                    Add-Content $mdFile "| **Service State** | $($Params.value) |"
                }

                # Check if process PowerShell
                if(($Action.plugin -eq "PowerShell") -and $PowerShell){
                    write-verbose "Adding PowerShell Script $($Entry.name)"
                    $Params = $Action.executeparams
                    Add-Content $mdFile "#### $($Entry.name)"
                    Add-Content $mdFile "| **PowerShell** | $($Entry.name) |"
                    Add-Content $mdFile "| :--- | :--- |"
                    Add-Content $mdFile "| **Description** | $($Entry.description) |"
                    if($Entry.execute -eq "1"){
                        Add-Content $mdFile "| **Default** | True |"
                    } else {
                        Add-Content $mdFile "| **Default** | False |"
                    }
                    Add-Content $mdFile "##### Script"
                    Add-Content $mdFile "``````PowerShell"
                    $Script = $params.value
                    Add-Content $mdFile "$($Script.innertext)"
                    Add-Content $mdFile "``````"
                }
            }
        }

    } else {

        # Template file not found
        write-verbose "Citrix Optimizer Template $($Path) not found - quitting"
        write-error "Citrix Optimizer Template $($Path) not found - quitting"

    }

} # process

end {} # end

}
