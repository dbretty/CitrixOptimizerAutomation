[![Build status](https://ci.appveyor.com/api/projects/status/3k4kgk5bsrd2e12o?svg=true)](https://ci.appveyor.com/project/dbretty/citrixoptimizerautomation)

# Citrix Optimizer Automation

PowerShell module to automate the creation of Citrix Optimizer Templates using simple pre-build cmdlets such as:

* New-CitrixTemplate
* New-CitrixTemplateGroup
* New-CitrixTemplateService
* New-CitrixTemplateTask
* New-CitrixTemplateRegistry
* New-CitrixTemplateScript

The reason behind creating this module is the time is takes to build up the template files using the user interface. Often customers have various CSV files and JSON files with the settings you want applied to a master image, with this module you are able to parse those files and inject the settings automatically.

## Installing the Module

### PowerShell Support

Citrix Optimizer Automation supports Windows PowerShell 5.1 and above.

### Install from the PowerShell Gallery

The Citrix Optimizer Automation module is published in the [PowerShell Gallery](https://www.powershellgallery.com/packages/CitrixOptimizerAutomation/) 

You can install the module by entering the below commands in an elevated PowerShell session:

```powershell
Install-Module -Name CitrixOptimizerAutomation
Import-Module -Name CitrixOptimizerAutomation
```

### Updating the Module

If you have installed a previous version of the module from the gallery, you can install the latest update with `Update-Module` and the `-Force` parameter:

```powershell
Update-Module -Name CitrixOptimizerAutomation -Force
```

## Documentation

| <div style="width:550px">Command</div>      | Description |
| ----------- | ----------- |
| [New-CitrixTemplate](Help/New-CitrixTemplate.MD)      | Creates a new Citrix Optimizer base template |
| [New-CitrixTemplateGroup](Help/New-CitrixTemplateGroup.MD)   | Creates a new Group in the Citrix Optimizer template |
| [New-CitrixTemplateService](Help/New-CitrixTemplateService.MD)   | Creates a new Windows Service definition in the Citrix Optimizer template |
| [New-CitrixTemplateTask](Help/New-CitrixTemplateTask.MD)   | Creates a new Windows Scheduled Task definition in the Citrix Optimizer template |
| [New-CitrixTemplateRegistry](Help/New-CitrixTemplateRegistry.MD)   | Creates a new Windows Registry definition in the Citrix Optimizer template |
| [New-CitrixTemplateScript](Help/New-CitrixTemplateScript.MD)   | Creates a new PowerShell Script definition in the Citrix Optimizer template |

## Recommended Content

[Citrix Optimizer Tool](https://support.citrix.com/article/CTX224676/citrix-optimizer-tool) (Citrix docs)
The official Citrix Optimizer tool.
