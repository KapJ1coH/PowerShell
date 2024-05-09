oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/amro.omp.json" | Invoke-Expression
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
Import-Module PSReadLine
Set-PSReadLineKeyHandler -Chord Tab -Function MenuComplete
$scriptblock = {
    param($wordToComplete, $commandAst, $cursorPosition)
    $Env:_PLS_COMPLETE = "complete_powershell"
    $Env:_TYPER_COMPLETE_ARGS = $commandAst.ToString()
    $Env:_TYPER_COMPLETE_WORD_TO_COMPLETE = $wordToComplete
    pls | ForEach-Object {
        $commandArray = $_ -Split ":::"
        $command = $commandArray[0]
        $helpString = $commandArray[1]
        [System.Management.Automation.CompletionResult]::new(
            $command, $command, 'ParameterValue', $helpString)
    }
    $Env:_PLS_COMPLETE = ""
    $Env:_TYPER_COMPLETE_ARGS = ""
    $Env:_TYPER_COMPLETE_WORD_TO_COMPLETE = ""
}
Register-ArgumentCompleter -Native -CommandName pls -ScriptBlock $scriptblock
