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
    [-State] <String[]>
    [<CommonParameters>]
```
## Description

This function will create a Scheduled Task Definition in the Citrix Optimizer template.

## Examples

### Example 1

```PowerShell
New-CitrixTemplateTask -Path 'template.xml' -Group 'Group1' -TaskName 'SchTask - AppID' -TaskPath '\Microsoft\Windows\AppID\' -TaskDescription 'This is the AppID Scheduled Task' -State "Disabled"
```

Adds an entry to disable the AppID Scheduled Task in the template file.

### Example 2

```PowerShell
New-CitrixTemplateTask -Path $Template.Path -GroupName 'Group1' -TaskName 'SchTask - AppID' -TaskPath '\Microsoft\Windows\AppID\' -TaskDescription 'This is the AppID Scheduled Task' -State "Disabled"
```

Adds an entry to disable the AppID Scheduled Task in the template file based on the return value in $Template.Path

### Example 3

```PowerShell
New-CitrixTemplateTask -Path $Template.Path -GroupName $Group.Name -TaskName 'SchTask - AppID' -TaskPath '\Microsoft\Windows\AppID\' -TaskDescription 'This is the AppID Scheduled Task' -State "Disabled"
```

Adds an entry to disable the AppID Scheduled Task in the template file based on the return value in $Template.Path and $Group.Name

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

### -TaskName

The Display Name for the Scheduled Task in Citrix Optimizer

| Description | Option |
|:---|:---|
| Type    | String |
| Mandatory    | True |
| Default Value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -TaskPath

The Full Path to the Scheduled Task

| Description | Option |
|:---|:---|
| Type    | String |
| Mandatory    | True |
| Default Value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -TaskDescription

The Description for the Scheduled Task

| Description | Option |
|:---|:---|
| Type    | String |
| Mandatory    | True |
| Default Value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -State

Specifies the Service State (Enabled/Disabled)

| Description | Option |
|:---|:---|
| Type    | String |
| Mandatory    | True |
| Default Value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |