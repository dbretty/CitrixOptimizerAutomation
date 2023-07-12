# This short PowerShell Script is used to validate the module and ensure that the commands are operational before committing back to GitHub
# Feel free to use these examples in your own scripts to generate a Citrix Optimizer Template
# These cmdlets are used 'as-is' and I take no responsibility for them, please test before using this in a production environment

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

# Create Registry Values
New-CitrixTemplateRegistry -Path $Template.Path -GroupName 'System Optimizations' -EntryName 'Add Edge Update Registry Entry' -EntryDescription 'Disable Edge Updates via HKLM' -ItemName 'UpdatesEnabled' -ItemPath 'HKLM\Software\Microsoft\Edge' -ItemValue '0' -ItemType 'Dword'
New-CitrixTemplateRegistry -Path $Template.Path -GroupName 'System Optimizations' -EntryName 'Add Edge Sandbox' -EntryDescription 'Enable Edge Sandbox' -ItemName 'Sandbox' -ItemPath 'HKLM\Software\Microsoft\Edge' -ItemValue 'Enabled' -ItemType 'String'
New-CitrixTemplateRegistry -Path $Template.Path -GroupName 'System Optimizations' -EntryName 'Add Edge Extensions' -EntryDescription 'Disable Edge Extensions' -ItemName 'ExtensionsDisabled' -ItemPath 'HKLM\Software\Microsoft\Edge' -ItemValue '1' -ItemType 'Dword'

# Remove Registry Values
New-CitrixTemplateRegistry -Path $Template.Path -GroupName 'System Optimizations' -EntryName 'Remove Edge Item 1' -EntryDescription 'Remove Edge Item 1' -ItemName 'Item1' -ItemPath 'HKLM\Software\Microsoft\Edge' -DeleteValue
New-CitrixTemplateRegistry -Path $Template.Path -GroupName 'System Optimizations' -EntryName 'Remove Edge Item 2' -EntryDescription 'Remove Edge Item 2' -ItemName 'Item2' -ItemPath 'HKLM\Software\Microsoft\Edge' -DeleteValue
New-CitrixTemplateRegistry -Path $Template.Path -GroupName 'System Optimizations' -EntryName 'Remove Edge Item 3' -EntryDescription 'Remove Edge Item 3' -ItemName 'Item3' -ItemPath 'HKLM\Software\Microsoft\Edge' -DeleteValue

# Remove Registry Keys
New-CitrixTemplateRegistry -Path $Template.Path -GroupName 'System Optimizations' -EntryName 'Remove Edge Key 1' -EntryDescription 'Remove Edge Key 1' -ItemPath 'HKLM\Software\Microsoft\Edge1' -DeleteKey
New-CitrixTemplateRegistry -Path $Template.Path -GroupName 'System Optimizations' -EntryName 'Remove Edge Key 2' -EntryDescription 'Remove Edge Key 2' -ItemPath 'HKLM\Software\Microsoft\Edge2' -DeleteKey
New-CitrixTemplateRegistry -Path $Template.Path -GroupName 'System Optimizations' -EntryName 'Remove Edge Key 3' -EntryDescription 'Remove Edge Key 3' -ItemPath 'HKLM\Software\Microsoft\Edge3' -DeleteKey

