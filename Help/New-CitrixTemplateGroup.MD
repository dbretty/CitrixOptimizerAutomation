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

### EXAMPLE 1

```PowerShell
New-CitrixTemplateGroup -Path 'template.xml' -GroupName 'OS Optimizations' 
```

Creates a new Group called "OS Optimizations" in the template file.

## Parameters

### -Path

Specifies the Path and Name for the new Template

|  | |
|---|---|
| Type:    | String |
| Default Value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -GroupName

Specifies the Group Name to add to the new template

|  | |
|---|---|
| Type:    | String |
| Default Value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

