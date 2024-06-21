# install Powershell 7
winget install --id Microsoft.Powershell --source winget

Install-Module DCToolbox
Confirm-DCPowerShellVersion


Install-DCMicrosoftGraphPowerShellModule
Connect-DCMsGraphAsUser -Scopes 'Policy.ReadWrite.ConditionalAccess', 'Policy.Read.All', 'Directory.Read.All'

Add-DCConditionalAccessPoliciesBreakGlassGroup

Copy-DCExample
Export-DCConditionalAccessPolicyDesign
    
$Parameters = @{
    FilePath = 'C:\Temp\Conditional Access.json'
}

Get-DCConditionalAccessPolicies

Get-DCNamedLocations
Get-DCPublicIp
Import-DCConditionalAccessPolicyDesign @Parameters    
$Parameters = @{
    FilePath = 'C:\Temp\Conditional Access.json'
    SkipReportOnlyMode = $false
    DeleteAllExistingPolicies = $false
}

# Run basic evaluation with default settings.
Invoke-DCConditionalAccessSimulation | Format-List
Invoke-DCConditionalAccessSimulation @Parameters    
# Run evaluation with custom settings.
$Parameters = @{
    UserPrincipalName = 'user@example.com'
    ApplicationDisplayName = 'Office 365'
    ClientApp = 'mobileAppsAndDesktopClients'
    TrustedIPAddress = $true
    Country = 'US'
    Platform = 'windows'
    SignInRiskLevel = 'medium'
    UserRiskLevel = 'high'
    SummarizedOutput = $true
    VerbosePolicyEvaluation = $false
    IncludeNonMatchingPolicies = $false
New-DCConditionalAccessAssignmentReport
New-DCConditionalAccessPolicyDesignReport
Set-DCConditionalAccessPoliciesPilotMode -PrefixFilter 'GLOBAL - ' -PilotGroupName 'Conditional Access Pilot' -EnablePilot
    
Set-DCConditionalAccessPoliciesPilotMode -PrefixFilter 'GLOBAL - ' -PilotGroupName 'Conditional Access Pilot' -EnableProduction
Set-DCConditionalAccessPoliciesReportOnlyMode -PrefixFilter 'GLOBAL - ' -SetToEnabled
