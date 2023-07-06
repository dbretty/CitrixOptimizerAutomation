# New-CitrixTemplate

Creates a new Citrix Optimizer Base Template.

## Syntax

```PowerShell
New-CitrixTemplate
    [-Path] <String[]>
    [-DisplayName] <String[]>
    [-Description] <String[]>
    [-Author] <String[]>
    [<CommonParameters>]
```
## Description

This function will create a new Citrix Optimizer base template with the parameters passed in. It will auto generate a new GUID and Last Updated date based upon when the function is run.

## Examples

### EXAMPLE 1

```PowerShell
New-CitrixTemplate -Path 'template.xml' -DisplayName 'Citrix Optimization Template' -Description 'This is a new Citrix Optimization template' -Author 'Dave Brett'
```

Generates a new template file with the above values.

## Parameters

### -Path

Specifies the Path and Name for the new Template

|  | |
|---|---|
| Type:    | String |
| Default Value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -DisplayName

Specifies the Display Name for the new template

|  | |
|---|---|
| Type:    | String |
| Default Value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -Description

Specifies the Description for the new template

|  | |
|---|---|
| Type:    | String |
| Default Value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -Author

Specifies the Author for the new template

|  | |
|---|---|
| Type:    | String |
| Default Value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |
