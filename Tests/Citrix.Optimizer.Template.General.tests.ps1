BeforeAll {

    # AppVeyor Testing
    #$projectRoot = $env:APPVEYOR_BUILD_FOLDER

    # Local Testing 
    $projectRoot = "./"
    $Path = "./Template/CitrixOptimizerTemplate.xml"

}

Describe "General project validation" {

    $scripts = Get-ChildItem "$projectRoot\PSGallery" -Recurse -Include *.ps1, *.psm1

    # TestCases are splatted to the script so we need hashtables
    $testCase = $scripts | Foreach-Object {@{file = $_}}         
    It "Script <file> should be valid powershell" -TestCases $testCase {
        param($file)

        $file.fullname | Should -Exist

        $contents = Get-Content -Path $file.fullname -ErrorAction Stop
        $errors = $null
        $null = [System.Management.Automation.PSParser]::Tokenize($contents, [ref]$errors)
        $errors.Count | Should -Be 0
    }

    $scriptAnalyzerRules = Get-ScriptAnalyzerRule
    It "<file> should pass ScriptAnalyzer" -TestCases $testCase {
        param($file)
        $analysis = Invoke-ScriptAnalyzer -Path  $file.fullname -ExcludeRule @('PSAvoidUsingConvertToSecureStringWithPlainText','PSReviewUnusedParameter') -Severity @('Warning', 'Error')   
        
        forEach ($rule in $scriptAnalyzerRules) {        
            if ($analysis.RuleName -contains $rule) {
                $analysis |
                    Where-Object RuleName -EQ $rule -outvariable failures |
                    Out-Default
                $failures.Count | Should -Be 0
            }
            
        }
    }

}
