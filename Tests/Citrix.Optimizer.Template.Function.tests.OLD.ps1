BeforeAll {

    # AppVeyor Testing
    $projectRoot = "C:\projects\citrixoptimizer"

    # Local Testing 
    # $projectRoot = "./"

}

Describe "Function validation" {
    
    $scripts = Get-ChildItem "$projectRoot\PSGallery" -Recurse -Include *.ps1
    $testCase = $scripts | Foreach-Object {@{file = $_}}         
    It "Script <file> should only contain one function" -TestCases $testCase {
        param($file)   
        $file.fullname | Should -Exist
        $contents = Get-Content -Path $file.fullname -ErrorAction Stop
        $describes = [Management.Automation.Language.Parser]::ParseInput($contents, [ref]$null, [ref]$null)
        $test = $describes.FindAll( {$args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst]}, $true) 
        $test.Count | Should -Be 1
    }

    It "<file> should match function name" -TestCases $testCase {
        param($file)   
        $file.fullname | Should -Exist
        $contents = Get-Content -Path $file.fullname -ErrorAction Stop
        $describes = [Management.Automation.Language.Parser]::ParseInput($contents, [ref]$null, [ref]$null)
        $test = $describes.FindAll( {$args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst]}, $true) 
        $test[0].name | Should -Be $file.basename
    }
}
