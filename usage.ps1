# install Powershell 7
winget install --id Microsoft.Powershell --source winget
# install windows terminal app
winget install -e --id Microsoft.WindowsTerminal

# open windows terminal and select PS7
# in PS7
Install-Module DCToolbox
Confirm-DCPowerShellVersion

# Install the MS Graph PowerShell Module
Install-DCMicrosoftGraphPowerShellModule
Connect-DCMsGraphAsUser -Scopes 'Policy.ReadWrite.ConditionalAccess', 'Policy.Read.All', 'Directory.Read.All'

# list all ConAcc Policies
Get-DCConditionalAccessPolicies

Get-DCNamedLocations

# output a json to the users folder
Export-DCConditionalAccessPolicyDesign

# outputs an excel file to the users folders of policies etc
New-DCConditionalAccessAssignmentReport
New-DCConditionalAccessPolicyDesignReport


################# CAREFULL ######## Interesting for deployment
Set-DCConditionalAccessPoliciesPilotMode -PrefixFilter 'GLOBAL - ' -PilotGroupName 'Conditional Access Pilot' -EnablePilot
    
Set-DCConditionalAccessPoliciesPilotMode -PrefixFilter 'GLOBAL - ' -PilotGroupName 'Conditional Access Pilot' -EnableProduction
Set-DCConditionalAccessPoliciesReportOnlyMode -PrefixFilter 'GLOBAL - ' -SetToEnabled





#################################### Dont Use yet!
Add-DCConditionalAccessPoliciesBreakGlassGroup


    
$Parameters = @{
    FilePath = 'C:\Temp\Conditional Access.json'
}

Get-DCConditionalAccessPolicies


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

