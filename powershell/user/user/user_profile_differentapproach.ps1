# ============================================================
# ELITE POWERSHELL PROFILE v3.0
# Performance-first, modular, production-grade shell setup
# ============================================================

#region ================= CORE INIT (FAST PATH ONLY) =========

[Console]::InputEncoding  = [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
$Host.UI.RawUI.WindowTitle = "pwsh $($PSVersionTable.PSVersion)"

# Admin detection (no globals)
function Test-IsAdmin {
    ([Security.Principal.WindowsPrincipal]
        [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

$IsAdmin = Test-IsAdmin

if ($IsAdmin) {
    Write-Host "ADMIN SESSION ACTIVE" -ForegroundColor Green
} else {
    Write-Host "standard session" -ForegroundColor DarkGray
}

#endregion

#region ================= STARTUP MESSAGE =====================

Write-Host "こんにちは — LAX ELITE PROFILE LOADED" -ForegroundColor Yellow
Write-Host "system ready... no delays, no bullshit." -ForegroundColor Cyan

#endregion

#region ================= LAZY FEATURES =======================

# GitHub check (non-blocking)
$script:GitHubOK = $false
Start-Job {
    try {
        Invoke-WebRequest "https://github.com" -TimeoutSec 2 | Out-Null
        $true
    } catch { $false }
} | Out-Null

# async update check (never blocks shell)
function Check-PwshUpdate {
    Start-Job {
        try {
            $r = Invoke-RestMethod "https://api.github.com/repos/PowerShell/PowerShell/releases/latest"
            [Version]($r.tag_name -replace '^v')
        } catch {}
    } | Out-Null
}

#endregion

#region ================= EDITOR ENGINE ======================

function Get-Editor {
    $candidates = "nvim","vim","code","notepad++","sublime_text","notepad"
    foreach ($c in $candidates) {
        if (Get-Command $c -ErrorAction SilentlyContinue) { return $c }
    }
    return "notepad"
}

$env:EDITOR = Get-Editor

#endregion

#region ================= FILE SYSTEM =========================

function touch {
    param([Parameter(Mandatory)][string]$File)
    if (-not (Test-Path $File)) { New-Item -ItemType File $File | Out-Null }
}

function mkcd {
    param([Parameter(Mandatory)][string]$Path)
    New-Item -ItemType Directory -Path $Path -Force | Out-Null
    Set-Location $Path
}

function ff {
    param([string]$Name)
    Get-ChildItem -Recurse -ErrorAction SilentlyContinue |
        Where-Object Name -like "*$Name*"
}

function nf {
    param([Parameter(Mandatory)][string]$Name)
    $file = New-Item -ItemType File -Path $Name -Force
    & $env:EDITOR $file.FullName
}

#endregion

#region ================= NAVIGATION ==========================

function docs { Set-Location "$HOME\Documents" }
function dtop { Set-Location "$HOME\Desktop" }
function pics { Set-Location "$HOME\Pictures" }
function musica { Set-Location "$HOME\Music" }

function cd..  { Set-Location .. }
function cd... { Set-Location ..\.. }
function cd.... { Set-Location ..\..\.. }

#endregion

#region ================= LISTING UX ==========================

function la { Get-ChildItem -Force | Format-Table Name,Mode,LastWriteTime -AutoSize }
function ll { Get-ChildItem -Force | Format-Table Mode,LastWriteTime,Length,Name -AutoSize }
function ls { Get-ChildItem | Select-Object Name }

#endregion

#region ================= CLIPBOARD ===========================

function cpy { param([string]$Text) $Text | Set-Clipboard }
function pst { Get-Clipboard }

function extract_output {
    $h = Get-History -Count 1
    if ($h) {
        Invoke-Expression $h.CommandLine | Set-Clipboard
        Write-Host "output copied" -ForegroundColor Green
    }
}

#endregion

#region ================= TEXT TOOLS ==========================

function sed {
    param($File,$Find,$Replace)
    (Get-Content $File -Raw) -replace $Find,$Replace | Set-Content $File
}

function head { param($Path,$n=10) Get-Content $Path -TotalCount $n }
function tail { param($Path,$n=10) Get-Content $Path -Tail $n }

function grep {
    param($Pattern,$Path=".")
    Get-ChildItem $Path -Recurse | Select-String $Pattern
}

#endregion

#region ================= SYSTEM ==============================

function sysinfo { Get-ComputerInfo }
function df { Get-Volume }

function uptime {
    $os = Get-CimInstance Win32_OperatingSystem
    (Get-Date) - $os.LastBootUpTime
}

function Get-PubIP {
    try { (Invoke-RestMethod "https://api.ipify.org?format=json").ip }
    catch {}
}

function flushdns {
    Clear-DnsClientCache
    Write-Host "DNS flushed" -ForegroundColor Green
}

#endregion

#region ================= PROCESS =============================

function pkill { param($Name) Get-Process $Name -ErrorAction SilentlyContinue | Stop-Process -Force }
function pgrep { param($Name) Get-Process $Name -ErrorAction SilentlyContinue }
function which { param($c) Get-Command $c | Select Source }

#endregion

#region ================= ARCHIVES ============================

function unzip {
    param([string]$File)
    Expand-Archive $File -DestinationPath $PWD -Force
}

#endregion

#region ================= GIT CORE ============================

function g  { git @args }
function gs { git status }
function ga { git add . }
function gc { param($m) git commit -m $m }
function gp { git push }
function gpl { git pull }

function gcom { git add .; git commit -m $args }
function lazyg { git add .; git commit -m $args; git push }

function newproject {
    param($name)
    mkdir $name
    cd $name
    git init
    New-Item README.md
    New-Item .gitignore
}

#endregion

#region ================= WEB ENGINE ==========================

function Open-URL {
    param($url,$q)
    if ($q) {
        Start-Process ($url -f [uri]::EscapeDataString($q))
    } else {
        Start-Process $url
    }
}

function google { param($q) Open-URL "https://google.com/search?q={0}" $q }
function bing   { param($q) Open-URL "https://bing.com/search?q={0}" $q }
function yt     { param($q) Open-URL "https://youtube.com/results?search_query={0}" $q }
function wiki   { param($q) Open-URL "https://en.wikipedia.org/wiki/Special:Search?search={0}" $q }

function amazon { param($q) Open-URL "https://amazon.com/s?k={0}" $q }
function ebay   { param($q) Open-URL "https://ebay.com/sch/i.html?_nkw={0}" $q }

#endregion

#region ================= AI HUB ==============================

function ai {
    param($url,$q)
    if ($q) { $q | Set-Clipboard }
    Start-Process $url
}

function gpt       { param($q) ai "https://chatgpt.com" $q }
function claude    { param($q) ai "https://claude.ai" $q }
function gemini    { param($q) ai "https://gemini.google.com" $q }
function perplexity{ param($q) ai "https://perplexity.ai" $q }

#endregion

#region ================= FINANCE =============================

function yf { param($t) Start-Process "https://finance.yahoo.com/quote/$t" }

function spy { yf SPY }
function btc { yf BTC-USD }
function eth { yf ETH-USD }

#endregion

#region ================= PROFILE CONTROL =====================

function reload-profile {
    . $PROFILE
    Write-Host "profile reloaded" -ForegroundColor Green
}

function Edit-Profile { & $env:EDITOR $PROFILE }
Set-Alias ep Edit-Profile

#endregion

#region ================= OPTIONAL MODULES ====================

function Import-Safe {
    param($Name)
    if (Get-Module -ListAvailable $Name) {
        Import-Module $Name -ErrorAction SilentlyContinue
    }
}

Import-Safe PSReadLine
Import-Safe PSFzf
Import-Safe posh-git
Import-Safe Terminal-Icons

#endregion

#region ================= FINAL BOOT ==========================

Check-PwshUpdate

Write-Host "✔ ELITE PROFILE READY" -ForegroundColor Magenta
Write-Host "type quick-help (if you still need help 😄)" -ForegroundColor DarkCyan

#endregion
