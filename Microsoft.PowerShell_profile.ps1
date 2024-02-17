oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/amro.omp.json" | Invoke-Expression
If (-Not (Test-Path Variable:PSise)) {  # Only run this in the console and not in the ISE
    Import-Module Get-ChildItemColor
    
    Set-Alias l Get-ChildItemColor -option AllScope
    Set-Alias ls Get-ChildItemColorFormatWide -option AllScope 
}
Set-PSReadLineOption -Colors @{ InlinePrediction = "`e[38;2;240;98;146m" }
Set-PSReadLineKeyHandler -Chord "RightArrow" -Function ForwardWord
Import-Module -Name CompletionPredictor
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })
