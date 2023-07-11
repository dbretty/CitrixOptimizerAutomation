# New-CitrixTemplateService

Creates a new Windows Service definition in the Citrix Optimizer template.

## Syntax

```PowerShell
New-CitrixTemplateService
    [-Path] <String[]>
    [-EntryName] <String[]>
    [-ServiceName] <String[]>
    [-ServiceDescription] <String[]>
    [-GroupName] <String[]>
    [<CommonParameters>]
```
## Description

This function will create Service Definition in the Citrix Optimizer template.

## Examples

### Example 1

```PowerShell
New-CitrixTemplateService -Path 'template.xml' -EntryName 'Disable the Print Spooler' -ServiceName 'spooler' -ServiceDescription 'Windows Print Service' -GroupName 'Group 1'
```

Adds an entry to disable the Print Spooler service in the template file.

### Example 2

```PowerShell
New-CitrixTemplateService -Path $Template.Path -EntryName 'Disable the Print Spooler' -ServiceName 'spooler' -ServiceDescription 'Windows Print Service' -GroupName 'Group 1'
```

Adds an entry to disable the Print Spooler service in the template file passed in via the output from the ```New-CitrixTemplate``` cmdlet.

### Example 3

```PowerShell
New-CitrixTemplateService -Path 'template.xml' -EntryName 'Disable the Print Spooler' -ServiceName 'spooler' -ServiceDescription 'Windows Print Service' -GroupName $Group.GroupName
```

Adds an entry to disable the Print Spooler service in the template file passed in via the output from the ```New-CitrixTemplate``` cmdlet and the Group Name passed in via the output $Group.GroupName.

## Parameters

### -Path

Specifies the Path and Name for the Citrix Optimizer Template

| Description | Option |
|:---|:---|
| Type    | String |
| Mandatory    | True |
| Default Value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -EntryName

Specifies the Display Name to add to the new template

| Description | Option |
|:---|:---|
| Type    | String |
| Mandatory    | True |
| Default Value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -ServiceName

Specifies the Service Name to disable

| Description | Option |
|:---|:---|
| Type    | String |
| Mandatory    | True |
| Default Value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -ServiceDescription

Specifies the Service Description to add to the template

| Description | Option |
|:---|:---|
| Type    | String |
| Mandatory    | True |
| Default Value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -GroupName

Specifies the Group to add the Service definition to

| Description | Option |
|:---|:---|
| Type    | String |
| Mandatory    | True |
| Default Value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |