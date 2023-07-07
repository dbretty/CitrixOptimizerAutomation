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

This function will create a new Citrix Optimizer base template with the parameters passed in. It will auto generate a new GUID and Last Updated date based upon the time the function is run.

## Examples

### Example 1

```PowerShell
New-CitrixTemplate -Path 'template.xml' -DisplayName 'Citrix Optimization Template' -Description 'This is a new Citrix Optimization template' -Author 'Dave Brett'
```

Generates a new template file with the above values.

### EXAMPLE 2

```PowerShell
$Template = New-CitrixTemplate -Path 'template.xml' -DisplayName 'Citrix Optimization Template' -Description 'This is a new Citrix Optimization template' -Author 'Dave Brett'
```

Generates a new template file with the above values and assigns the return object to the variable $Template

## Parameters

### -Path

Specifies the full Path and Name for the new Template

| Description | Option |
|:---|:---|
| Type    | String |
| Mandatory    | True |
| Default Value | None |
| Accept pipeline input | True |
| Accept wildcard characters | False |

### -DisplayName

Specifies the Display Name

| Description | Option |
|:---|:---|
| Type    | String |
| Mandatory    | True |
| Default Value | None |
| Accept pipeline input | True |
| Accept wildcard characters | False |

### -Description

Specifies the Description

| Description | Option |
|:---|:---|
| Type    | String |
| Mandatory    | True |
| Default Value | None |
| Accept pipeline input | True |
| Accept wildcard characters | False |

### -Author

Specifies the Author

| Description | Option |
|:---|:---|
| Type    | String |
| Mandatory    | True |
| Default Value | None |
| Accept pipeline input | True |
| Accept wildcard characters | False |
