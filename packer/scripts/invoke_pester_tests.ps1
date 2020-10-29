#Requires -RunAsAdministrator

# invoke all pester tests in the C:\Windows\Temp folder
# output in NUnitXml format so it can be easily imported and parsed
$InvokePesterParams = @{
    Script       = 'C:\Windows\Temp\tests'
    OutputFile   = 'C:\Windows\Temp\tests\test_results.xml'
    OutputFormat = 'NUnitXml'
}
Invoke-Pester @InvokePesterParams
