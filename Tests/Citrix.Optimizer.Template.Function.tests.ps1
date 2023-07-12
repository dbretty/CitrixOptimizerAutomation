# Pester Before All Section
BeforeAll {}

# Pester Describe Section
Describe "Function validation" {
    
    # Read all script files into a variable
    $scripts = Get-ChildItem "C:\projects\citrixoptimizerautomation\CitrixOptimizerAutomation" -Recurse -Include *.ps1

    # Build a test case of all the scripts
    $testCase = $scripts | Foreach-Object {@{file = $_}}      
    
    # Validate that each ps1 file only contains a single function
    It "Script <file> should only contain one function" -TestCases $testCase {
        param($file)   
        $file.fullname | Should -Exist
        $contents = Get-Content -Path $file.fullname -ErrorAction Stop
        $describes = [Management.Automation.Language.Parser]::ParseInput($contents, [ref]$null, [ref]$null)
        $test = $describes.FindAll( {$args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst]}, $true) 
        $test.Count | Should -Be 1
    }

    # Validate that the ps1 file name matches the function name defined in the file
    It "<file> should match function name" -TestCases $testCase {
        param($file)   
        $file.fullname | Should -Exist
        $contents = Get-Content -Path $file.fullname -ErrorAction Stop
        $describes = [Management.Automation.Language.Parser]::ParseInput($contents, [ref]$null, [ref]$null)
        $test = $describes.FindAll( {$args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst]}, $true) 
        $test[0].name | Should -Be $file.basename
    }
}
