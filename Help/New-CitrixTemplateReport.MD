# New-CitrixTemplateReport

Creates a new Citrix Optimizer Template report.

## Syntax

```PowerShell
New-CitrixTemplateReport
    [-Path] <String[]>
    [-Registry] <Switch[]>
    [-ScheduledTask] <Switch[]>
    [-Service] <Switch[]>
    [-PowerShell] <Switch[]>
    [<CommonParameters>]
```
## Description

This function will create a markdown report based on the template passed in.

## Examples

### Example 1

```PowerShell
New-CitrixTemplateReport -Path 'template.xml' 
```

Creates a new report from the template.xml file

### Example 2

```PowerShell
New-CitrixTemplateReport -Path 'template.xml' -Registry
```

Creates a new report from the template.xml file with only the Registry entries present.
 
 ### Example 3

```PowerShell
New-CitrixTemplateReport -Path 'template.xml' -Registry -Service
```

Creates a new report from the template.xml file with the Registry and Service entries present.

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

### -Registry

Switch for Registry

| Description | Option |
|:---|:---|
| Type    | Switch |
| Mandatory    | False |
| Default Value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -ScheduledTask

Switch for ScheduledTask

| Description | Option |
|:---|:---|
| Type    | Switch |
| Mandatory    | False |
| Default Value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -Service

Switch for Service

| Description | Option |
|:---|:---|
| Type    | Switch |
| Mandatory    | False |
| Default Value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -PowerShell

Switch for PowerShell

| Description | Option |
|:---|:---|
| Type    | Switch |
| Mandatory    | False |
| Default Value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |
