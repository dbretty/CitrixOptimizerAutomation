# New-CitrixTemplateTask

Creates a new Windows Scheduled Task definition in the Citrix Optimizer template.

## Syntax

```PowerShell
New-CitrixTemplateTask
    [-Path] <String[]>
    [-GroupName] <String[]>
    [-TaskName] <String[]>
    [-TaskPath] <String[]>
    [-TaskDescription] <String[]>
    [<CommonParameters>]
```
## Description

This function will create a Scheduled Task Definition in the Citrix Optimizer template.

## Examples

### EXAMPLE 1

```PowerShell
New-CitrixTemplateTask -Path 'template.xml' -Group 'Group1' -TaskName 'SchTask - AppID' -TaskPath '\Microsoft\Windows\AppID\' -TaskDescription 'This is the AppID Scheduled Task'
```

Adds an entry to disable the AppID Scheduled Task in the template file.

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

Specifies the Group in the template file to add the Scheduled Task to

|  | |
|---|---|
| Type:    | String |
| Default Value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -TaskName

The Display Name for the Scheduled Task in Citrix Optimizer

|  | |
|---|---|
| Type:    | String |
| Default Value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -TaskPath

The Full Path to the Scheduled Task

|  | |
|---|---|
| Type:    | String |
| Default Value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -TaskDescription

The Description for the Scheduled Task

|  | |
|---|---|
| Type:    | String |
| Default Value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |