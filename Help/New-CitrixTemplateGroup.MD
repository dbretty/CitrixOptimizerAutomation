# New-CitrixTemplateGroup

Creates a new Group in the Citrix Optimizer template.

## Syntax

```PowerShell
New-CitrixTemplate
    [-Path] <String[]>
    [-GroupName] <String[]>
    [<CommonParameters>]
```
## Description

This function will create a Group in the Citrix Optimizer template. First it will check if that group exists, if not it will add it.

## Examples

### Example 1

```PowerShell
New-CitrixTemplateGroup -Path 'template.xml' -GroupName 'OS Optimizations' 
```

Creates a new Group called "OS Optimizations" in the template file.

### Example 2

```PowerShell
New-CitrixTemplateGroup -Path $Template.Path -GroupName 'System Optimizations' 
```

Creates a new Group called "System Optimizations" in the template file based on the result of a ```New-CitrixTemplate``` return object.
 
## Parameters

### -Path

Specifies the Path and Name for the Template to update

| Description | Option |
|:---|:---|
| Type    | String |
| Mandatory    | True |
| Default Value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -GroupName

Specifies the Group Name to add

| Description | Option |
|:---|:---|
| Type    | String |
| Mandatory    | True |
| Default Value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

