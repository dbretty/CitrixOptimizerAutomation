# Get-CitrixTemplate

Gets a Citrix Optimizer Template.

## Syntax

```PowerShell
Get-CitrixTemplate
    [-Path] <String[]>
    [<CommonParameters>]
```
## Description

This function will get a Citrix Optimizer Template and return the Template Path and Template Contents.

## Examples

### Example 1

```PowerShell
Get-CitrixTemplate -Path 'template.xml'
```

Gets 'template.xml' and returns the XML as part of the Object'.

## Parameters

### -Path

Specifies the Path for the Citrix Optimizer Template

| Description | Option |
|:---|:---|
| Type    | String |
| Mandatory    | True |
| Default Value | None |
| Accept pipeline input | True |
| Accept wildcard characters | False |
