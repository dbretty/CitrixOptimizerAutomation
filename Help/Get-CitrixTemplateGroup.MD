# Get-CitrixTemplateGroup

Gets Group Entries from the Citrix Optimizer template.

## Syntax

```PowerShell
Get-CitrixTemplate
    [-Path] <String[]>
    [-GroupName] <String[]>
    [<CommonParameters>]
```
## Description

This function will get the Group Entries from a Citrix Optimizer Template passed in

## Examples

### Example 1

```PowerShell
Get-CitrixTemplateGroup -Path 'template.xml' -GroupName 'OS Optimizations'
```

Gets the Group called "OS Optimizations"

### Example 2

```PowerShell
Get-CitrixTemplateGroup -Path $Template.Path -GroupName 'System Optimizations' 
```

Gets the Group called "System Optimizations" in the template file based on the result of a New-CitrixTemplate return object.
 
 ### Example 3

```PowerShell
$Group = Get-CitrixTemplateGroup -Path $Template.Path -GroupName 'System Optimizations' 
```

Gets the Group called "System Optimizations" in the template file based on the result of a New-CitrixTemplate return object and pipes this into the variable $Group.

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

Specifies the Group Name to add

| Description | Option |
|:---|:---|
| Type    | String |
| Mandatory    | True |
| Default Value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |
