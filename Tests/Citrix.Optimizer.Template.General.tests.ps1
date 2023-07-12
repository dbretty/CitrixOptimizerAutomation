# Pester Before All Section
BeforeAll {}

# Pester Describe Section
Describe "General project validation" {

    # Read all script files into a variable
    $scripts = Get-ChildItem "C:\projects\citrixoptimizerautomation\CitrixOptimizerAutomation" -Recurse -Include *.ps1, *.psm1

    # Build a test case of all the scripts
    $testCase = $scripts | Foreach-Object {@{file = $_}}    
    
    # Validate the the PowerShell in the ps1 file loads and is valid
    It "Script <file> should be valid powershell" -TestCases $testCase {
        param($file)

        $file.fullname | Should -Exist

        $contents = Get-Content -Path $file.fullname -ErrorAction Stop
        $errors = $null
        $null = [System.Management.Automation.PSParser]::Tokenize($contents, [ref]$errors)
        $errors.Count | Should -Be 0
    }

}
