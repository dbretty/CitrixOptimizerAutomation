# This short PowerShell Script is used to validate the module and ensure that the commands are operational before committing back to GitHub
# Feel free to use these examples in your own scripts to generate a Citrix Optimizer Template
# These cmdlets are used 'as-is' and I take no responsibility for them

# Define Template Name
$TemplateName = 'sample-template.xml'

# Remove and re-import the module
Remove-Module CitrixOptimizerAutomation
Import-Module ./CitrixOptimizerAutomation 

# Create a new Template
$Template = New-CitrixTemplate -Path $TemplateName -DisplayName 'Example Citrix Optimization Template' -Description 'This is a new Citrix Optimization template' -Author 'Dave Brett'

# Create Initial Group
New-CitrixTemplateGroup -Path $Template.Path -GroupName 'System Optimizations' -GroupDescription "System Optimization Group"
New-CitrixTemplateGroup -Path $Template.Path -GroupName 'OS Optimizations' -GroupDescription "OS Optimization Group"
New-CitrixTemplateGroup -Path $Template.Path -GroupName 'HKLM Optimizations' -GroupDescription "HKLM Optimization Group"

# Create Service Entries
New-CitrixTemplateService -Path $Template.Path -EntryName 'Disable the Print Spooler' -ServiceName 'spooler' -ServiceDescription 'Windows Print Service' -GroupName 'System Optimizations' -State "Disabled"
New-CitrixTemplateService -Path $Template.Path -EntryName 'Disable the AppID Service' -ServiceName 'AppID' -ServiceDescription 'AppID Service' -GroupName 'System Optimizations' -State "Disabled"
New-CitrixTemplateService -Path $Template.Path -EntryName 'Disable the Citrix Primt Management' -ServiceName 'CpSvc' -ServiceDescription 'Citrix Print Service' -GroupName 'System Optimizations' -State "Disabled"

# Create Scheduled Task Entries
New-CitrixTemplateTask -Path $Template.Path -GroupName 'System Optimizations' -TaskName 'SchTask - AppID' -TaskPath '\Microsoft\Windows\AppID\' -TaskDescription 'This is the AppID Scheduled Task' -State "Disabled"
New-CitrixTemplateTask -Path $Template.Path -GroupName 'System Optimizations' -TaskName 'SchTask - OfficeUpdate' -TaskPath '\Microsoft\Windows\Office\Update\' -TaskDescription 'This is the Office Update Scheduled Task' -State "Disabled"
New-CitrixTemplateTask -Path $Template.Path -GroupName 'System Optimizations' -TaskName 'SchTask - Microsoft Edge Update' -TaskPath '\Microsoft\Edge\Update\' -TaskDescription 'This is the Microsoft Edge Update Scheduled Task' -State "Disabled"

