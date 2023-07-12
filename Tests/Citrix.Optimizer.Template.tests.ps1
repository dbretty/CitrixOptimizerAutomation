# Pester Before All Section
BeforeAll {

    # Define the manifest and module file locations
    $manifest = "$env:APPVEYOR_BUILD_FOLDER\CitrixOptimizerAutomation\CitrixOptimizerAutomation.psd1"
    $module = "$env:APPVEYOR_BUILD_FOLDER\CitrixOptimizerAutomation\CitrixOptimizerAutomation.psm1"

}

# Pester Describe Section
Describe 'Module Metadata Validation' {   

    # Validate that the manifest file is ok
    it 'Script fileinfo should be ok' {

        {Test-ModuleManifest $manifest} | Should -Not -Throw

    }
        
    # Validate that the module can be loaded ok
    it 'Import module should be ok' {

        {Import-Module $module -Force -ErrorAction Stop} | Should -Not -Throw

    }
    
}
