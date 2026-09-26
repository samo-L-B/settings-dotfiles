## PowerShell Profile LAX dipshit modifications - version 1.02 (updated 09/2026)
## Changelog 1.02: self-healing Terminal-Icons, visible module errors, icon-first ll,
##                 fixed alias/function conflicts (ll, ls, grep, gc, gp), fixed broken returns,
##                 PS-update check no longer auto-installs, safer Windows Terminal edits

# path of this profile file (used by Edit-Profile / reload-profile)
$global:LaxProfilePath = $PSCommandPath

# indiviudal greeting
Write-Host "こんにちは bitches - 躾" -ForegroundColor Yellow
Write-Host "olá beleza! great to see ur lazy ass! checking for PS-updates..." -ForegroundColor Cyan
#startup config: UTF-8 encoding & checks admin & opt-out telemetry & tests GitHub connectivity & checks for PS-updates
$originalTitle = $Host.UI.RawUI.WindowTitle
trap { $Host.UI.RawUI.WindowTitle = $originalTitle }
[Console]::InputEncoding = [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
$global:IsAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if ($global:IsAdmin -and [System.Environment]::GetEnvironmentVariable('POWERSHELL_TELEMETRY_OPTOUT', 'Machine') -ne 'true') {
    [System.Environment]::SetEnvironmentVariable('POWERSHELL_TELEMETRY_OPTOUT', 'true', [System.EnvironmentVariableTarget]::Machine)}
$adminIndicator = if ($global:IsAdmin) { " [ADMIN]" } else { "" }
$Host.UI.RawUI.WindowTitle = "PowerShell $($PSVersionTable.PSVersion)$adminIndicator"
$global:canConnectToGitHub = $false
try {$null = Invoke-WebRequest -Uri "https://github.com" -UseBasicParsing -TimeoutSec 1 -ErrorAction Stop
    $global:canConnectToGitHub = $true} catch {}
if ($global:IsAdmin) {Write-Host "just fyi: Você é um administrador respeito idiota!" -ForegroundColor Green}
else {Write-Host "just fyi: Você não é um administrador dipshit!" -ForegroundColor Red}

# checks for a new PowerShell release; only installs when you run: Update-PowerShell -Install
function Update-PowerShell {
    param([switch]$Install)
    if (-not $global:canConnectToGitHub) {
        Write-Host "Skipping PS-update check – GitHub didn't respond in time." -ForegroundColor Yellow
        return}
    try {
        $v = $PSVersionTable.PSVersion
        $currentVersion = [Version]::new($v.Major, $v.Minor, $v.Patch)
        $latestRelease = Invoke-RestMethod -Uri "https://api.github.com/repos/PowerShell/PowerShell/releases/latest" -TimeoutSec 3 -ErrorAction Stop
        $latestVersion = [Version]($latestRelease.tag_name -replace '^v')
        if ($currentVersion -lt $latestVersion) {
            if ($Install) {
                Write-Host "alrighty, PowerShell $latestVersion is out – time to update..." -ForegroundColor Yellow
                winget upgrade "Microsoft.PowerShell" --accept-source-agreements --accept-package-agreements
                Write-Host "Done! Restart your shell to reflect the new hotness. 🔥" -ForegroundColor Magenta}
            else {
                Write-Host "PowerShell $latestVersion is out (you have $currentVersion) – run 'Update-PowerShell -Install' when ready" -ForegroundColor Yellow}}
        else {Write-Host "your PowerShell (version $currentVersion) is up to date – vamos idiota 🚀" -ForegroundColor Green}}
    catch {Write-Warning "Failed to check PowerShell version: $_"}}
Update-PowerShell

# import autohotkey automation (desktop switch) – starts only if not already running
$global:AhkExe    = "C:\Program Files\AutoHotkey\v2\AutoHotkey64.exe"
$global:AhkScript = "C:\Users\leon\.config\AutoHotkey\desktopkeys.ahk"
function Get-DesktopKeysProcess {
    Get-CimInstance Win32_Process -Filter "Name='AutoHotkey64.exe'" -ErrorAction SilentlyContinue |
        Where-Object { $_.CommandLine -like "*desktopkeys.ahk*" }}
function ahk-reload {
    Get-DesktopKeysProcess | ForEach-Object { Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue }
    if ((Test-Path $global:AhkExe) -and (Test-Path $global:AhkScript)) {
        Start-Process $global:AhkExe "`"$global:AhkScript`""
        Write-Host "desktopkeys.ahk (re)started ✓" -ForegroundColor Green}}
if ((Test-Path $global:AhkExe) -and (Test-Path $global:AhkScript) -and -not (Get-DesktopKeysProcess)) {
    Start-Process $global:AhkExe "`"$global:AhkScript`""}

# IMPORT MODULES
# Terminal-Icons rewrites its theme XML on every load; if two shells start at once the file can get corrupted.
# This checks the files and resets them if they can't be read.
function Repair-TerminalIconsData {
    $tiData = Join-Path $env:APPDATA 'powershell\Community\Terminal-Icons'
    if (-not (Test-Path $tiData)) { return }
    foreach ($xml in Get-ChildItem $tiData -Filter *.xml -ErrorAction SilentlyContinue) {
        try { $null = Import-Clixml $xml.FullName -ErrorAction Stop }
        catch {
            Write-Host "⚠ Terminal-Icons settings corrupted – resetting them..." -ForegroundColor Yellow
            Remove-Item $tiData -Recurse -Force -ErrorAction SilentlyContinue
            return}}}

function Import-ModuleIfAvailable {
    param([string]$ModuleName,
          [switch]$Install)
    if (-not (Get-Module -ListAvailable -Name $ModuleName) -and $Install) {
        Write-Host "Installing $ModuleName..." -ForegroundColor Cyan
        Install-Module -Name $ModuleName -Scope CurrentUser -Force -SkipPublisherCheck -AllowClobber}
    if (-not (Get-Module -ListAvailable -Name $ModuleName)) { return $false }
    if ($ModuleName -eq 'Terminal-Icons') { Repair-TerminalIconsData }
    try {
        Import-Module $ModuleName -ErrorAction Stop
        if (Get-Module -Name $ModuleName) { return $true }
        throw "module did not load"}
    catch {
        Write-Host "⚠ Failed to load ${ModuleName}: $($_.Exception.Message)" -ForegroundColor Red
        return $false}}
Import-ModuleIfAvailable -ModuleName "posh-git" -Install | Out-Null
Import-ModuleIfAvailable -ModuleName "Terminal-Icons" -Install | Out-Null
Import-ModuleIfAvailable -ModuleName "z" -Install | Out-Null
Import-ModuleIfAvailable -ModuleName "PSFzf" -Install | Out-Null
Import-ModuleIfAvailable -ModuleName "PSReadLine" | Out-Null
Import-ModuleIfAvailable -ModuleName "ImportExcel" -Install | Out-Null

$ompConfig = "$HOME\.config\powershell\LAX.omp.json"
if ((Test-Path $ompConfig) -and (Get-Command oh-my-posh -ErrorAction SilentlyContinue)) {
    oh-my-posh init pwsh --config $ompConfig | Invoke-Expression}
$chocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path $chocolateyProfile) {Import-Module $chocolateyProfile}

#region Utility Functions
function Test-CommandExists {param([string]$Command)
    return $null -ne (Get-Command $Command -ErrorAction SilentlyContinue)}

# editor
$EDITOR = @('nvim', 'pvim', 'vim', 'vi', 'code', 'notepad++', 'sublime_text', 'notepad') |
    Where-Object { Test-CommandExists $_ } | Select-Object -First 1
if ($EDITOR -and $EDITOR -ne 'vim') {Set-Alias -Name vim -Value $EDITOR -Force -ErrorAction SilentlyContinue}

# background for terminal:
## Path to store original background image path temporarily
$global:OriginalBackgroundFile = "$env:TEMP\wt_original_background.txt"

function Get-WTSettingsPath {
    @("$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json",
      "$env:LOCALAPPDATA\Microsoft\Windows Terminal\settings.json") |
        Where-Object { Test-Path $_ } | Select-Object -First 1}

function backgroundbernie {
    param([string]$ImagePath = "C:\Users\leon\Documents\GitHub\settings-dotfiles\desktop-screensaver\tumblr_ac2c7b4452076210d313e3423e08c1af_66f7ba5b_500.jpeg")
    $settingsPath = Get-WTSettingsPath
    if (-not $settingsPath) {
        Write-Host "Windows Terminal settings.json not found"
        return}
    $json = Get-Content $settingsPath -Raw | ConvertFrom-Json
    $wtProfile = $json.profiles.list | Where-Object { $_.name -eq "PowerShell" } | Select-Object -First 1
    if ($null -eq $wtProfile) {
        Write-Host "PowerShell profile not found in settings."
        return}
    # Save original background image to a file if it doesn't already exist
    if (-not (Test-Path $global:OriginalBackgroundFile)) {
        "$($wtProfile.backgroundImage)" | Out-File -FilePath $global:OriginalBackgroundFile -Encoding utf8}
    # backup of settings.json before touching it
    Copy-Item $settingsPath "$settingsPath.bak" -Force
    # Change background image (works even if the property didn't exist yet)
    $wtProfile | Add-Member -NotePropertyName backgroundImage -NotePropertyValue $ImagePath -Force
    # Save the updated settings.json
    $json | ConvertTo-Json -Depth 100 | Set-Content -Path $settingsPath -Encoding utf8
    Write-Host "Background image temporarily set to $ImagePath. Restart Windows Terminal to see changes."}

function backgroundback {
    $settingsPath = Get-WTSettingsPath
    if (-not $settingsPath) {
        Write-Host "Windows Terminal settings.json not found"
        return}
    if (-not (Test-Path $global:OriginalBackgroundFile)) {
        Write-Host "No original background image saved to restore."
        return}
    $originalBackground = (Get-Content -Path $global:OriginalBackgroundFile -Raw).Trim()
    $json = Get-Content $settingsPath -Raw | ConvertFrom-Json
    $wtProfile = $json.profiles.list | Where-Object { $_.name -eq "PowerShell" } | Select-Object -First 1
    if ($null -eq $wtProfile) {
        Write-Host "PowerShell profile not found in settings."
        return}
    Copy-Item $settingsPath "$settingsPath.bak" -Force
    # Restore original background image (or remove it if there was none)
    if ([string]::IsNullOrWhiteSpace($originalBackground)) {$wtProfile.PSObject.Properties.Remove('backgroundImage')}
    else {$wtProfile | Add-Member -NotePropertyName backgroundImage -NotePropertyValue $originalBackground -Force}
    # Save the updated settings.json
    $json | ConvertTo-Json -Depth 100 | Set-Content -Path $settingsPath -Encoding utf8
    # Remove the temp file to clean up
    Remove-Item -Path $global:OriginalBackgroundFile -ErrorAction SilentlyContinue
    Write-Host "Background image restored to original. Restart Windows Terminal to see changes."}

# set-Aliases
# aliases beat functions in PowerShell – remove built-in/old aliases so the functions below actually run
foreach ($a in 'll', 'ls', 'grep', 'gc', 'gp') {Remove-Item "Alias:$a" -Force -ErrorAction SilentlyContinue}
Set-Alias -Name g -Value git -Force -ErrorAction SilentlyContinue

# helper functions
function touch {param([string]$File)
    if ([string]::IsNullOrWhiteSpace($File)) {
        Write-Error "Filename required"
        return}
    New-Item -ItemType File -Path $File -Force | Out-Null}

function ff {param([string]$Name)
    Get-ChildItem -Recurse -Filter "*$Name*" -ErrorAction SilentlyContinue |
        Select-Object FullName}

function mkcd {param([string]$Path)
    New-Item -ItemType Directory -Path $Path -Force | Out-Null
    Set-Location $Path}

function nf {param([string]$Name)
    if ([string]::IsNullOrWhiteSpace($Name)) {
        Write-Error "Filename required"
        return}
    $newFile = New-Item -ItemType File -Path $Name -Force
    if ($newFile) {Write-Host "Created: $($newFile.FullName)" -ForegroundColor Green
        if ($global:EDITOR) {& $global:EDITOR $newFile.FullName} else {Start-Process $newFile.FullName}}}

function nf_old {param([string]$Name)
    New-Item -ItemType File -Path $Name -Force}

function copyy {
    Param(
        [string]$source,
        [string]$destination
    )
    Copy-Item -Path $source -Destination $destination -Force}

function cd... { Set-Location ..\.. }
function cd.... { Set-Location ..\..\.. }
function docs { Set-Location "$HOME\Documents" }
function dtop { Set-Location "$HOME\Desktop" }
function pics { Set-Location "$HOME\Pictures" }
function musica { Set-Location "$HOME\Music" }

# listings
function Format-Size {param([long]$Bytes)
    if     ($Bytes -ge 1GB) {'{0:N1} GB' -f ($Bytes / 1GB)}
    elseif ($Bytes -ge 1MB) {'{0:N1} MB' -f ($Bytes / 1MB)}
    elseif ($Bytes -ge 1KB) {'{0:N1} KB' -f ($Bytes / 1KB)}
    else                    {"$Bytes B"}}

# ll: icon + name first, then date and readable size
# ll: icon + name, date, size – columns measured manually so icons don't break alignment
function ll {
    $items = @(Get-ChildItem @args)
    if (-not $items) { return }
    $useIcons = [bool](Get-Command Format-TerminalIcons -ErrorAction SilentlyContinue)
    $ansi = "$([char]27)\[[0-9;]*m"
    $rows = foreach ($i in $items) {
        $name  = if ($useIcons) { Format-TerminalIcons $i } else { $i.Name }
        $plain = $name -replace $ansi, ''
        [pscustomobject]@{
            Name  = $name
            Width = [Globalization.StringInfo]::new($plain).LengthInTextElements
            Date  = $i.LastWriteTime.ToString('yyyy-MM-dd HH:mm')
            Size  = if ($i.PSIsContainer) { '-' } else { Format-Size $i.Length }
        }
    }
    $nameW = [Math]::Max(4, ($rows | Measure-Object Width -Maximum).Maximum)
    $sizeW = [Math]::Max(4, ($rows.Size | ForEach-Object Length | Measure-Object -Maximum).Maximum)
    $b = $PSStyle.Bold; $d = $PSStyle.Dim; $r = $PSStyle.Reset

    "$b$('Name'.PadRight($nameW))  $('Modified'.PadRight(16))  $('Size'.PadLeft($sizeW))$r"
    foreach ($row in $rows) {
        "$($row.Name)$r$(' ' * ($nameW - $row.Width))  $d$($row.Date)$r  $($row.Size.PadLeft($sizeW))"
    }
}
# la: everything incl. hidden files, full view with Mode flags
function la { Get-ChildItem -Force @args | Format-Table -AutoSize }
# ls: compact, names + icons in columns
function ls { Get-ChildItem @args | Format-Wide -AutoSize }

function cpy {param([string]$Text) $Text | Set-Clipboard}
function pst {Get-Clipboard}

function extract_output {$lastCmd = Get-History -Count 1
    if ($lastCmd) {try {
            Invoke-Expression $lastCmd.CommandLine | Set-Clipboard
            Write-Host "Last command output copied to clipboard! ✓" -ForegroundColor Green}
        catch {Write-Warning "Failed to copy output: $_"}}
    else {Write-Host "No recent commands found." -ForegroundColor Yellow}}

function sed {param(
        [string]$File,
        [string]$Find,
        [string]$Replace)
    (Get-Content $File -Raw) -replace $Find, $Replace | Set-Content $File -NoNewline}

function head {param(
        [string]$Path,
        [int]$n = 10)
    Get-Content $Path -Head $n}

function tail {param(
        [string]$Path,
        [int]$n = 10,
        [switch]$f)
    Get-Content $Path -Tail $n -Wait:$f}

function grep {param(
        [string]$Pattern,
        [string]$Path)
    if ($Path) {Get-ChildItem $Path | Select-String $Pattern}
    else {$input | Select-String $Pattern}}

function pkill {param([string]$Name) Get-Process -Name $Name -ErrorAction SilentlyContinue | Stop-Process -Force}

function pgrep {param([string]$Name) Get-Process -Name $Name -ErrorAction SilentlyContinue}

function which {param([string]$Command)
    Get-Command $Command -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Source}

function unzip {param([string]$File)
    if (-not (Test-Path $File)) {
        Write-Error "File not found: $File"
        return}
    $destination = $PWD
    Write-Host "Extracting $File to $destination..." -ForegroundColor Cyan
    Expand-Archive -Path $File -DestinationPath $destination -Force
    Write-Host "Extraction complete! ✓" -ForegroundColor Green}

function sysinfo {Get-ComputerInfo}

function df {Get-Volume | Format-Table -AutoSize}

function uptime {
    if ($PSVersionTable.PSVersion.Major -ge 6) {$up = Get-Uptime}
    else {$up = (Get-Date) - (Get-CimInstance Win32_OperatingSystem).LastBootUpTime}
    Write-Host "Uptime: $($up.Days)d $($up.Hours)h $($up.Minutes)m"}

function Get-PubIP {try {(Invoke-RestMethod -Uri "https://api.ipify.org?format=json").ip}
    catch {Write-Warning "Failed to retrieve public IP: $_"}}

function flushdns {Clear-DnsClientCache
    Write-Host "DNS cache cleared! ✓" -ForegroundColor Green}


# Git Shortcuts
function gs { git status }
function ga { git add . }
function gc {param([string]$Message)
    git commit -m $Message}
function gp { git push }
function gpl { git pull }
function gcl {param([string]$Repo)
    git clone $Repo}
function gcom {
    param([string]$Message)
    git add .
    git commit -m $Message}
function lazyg {
    param([string]$Message)
    git add .
    git commit -m $Message
    git push}

function Edit-Profile {& $EDITOR $global:LaxProfilePath}

# a profile dot-sourced inside a function only loads into that function's scope,
# so this restarts pwsh in the same tab instead (clean reload)
function reload-profile {
    Write-Host "Reloading profile... ✓" -ForegroundColor Green
    & (Get-Process -Id $PID).Path -NoLogo
    exit}

Set-Alias -Name ep -Value Edit-Profile

# individual LAX Web Search functions
function Invoke-WebSearch {param(
        [string]$Url,
        [string]$Query)
    if ($Query) {Start-Process ($Url -f [uri]::EscapeDataString($Query))}
    else {Start-Process $Url}}

function google { param([string]$q) Invoke-WebSearch "https://www.google.com/search?q={0}" $q }
function bing { param([string]$q) Invoke-WebSearch "https://www.bing.com/search?q={0}" $q }
function wiki { param([string]$q) Invoke-WebSearch "https://en.wikipedia.org/wiki/Special:Search?search={0}" $q }
function wiki_de { param([string]$q) Invoke-WebSearch "https://de.wikipedia.org/wiki/Special:Search?search={0}" $q }
function yt { param([string]$q) Invoke-WebSearch "https://www.youtube.com/results?search_query={0}" $q }
function wolframalpha { param([string]$q) Invoke-WebSearch "https://www.wolframalpha.com/input?i={0}" $q }
function amazon { param([string]$q) Invoke-WebSearch "https://www.amazon.com/s?k={0}" $q }
function ebay { param([string]$q) Invoke-WebSearch "https://www.ebay.com/sch/i.html?_nkw={0}" $q }
function gif { param([string]$q) Invoke-WebSearch "https://giphy.com/search/{0}" $q }
function gif_t { param([string]$q) Invoke-WebSearch "https://tenor.com/search/{0}-gifs" $q }

# AI/LLMs: query is always copied to clipboard; sites that support it also get it prefilled via URL
function Open-AIChat {param(
        [string]$Name,
        [string]$Url,
        [string]$QueryUrl,
        [string]$q)
    if ($q) {$q | Set-Clipboard
        Write-Host "Query copied to clipboard: $q" -ForegroundColor Cyan
        if ($QueryUrl) {Start-Process ($QueryUrl -f [uri]::EscapeDataString($q)); return}
        Write-Host "Paste it into $Name (Ctrl+V)" -ForegroundColor Yellow}
    Start-Process $Url}
function gemini     { param([string]$q) Open-AIChat 'Gemini'     'https://gemini.google.com/app' ''                                       $q }
function gpt        { param([string]$q) Open-AIChat 'ChatGPT'    'https://chatgpt.com'           'https://chatgpt.com/?q={0}'             $q }
function claude-ai  { param([string]$q) Open-AIChat 'Claude'     'https://claude.ai'             'https://claude.ai/new?q={0}'            $q }
function perplexity { param([string]$q) Open-AIChat 'Perplexity' 'https://www.perplexity.ai'     'https://www.perplexity.ai/search?q={0}' $q }
function phind      { param([string]$q) Open-AIChat 'Phind'      'https://www.phind.com'         ''                                       $q }
function deepseek   { param([string]$q) Open-AIChat 'DeepSeek'   'https://chat.deepseek.com'     ''                                       $q }
function grok       { param([string]$q) Open-AIChat 'Grok'       'https://grok.com'              ''                                       $q }

function yf { param([string]$ticker) Invoke-WebSearch "https://finance.yahoo.com/quote/{0}" $ticker }
function compare_assets {param(
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$Tickers)
    $Tickers = $Tickers | Where-Object { $_ -and $_.Trim() -ne "" }
    if ($Tickers.Count -lt 2) {
        Write-Host "Usage: compare_assets SPY QQQ [IWM ...]" -ForegroundColor Yellow
        return}
    $symbolString = $Tickers -join ','
    $url = "https://stockcharts.com/freecharts/perf.php?$symbolString"
    Write-Host "📊 Comparing on StockCharts: $($Tickers -join ' | ')" -ForegroundColor Green
    Start-Process $url}
function compare_assets2 {param(
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$Tickers)
    $Tickers = $Tickers | Where-Object { $_ -and $_.Trim() -ne "" }
    if ($Tickers.Count -lt 2) {
        Write-Host "Usage: compare_assets2 SPY QQQ [IWM ...]" -ForegroundColor Yellow
        return}
    $base = $Tickers[0]
    $comparisons = $Tickers[1..($Tickers.Length-1)] -join ','
    $url = "https://www.tradingview.com/chart/?symbol=$base&comparisons=$comparisons"
    Write-Host "📊 Comparing on TradingView: $($Tickers -join ' | ')" -ForegroundColor Green
    Start-Process firefox $url}
# shortcuts (quick access websites)
function gmail { Invoke-WebSearch "https://mail.google.com" }
function calendar { Invoke-WebSearch "https://calendar.google.com" }
function reddit { Invoke-WebSearch "https://www.reddit.com" }
function twitter { param([string]$q) if ($q) { Invoke-WebSearch "https://twitter.com/search?q={0}" $q } else { Invoke-WebSearch "https://twitter.com" } }
function github { Invoke-WebSearch "https://github.com" }
# Investment research
function economy { Invoke-WebSearch "https://finviz.com/map.ashx" }
function econ-calendar {Start-Process "https://www.investing.com/economic-calendar/"}
function market-sentiment {Start-Process "https://www.cnn.com/markets/fear-and-greed"}
function openinsider { param([string]$q) Invoke-WebSearch "https://www.openinsider.com/search?q={0}" $q }
function stockcharts { param([string]$q) Invoke-WebSearch "https://stockcharts.com/h-sc/ui?s={0}" $q }
function sec { param([string]$q) Invoke-WebSearch "https://www.sec.gov/cgi-bin/browse-edgar?company={0}&action=getcompany" $q }
function whalewisdom { param([string]$ticker) Invoke-WebSearch "https://whalewisdom.com/stock/{0}" $ticker }
function maxpain { param([string]$q) Invoke-WebSearch "https://maximum-pain.com/options/{0}" $q }
function seekingalpha { param([string]$q) Invoke-WebSearch "https://seekingalpha.com/symbol/{0}" $q }
function optionchain { param([string]$ticker) Invoke-WebSearch "https://unusualwhales.com/stock/{0}/option-chains" $ticker }
function earnings { param([string]$ticker) Invoke-WebSearch "https://www.earningswhispers.com/stocks/{0}" $ticker }

# Finance (direct links to assets)
function spy { Invoke-WebSearch "https://finance.yahoo.com/quote/SPY" }
function dax { Invoke-WebSearch "https://finance.yahoo.com/quote/^GDAXI" }
function eurostox { Invoke-WebSearch "https://finance.yahoo.com/quote/^STOXX50E" }
function btc { Invoke-WebSearch "https://finance.yahoo.com/quote/BTC-USD" }
function eth { Invoke-WebSearch "https://finance.yahoo.com/quote/ETH-USD" }
function dji { Invoke-WebSearch "https://finance.yahoo.com/quote/^DJI" }
function nasdaq { Invoke-WebSearch "https://finance.yahoo.com/quote/^IXIC" }
function gold { Invoke-WebSearch "https://finance.yahoo.com/quote/GC=F" }
function oil { Invoke-WebSearch "https://finance.yahoo.com/quote/CL=F" }
function eurusd { Invoke-WebSearch "https://finance.yahoo.com/quote/EURUSD=X" }
function usdxcd { Invoke-WebSearch "https://finance.yahoo.com/quote/USDXCD=X/" }
function usdjpy { Invoke-WebSearch "https://finance.yahoo.com/quote/JPY%3DX/" }

function extract_text {param([string]$Url)
    try {$response = Invoke-WebRequest -Uri $Url -UseBasicParsing -ErrorAction Stop
        if ($response.StatusCode -eq 200) {$text = $response.Content -replace '<[^>]*>', '' -replace '\s+', ' '
            return $text.Trim()}} catch {Write-Warning "Failed to extract text from $Url : $_"}}

function hb {param([string]$FilePath)
    if (-not $FilePath) {Write-Error "No file path specified"; return}
    if (-not (Test-Path $FilePath)) {Write-Error "File not found: $FilePath"; return}
    try {$content = Get-Content $FilePath -Raw
        $response = Invoke-RestMethod -Uri "http://bin.christitus.com/documents" -Method Post -Body $content
        $url = "http://bin.christitus.com/$($response.key)"
        Write-Host $url -ForegroundColor Green
        $url | Set-Clipboard}
    catch {Write-Error "Upload failed: $_"}}

function export {param([string]$Name, [string]$Value) Set-Item -Force -Path "env:$Name" -Value $Value}

# PSReadLine Configuration
if (Get-Module PSReadLine) {
    Set-PSReadLineOption -EditMode Emacs
    Set-PSReadLineOption -BellStyle None
    Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
    Set-PSReadLineKeyHandler -Chord 'Enter' -Function ValidateAndAcceptLine
    Set-PSReadLineOption -PredictionSource History
    Set-PSReadLineOption -PredictionViewStyle ListView
    Set-PSReadLineOption -Colors @{
        Command            = 'Yellow'
        Parameter          = 'Green'
        String             = 'DarkCyan'
        InLinePrediction   = "$($PSStyle.Foreground.BrightYellow)$($PSStyle.Background.BrightBlack)"
        Selection          = $PSStyle.Background.Black}}
# FZF Configuration
if (Get-Module PSFzf) {Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'}

if (Test-CommandExists dotnet) {
    Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
        param($wordToComplete, $commandAst, $cursorPosition)
        dotnet complete --position $cursorPosition "$commandAst" |
            ForEach-Object {
                [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)}}}

$historyPath = "$HOME\.config\powershell\.cdHistory"
if (-not (Test-Path (Split-Path $historyPath))) {
    New-Item -ItemType Directory -Path (Split-Path $historyPath) -Force | Out-Null}
$env:POWERSHELL_HISTORY_PATH = $historyPath


# Help Function
function quick-help {$helpText = @"
╔══════════════════════════════════════════════════════════════╗
║          LAX PowerShell Profile - Command Reference          ║
╚══════════════════════════════════════════════════════════════╝

SYSTEM MANAGEMENT
  sysinfo              System information
  df                   Show disk volumes
  uptime               System uptime
  flushdns             Clear DNS cache
  Get-PubIP            Get public IP address
  winfetch             Display system information (only windows)
  ahk-reload           Restart desktopkeys.ahk (AutoHotkey)

FILE & DIRECTORY
  touch <file>         Create new file
  nf_old <name>        Create new file
  nf <name>            Create and open file in editor
  mkcd <dir>           Create and enter directory
  ff <name>            Find files recursively
  unzip <file>         Extract zip archive
  copyy                copy file (path) (destinationpath)
  ls                   List files (compact, icons in columns)
  ll                   List files (icon + name, date, size)
  la                   List all files incl. hidden (full view with Mode)

  docs                 Quick navigation to documents folder
  dtop                 Quick navigation to desktop folder
  pics                 Quick navigation to picture folder
  musica               Quick navigation to music folder
  cd ..                Move up to parent directory
  cd...                Moves up 2 directory levels (to the grandparent directory)
  cd....               Moves up 3 directory levels (to the great-grandparent directory)

TEXT PROCESSING
  sed <file> <old> <new>   Find and replace in file
  head <file> [n]          Show first n lines
  tail <file> [n] [-f]     Show last n lines (-f = follow)
  grep <pattern> [path]    Search for pattern

PROCESS MANAGEMENT
  pkill <name>         Kill process by name
  pgrep <name>         Find process by name
  which <command>      Show command location

GIT SHORTCUTS
  github               Opens GitHub.com
  g                    git
  gs                   git status
  ga                   git add .
  gc <msg>             git commit -m
  gp                   git push
  gpl                  git pull
  gcl <repo>           git clone
  gcom <msg>           Add all + commit
  lazyg <msg>          Add all + commit + push

CLIPBOARD
  cpy <text>           Copy to clipboard
  pst                  Paste from clipboard
  extract_output       Copy last command output

PROFILE MANAGEMENT
  Edit-Profile / ep    Edit PowerShell profile
  reload-profile       Reload profile (restarts shell in same tab)
  Update-PowerShell    Check for PS updates (-Install to install)

WEB SEARCHES
  google <query>       Google search
  wiki <query>         Wikipedia search (EN)
  wiki_de <query>      Wikipedia search (DE)
  yt <query>           YouTube search
  amazon <query>       Amazon search
  bing <query>         Bing search
  ebay <query>         eBay search
  wolframalpha <query> WolframAlpha
  gif <query>          GIF Giphy search
  gif_t <query>        GIF Tenor search

BROWSER SHORTCUTS
  gmail                Open Gmail
  calendar             Open Google Calendar
  reddit               Open Reddit
  twitter [q]          Open Twitter or search query

AI/LLMs  (query copied to clipboard; * = also prefilled)
  gemini "query"       Gemini
  gpt "query"          ChatGPT *
  claude-ai "query"    Claude *
  grok "query"         Grok
  perplexity "query"   Perplexity *
  deepseek "query"     DeepSeek
  phind "query"        Phind

FINANCE
  yf <ticker>          Yahoo Finance quote
  compare_assets t1 t2 Stockcharts comparison multiple tickers
  compare_assets2 t1 t2 TradingView (Firefox) comparison multiple tickers
  openinsider <ticker> Insider trading info
  whalewisdom <ticker> Institutional holdings
  stockcharts <tkr>    StockCharts page
  sec <company>        SEC EDGAR filings
  optionchain <tkr>    Options chains (via Unusual Whales)
  maxpain <ticker>     Max Pain (option chain)
  earnings <tkr>       Earnings data (via earningswhispers)
  seekingalpha <tkr>   Seekingalpha
  economy              Overview economy (performance)
  econ-calendar        Overview economic calendar (investing.com)
  market-sentiment     Overview fear&greed indicator

FINANCE (specific assets)
  spy                  S&P500 (Yahoo Finance)
  dax                  DAX (Yahoo Finance)
  eurostox             Eurostox50 (Yahoo Finance)
  dji                  Dow Jones Industrial (Yahoo Finance)
  nasdaq               Nasdaq Composite (Yahoo Finance)
  oil                  Oil Crude (Yahoo Finance)
  gold                 Gold (Yahoo Finance)
  eurusd               Euro-United States Dollar exchange rate (Yahoo Finance)
  usdjpy               United States Dollar-Japanese Yen exchange rate (Yahoo Finance)
  usdxcd               United States Dollar-Eastern Carribean Dollar exchange rate (Yahoo Finance)
  btc                  Bitcoin (Yahoo Finance)
  eth                  Ethereum (Yahoo Finance)

UTILITIES
  hb <file>            Upload to hastebin
  extract_text <url>   Extract text from webpage
  export <var> <val>   Set environment variable
  backgroundbernie     Set BackgroundImage for terminal/ps
  backgroundback       Set Background back to no picture/transparent

Use 'quick-help' anytime to display this reference!
"@
    Write-Host $helpText -ForegroundColor Cyan}

# Run winfetch if available
if (Test-CommandExists winfetch) {winfetch}

Write-Host "   __
  /\ \   LAX Profile loaded successfully!
 / /\ \
/ /__\ \
\/____\/     type 'quick-help' for commands overview!" -ForegroundColor Magenta
Write-Host "`nVAMOOOOS ak bèl bebé (...)" -ForegroundColor Cyan
