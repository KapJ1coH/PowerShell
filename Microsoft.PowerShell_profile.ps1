oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/amro.omp.json" | Invoke-Expression
Set-PSReadLineOption -Colors @{ InlinePrediction = 'Green' }

# If (-Not (Test-Path Variable:PSise)) {  # Only run this in the console and not in the ISE
#     Import-Module Get-ChildItemColor
#     
#     Set-Alias l Get-ChildItemColor -option AllScope
#     Set-Alias ls Get-ChildItemColorFormatWide -option AllScope
# }
Import-Module -Name CompletionPredictor
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -Colors @{ InlinePrediction = "`e[38;2;240;98;146m" }
Set-PSReadLineKeyHandler -Chord "RightArrow" -Function ForwardWord
Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })
Set-Alias -Name l -Value Eza-l -option AllScope
Set-Alias -Name ls -Value Eza-ls -option AllScope
Set-Alias -Name cat -Value bat

function Eza-l() {
    eza -l --git --grid --time-style relative
}
function Eza-ls() {
    eza -l --git --time-style relative
}


# For the taskList -> pip install pls-cli
pls
