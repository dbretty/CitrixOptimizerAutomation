# New-CitrixTemplateRegistry

Creates a new Windows Registry definition in the Citrix Optimizer template.

## Syntax

```PowerShell
New-CitrixTemplateRegistry
    [-Path] <String[]>
    [-GroupName] <String[]>
    [-EntryName] <String[]>
    [-EntryDescription] <String[]>
    [-ItemName] <String[]>
    [-ItemPath] <String[]>
    [-ItemValue] <String[]>
    [-ItemType] <String[]>
    [-DeleteValue] <Switch>
    [-DeleteKey] <Switch>
    [<CommonParameters>]
```
## Description

This function will create a Registry Definition in the Citrix Optimizer template.

## Examples

### Example 1

```PowerShell
New-CitrixTemplateRegistry -Path 'template.xml' -GroupName 'Group1' -EntryName 'Add Edge Update Registry Entry' -EntryDescription 'Disable Edge Updates via HKLM' -ItemName 'UpdatesEnabled' -ItemPath 'HKLM\Software\Microsoft\Edge' -ItemValue '0' -ItemType 'Dword'
```

Adds an entry to disable the Edge Updates in the template file.

### Example 2

```PowerShell
New-CitrixTemplateRegistry -Path $Template.Path -GroupName 'Group1' -EntryName 'Add Edge Update Registry Entry' -EntryDescription 'Disable Edge Updates via HKLM' -ItemName 'UpdatesEnabled' -ItemPath 'HKLM\Software\Microsoft\Edge' -ItemValue '0' -ItemType 'Dword'
```

Adds an entry to disable the Edge Updates in the template file based on the return value in $Template.Path

### Example 3

```PowerShell
New-CitrixTemplateRegistry -Path $Template.Path -GroupName $Group.Name -EntryName 'Add Edge Update Registry Entry' -EntryDescription 'Disable Edge Updates via HKLM' -ItemName 'UpdatesEnabled' -ItemPath 'HKLM\Software\Microsoft\Edge' -ItemValue '0' -ItemType 'Dword'
```

Adds an entry to disable the Edge Updates in the template file based on the return value in $Template.Path and $Group.Name

### Example 4

```PowerShell
New-CitrixTemplateRegistry -Path $Template.Path -GroupName 'System Optimizations' -EntryName 'Remove Edge Item 1' -EntryDescription 'Remove Edge Item 1' -ItemName 'Item1' -ItemPath 'HKLM\Software\Microsoft\Edge' -DeleteValue
```

Deletes a registry value from the master image

### Example 5

```PowerShell
New-CitrixTemplateRegistry -Path $Template.Path -GroupName 'System Optimizations' -EntryName 'Remove Edge Key 1' -EntryDescription 'Remove Edge Key 1' -ItemPath 'HKLM\Software\Microsoft\Edge1' -DeleteKey
```

Deletes a registry key from the master image

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

Specifies the Group to add the Scheduled Task to

| Description | Option |
|:---|:---|
| Type    | String |
| Mandatory    | True |
| Default Value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -EntryName

Specifies the Entry Name for Citrix Optimizer

| Description | Option |
|:---|:---|
| Type    | String |
| Mandatory    | True |
| Default Value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -EntryDescription

Specifies the Entry Description for Citrix Optimizer

| Description | Option |
|:---|:---|
| Type    | String |
| Mandatory    | True |
| Default Value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -ItemName

Specifies the Item Name for Citrix Optimizer

| Description | Option |
|:---|:---|
| Type    | String |
| Mandatory    | False |
| Default Value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -ItemPath

Specifies the Item Path for Citrix Optimizer

| Description | Option |
|:---|:---|
| Type    | String |
| Mandatory    | True |
| Default Value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -ItemValue

Specifies the Item Value for Citrix Optimizer

| Description | Option |
|:---|:---|
| Type    | String |
| Mandatory    | False |
| Default Value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -ItemType

Specifies the Item Type for Citrix Optimizer ("Dword","Binary","ExpandString","MultiString","String","Qword")

| Description | Option |
|:---|:---|
| Type    | String |
| Mandatory    | False |
| Default Value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |