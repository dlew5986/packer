#Requires -RunAsAdministrator

[xml]$testResults = Get-Content -Path 'C:\Windows\Temp\tests\test_results.xml'

$totalIssues = [int]$($testResults.'test-results'.'errors') +
               [int]$($testResults.'test-results'.'failures') +
               [int]$($testResults.'test-results'.'not-run') +
               [int]$($testResults.'test-results'.'inconclusive') +
               [int]$($testResults.'test-results'.'ignored') +
               [int]$($testResults.'test-results'.'skipped') +
               [int]$($testResults.'test-results'.'invalid')

exit $totalIssues
