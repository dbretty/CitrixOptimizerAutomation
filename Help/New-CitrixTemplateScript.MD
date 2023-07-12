# New-CitrixTemplateScript

Creates a new PowerShell Script definition in the Citrix Optimizer template.

## Syntax

```PowerShell
New-CitrixTemplateScript
    [-Path] <String[]>
    [-GroupName] <String[]>
    [-EntryName] <String[]>
    [-EntryDescription] <String[]>
    [-ScriptFile] <String[]>
    [<CommonParameters>]
```
## Description

This function will create PowerShell Script Definition in the Citrix Optimizer template to disable.

## Examples

### Example 1

```PowerShell
New-CitrixTemplateScript -Path 'template.xml' -GroupName 'Group 1' -EntryName 'Stop Windows Update Services' -EntryDescription 'Stops and disables the Windows Update Service' -ScriptFile './disablewu.ps1'
```

Adds a script entry to disable the Windows Update service in the template file.

### Example 2

```PowerShell
New-CitrixTemplateScript -Path $Template.Path -GroupName 'Group 1' -EntryName 'Stop Windows Update Services' -EntryDescription 'Stops and disables the Windows Update Service' -ScriptFile './disablewu.ps1'
```

Adds a script entry to disable the Windows Update service in the template file using the $Template.Path return value.

### Example 3

```PowerShell
New-CitrixTemplateScript -Path $Template.Path -GroupName $Group.Name -EntryName 'Stop Windows Update Services' -EntryDescription 'Stops and disables the Windows Update Service' -ScriptFile './disablewu.ps1'
```

Adds a script entry to disable the Windows Update service in the template file using the $Template.Path return value and the $Group.Name return value.

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

### -GroupName

Specifies the Group to add the Service definition to

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

### -EntryDescription

Specifies the Description to add to the new template

| Description | Option |
|:---|:---|
| Type    | String |
| Mandatory    | True |
| Default Value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -ScriptFile

Specifies the Script File to add to the template

| Description | Option |
|:---|:---|
| Type    | String |
| Mandatory    | True |
| Default Value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |
