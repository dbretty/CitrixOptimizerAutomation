# Get-CitrixTemplateEntry

Gets Entries from the Citrix Optimizer template.

## Syntax

```PowerShell
Get-CitrixTemplateEntry
    [-Path] <String[]>
    [-EntryName] <String[]>
    [-Registry] <Switch[]>
    [-ScheduledTask] <Switch[]>
    [-Service] <Switch[]>
    [-PowerShell] <Switch[]>
    [<CommonParameters>]
```
## Description

This function will get the Entries from a Citrix Optimizer Template passed in

## Examples

### Example 1

```PowerShell
Get-CitrixTemplateEntry -Path 'template.xml' -EntryName "Optimize Internet Explorer"
```

Gets the entry details for the entry "Optimize Internet Explorer".

### Example 2

```PowerShell
Get-CitrixTemplateEntry -Path 'template.xml' -Registry
```

Gets all the Registry Entries from the Template File.
 
 ### Example 3

```PowerShell
$Entries = Get-CitrixTemplateEntry -Path 'template.xml' -Service
```

Gets all the Service Entries from the template and assigns the result to the $Entries variable.

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

Specifies the Entry Name

| Description | Option |
|:---|:---|
| Type    | String |
| Mandatory    | False |
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
