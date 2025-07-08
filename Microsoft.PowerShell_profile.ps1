# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/amro.omp.json" | Invoke-Expression
function Invoke-Starship-TransientFunction {
  &starship module character
}

Invoke-Expression (&starship init powershell)
Enable-TransientPrompt


Set-Alias -Name l -Value Eza-l -option AllScope
Set-Alias -Name ls -Value Eza-ls -option AllScope
Set-Alias -Name cat -Value bat
Set-Alias -Name python3 -Value python

function Eza-l() {
    eza -l --git --grid --time-style relative -a
}
function Eza-ls() {
    eza -l --git --time-style relative -a
}

function Yazi-yy() {
    $tmp = [System.IO.Path]::GetTempFileName()
        yazi $args --cwd-file="$tmp"
        $cwd = Get-Content -Path $tmp
        if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
            Set-Location -LiteralPath $cwd
        }
    Remove-Item -Path $tmp
}

Set-Alias -Name yy -Value Yazi-yy -option ALLScope

$null = Register-EngineEvent -SourceIdentifier 'PowerShell.OnIdle' -MaxTriggerCount 1 -Action {

    Set-PSReadLineOption -Colors @{ InlinePrediction = 'Green' }

# If (-Not (Test-Path Variable:PSise)) {  # Only run this in the console and not in the ISE
#     Import-Module Get-ChildItemColor
#     
#     Set-Alias l Get-ChildItemColor -option AllScope
#     Set-Alias ls Get-ChildItemColorFormatWide -option AllScope
# }
#
    Import-Module -Name CompletionPredictor
    Set-PSReadLineOption -PredictionSource HistoryAndPlugin
    Set-PSReadLineOption -Colors @{ InlinePrediction = "`e[38;2;240;98;146m" }
    Set-PSReadLineKeyHandler -Chord "RightArrow" -Function ForwardWord
    Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })


# For the taskList -> pip install pls-cli
    pls


}
