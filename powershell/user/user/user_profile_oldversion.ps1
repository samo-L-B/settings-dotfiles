### PowerShell Profile LAX version 1.00 - LAX dipshit modifications

#opt-out of telemetry before doing anything, only if PowerShell is run as admin
if ([bool]([System.Security.Principal.WindowsIdentity]::GetCurrent()).IsSystem) {
    [System.Environment]::SetEnvironmentVariable('POWERSHELL_TELEMETRY_OPTOUT', 'true', [System.EnvironmentVariableTarget]::Machine)
}

# Import Modules and External Profiles
if (-not (Get-Module -ListAvailable -Name Terminal-Icons)) {
    Install-Module -Name Terminal-Icons -Scope CurrentUser -Force -SkipPublisherCheck
}
Import-Module Terminal-Icons

function Update-PowerShell {
    if (-not $global:canConnectToGitHub) {
        Write-Host "Skipping PowerShell update check due to GitHub.com not responding within 1 second." -ForegroundColor Yellow
        return
    }

    try {
        Write-Host "olâ beleza ... great to see ur lazy ass! one sec...checking for PowerShell updates..." -ForegroundColor Cyan
        $updateNeeded = $false
        $currentVersion = $PSVersionTable.PSVersion.ToString()
        $gitHubApiUrl = "https://api.github.com/repos/PowerShell/PowerShell/releases/latest"
        $latestReleaseInfo = Invoke-RestMethod -Uri $gitHubApiUrl
        $latestVersion = $latestReleaseInfo.tag_name.Trim('v')
        if ($currentVersion -lt $latestVersion) {
            $updateNeeded = $true
        }

        if ($updateNeeded) {
            Write-Host "alrighty, let's start updating PowerShell..." -ForegroundColor Yellow
            winget upgrade "Microsoft.PowerShell" --accept-source-agreements --accept-package-agreements
            Write-Host "PowerShell has been updated. Please restart your shell to reflect changes" -ForegroundColor Magenta
        } else {
            Write-Host "your PowerShell is up to date - vamos" -ForegroundColor Green
        }
    } catch {
        Write-Error "Failed to update PowerShell. Error: $_"
    }
}
Update-PowerShell

# Admin Check and Prompt Customization
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
function prompt {
    if ($isAdmin) { "[" + (Get-Location) + "] # " } else { "[" + (Get-Location) + "] $ " }
}
$adminSuffix = if ($isAdmin) { " [ADMIN]" } else { "" }
$Host.UI.RawUI.WindowTitle = "PowerShell {0}$adminSuffix" -f $PSVersionTable.PSVersion.ToString()


# Alias
Set-Alias vim nvim
Set-Alias ll ls
Set-Alias g git
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\git\usr\less.exe'
function Test-CommandExists {
    param($command)
    $exists = $null -ne (Get-Command $command -ErrorAction SilentlyContinue)
    return $exists
}
# Useful file-management functions
function cd... { Set-Location ..\.. }
function cd.... { Set-Location ..\..\.. }

# Editor Configuration
$EDITOR = if (Test-CommandExists nvim) { 'nvim' }
          elseif (Test-CommandExists pvim) { 'pvim' }
          elseif (Test-CommandExists vim) { 'vim' }
          elseif (Test-CommandExists vi) { 'vi' }
          elseif (Test-CommandExists code) { 'code' }
          elseif (Test-CommandExists notepad++) { 'notepad++' }
          elseif (Test-CommandExists sublime_text) { 'sublime_text' }
          else { 'notepad' }
Set-Alias -Name vim -Value $EDITOR


function Edit-Profile {
    vim $PROFILE.CurrentUserAllHosts
}
function touch($file) { "" | Out-File $file -Encoding ASCII }
function ff($name) {
    Get-ChildItem -recurse -filter "*${name}*" -ErrorAction SilentlyContinue | ForEach-Object {
        Write-Output "$($_.FullName)"
    }
}

# Network Utilities
function Get-PubIP { (Invoke-WebRequest http://ifconfig.me/ip).Content }

# Open WinUtil
function winutil {
	iwr -useb https://christitus.com/win | iex
}


function uptime {
    if ($PSVersionTable.PSVersion.Major -eq 5) {
        Get-WmiObject win32_operatingsystem | Select-Object @{Name='LastBootUpTime'; Expression={$_.ConverttoDateTime($_.lastbootuptime)}} | Format-Table -HideTableHeaders
    } else {
        net statistics workstation | Select-String "since" | ForEach-Object { $_.ToString().Replace('Statistics since ', '') }
    }
}

function reload-profile {
    & $profile
}

function unzip ($file) {
    Write-Output("Extracting", $file, "to", $pwd)
    $fullFile = Get-ChildItem -Path $pwd -Filter $file | ForEach-Object { $_.FullName }
    Expand-Archive -Path $fullFile -DestinationPath $pwd
}
function hb {
    if ($args.Length -eq 0) {
        Write-Error "No file path specified."
        return
    }
    
    $FilePath = $args[0]
    
    if (Test-Path $FilePath) {
        $Content = Get-Content $FilePath -Raw
    } else {
        Write-Error "File path does not exist."
        return
    }
    
    $uri = "http://bin.christitus.com/documents"
    try {
        $response = Invoke-RestMethod -Uri $uri -Method Post -Body $Content -ErrorAction Stop
        $hasteKey = $response.key
        $url = "http://bin.christitus.com/$hasteKey"
        Write-Output $url
    } catch {
        Write-Error "Failed to upload the document. Error: $_"
    }
}
function grep($regex, $dir) {
    if ( $dir ) {
        Get-ChildItem $dir | select-string $regex
        return
    }
    $input | select-string $regex
}

function df {
    get-volume
}

function sed($file, $find, $replace) {
    (Get-Content $file).replace("$find", $replace) | Set-Content $file
}

function which($name) {
    Get-Command $name | Select-Object -ExpandProperty Definition
}

function export($name, $value) {
    set-item -force -path "env:$name" -value $value;
}

function pkill($name) {
    Get-Process $name -ErrorAction SilentlyContinue | Stop-Process
}

function pgrep($name) {
    Get-Process $name
}

function head {
  param($Path, $n = 10)
  Get-Content $Path -Head $n
}

function tail {
  param($Path, $n = 10, [switch]$f = $false)
  Get-Content $Path -Tail $n -Wait:$f
}

# Quick File Creation
function nf { param($name) New-Item -ItemType "file" -Path . -Name $name }

# Directory Management
function mkcd { param($dir) mkdir $dir -Force; Set-Location $dir }

# Navigation Shortcuts
function docs { Set-Location -Path $HOME\Documents }
function dtop { Set-Location -Path $HOME\Desktop }

# Quick Access to Editing the Profile
function ep { vim $PROFILE }

# Simplified Process Management
function k9 { Stop-Process -Name $args[0] }

# Enhanced Listing
function la { Get-ChildItem -Path . -Force | Format-Table -AutoSize }
function ll { Get-ChildItem -Path . -Force -Hidden | Format-Table -AutoSize }

## Quick Access to System Information
function sysinfo { Get-ComputerInfo }

# Git Shortcuts
function gs { git status }
function ga { git add . }
function gc { param($m) git commit -m "$m" }
function gp { git push }
function gcl { git clone "$args" }
function gcom {
    git add .
    git commit -m "$args"
}
function lazyg {
    git add .
    git commit -m "$args"
    git push
}
function goodmorning-eva {
    cd C:\Users\andre\project-eva\
    git fetch upstream
    git merge upstream/main
    git push origin main    
}

function goodnighteva {
    cd C:\Users\andre\project-eva\
    git status
    git add .
    git commit -m "$args"
    git push 
}

# Quick Access to System Information
function sysinfo { Get-ComputerInfo }

# Networking Utilities
function flushdns {
	Clear-DnsClientCache
	Write-Host "DNS has been flushed"
}

# Clipboard Utilities
function cpy { Set-Clipboard $args[0] }
function pst { Get-Clipboard }

# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# import modules
Import-Module posh-git
Import-Module -Name z
if (-not (Get-Module -ListAvailable -Name PSFzf)) {
    Install-Module -Name PSFzf -Scope CurrentUser -Force -SkipPublisherCheck
}
Import-Module -Name PSFzf


## Ensure PSReadLine is loaded
if (-not (Get-Module -Name PSReadLine)) {
    Import-Module PSReadLine
}

# Enhanced PowerShell Experience
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

Set-PSReadLineOption -Colors @{
    Command = 'Yellow'
    Parameter = 'Green'
    String = 'DarkCyan'
    InLinePrediction = 'Blue'
}

$PSROptions = @{
    ContinuationPrompt = '  '
    Colors             = @{
    Parameter          = $PSStyle.Foreground.Magenta
    Selection          = $PSStyle.Background.Black
    InLinePrediction   = $PSStyle.Foreground.BrightYellow + $PSStyle.Background.BrightBlack
    }
}
Set-PSReadLineOption @PSROptions
Set-PSReadLineKeyHandler -Chord 'Ctrl+f' -Function ForwardWord
Set-PSReadLineKeyHandler -Chord 'Enter' -Function ValidateAndAcceptLine

$scriptblock = {
    param($wordToComplete, $commandAst, $cursorPosition)
    dotnet complete --position $cursorPosition $commandAst.ToString() |
        ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock $scriptblock

# FZF
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+g' -PSReadlineChordReverseHistory 'Ctrl+b'

# Get theme from profile.ps1 or use a default theme
$omp_config = Join-Path $PSScriptRoot "LAX.omp.json"
oh-my-posh --init --shell pwsh --config $omp_config | Invoke-Expression
#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\.config\powershell\LAX.omp.json" | Invoke-Expression

#oh-my-posh --init --shell pwsh --config "$env:POSH_THEMES_PATH\.config\powershell\LAX.omp.json" | Invoke-Expression
# alternative
# oh-my-posh init pwsh --config https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/cobalt2.omp.json | Invoke-Expression


# Neofetch configs
neofetch

## LAX Command-line Web Searches
function google {
    param([string]$query)
    Start-Process "https://www.google.com/search?q=$query"}

function gif {
    param([string]$query)
    Start-Process "https://giphy.com/search/$query"}

function gif_t {
    param([string]$query)
    Start-Process "https://tenor.com/search/$query-gifs"}

function wolframalpha {
    param([string]$query)
    Start-Process "https://www.wolframalpha.com/input?i=$query"}

function wiki {
    param([string]$query)
    Start-Process "https://en.wikipedia.org/wiki/Special:Search?search=$query"}

function wiki_de {
    param([string]$query)
    Start-Process "https://de.wikipedia.org/wiki/Special:Search?search=$query"}

function yt {
    param([string]$query)
    Start-Process "https://www.youtube.com/results?search_query=$query"}

function yf {
    param([string]$query)
    Start-Process "https://finance.yahoo.com/quote/$query"}

function spy {
    Start-Process "https://finance.yahoo.com/quote/SPY"}

function dax {
    Start-Process "https://finance.yahoo.com/quote/^GDAX"}

function eurostox {
    Start-Process "https://finance.yahoo.com/quote/^STOXX50E"}

function btc {
    Start-Process "https://finance.yahoo.com/quote/BTC-EUR"}

function dji {
    Start-Process "https://finance.yahoo.com/quote/^DJI"}

function oil {
    Start-Process "https://finance.yahoo.com/quote/CL%3DF"}

function nikkei {
    Start-Process "https://finance.yahoo.com/quote/^N225"}

function nasdaq {
    Start-Process "https://finance.yahoo.com/quote/^IXIC"}

function cac {
    Start-Process "https://finance.yahoo.com/quote/^FCHI"}

function sdax {
    Start-Process "https://finance.yahoo.com/quote/^SDAXI"}

function tecdax {
    Start-Process "https://finance.yahoo.com/quote/^TECDAX"}

function mdax {
    Start-Process "https://finance.yahoo.com/quote/^MDAXI"}

function eurusd {
    Start-Process "https://finance.yahoo.com/quote/EURUSD%3DX"}

function euryen {
    Start-Process "https://finance.yahoo.com/quote/EURJPY%3DX"}

function eth {
    Start-Process "https://finance.yahoo.com/quote/ETH-USD"}

function gold {
    Start-Process "https://finance.yahoo.com/quote/GC%3DF"}

function yf {
    param([string]$query)
    Start-Process "https://finance.yahoo.com/quote/$query"}


function yf {
    param([string]$query)
    Start-Process "https://finance.yahoo.com/quote/$query"}


function yf {
    param([string]$query)
    Start-Process "https://finance.yahoo.com/quote/$query"}


function amazon {
    param([string]$query)
    Start-Process "https://www.amazon.com/s?k=$query"}

function ebay {
    param([string]$query)
    Start-Process "https://www.ebay.com/search?q=$query"}
    
function bing {
    param([string]$query)
    Start-Process "https://www.bing.com/search?q=$query"}

# Search on gemini (assuming you mean Gemini cryptocurrency exchange)
function gemini {
    param([string]$query)
    Start-Process "https://www.gemini.com/search?q=$query"}

function openinsider {
    param([string]$query)
    Start-Process "https://www.openinsider.com/search?q=$query"}

function stockcharts {
    param([string]$query)
    Start-Process "https://stockcharts.com/search/?q=$query"}

function sec {
    param([string]$query)
    Start-Process "https://www.sec.gov/edgar/searchedgar/companysearch.html?query=$query"}

function whalewisdom {
    param([string]$query)
    Start-Process "https://whalewisdom.com/stock/$query"}

function seekingalpha {
    param([string]$query)
    Start-Process "https://seekingalpha.com/search?query=$query"}

function earningswhispers {
    param([string]$query)
    Start-Process "https://www.earningswhispers.com/stocks/$query"}

function optionchain {
    param([string]$query)
    Start-Process "https://unusualwhales.com/stock/$query/option-chains?"}

function maxpain {
    param([string]$query)
    Start-Process "https://maximum-pain.com/options/	$query"}

function gmail {
    Start-Process "https://mail.google.com/mail/u/0/"}

function calendar {
    Start-Process "https://calendar.google.com/calendar/u/0/r"}

function reddit {
    Start-Process "https://www.reddit.com/"}

function twitter {
    Start-Process "https://www.x.com/"}

function twitter {
    param([string]$query)
    Start-Process "https://www.x.com/search?q=$query"}

function github {
    Start-Process "https://www.github.com/"}

function extract_text($url) {
    try {
        # Download the HTML content from the URL
        $response = Invoke-WebRequest -Uri $url -UseBasicParsing -ErrorVariable webRequestError
        Write-Verbose "Web request status code: $($response.StatusCode)"

        if ($webRequestError) {
            Write-Warning "Web request failed: $($webRequestError.Exception.Message)"
            return $null
        }

        if ($response.StatusCode -eq 200) {
            # Extract the raw HTML content
            $html = $response.Content

            # Remove HTML tags to get plain text
            $text = $html -replace '<[^>]*>', ''

            # Remove extra whitespace and line breaks
            $text = $text.Trim().Replace('`r`n', "`n").Replace('`t', ' ')

            # Return the extracted text
            return $text
        } else {
            Write-Warning "Web request failed with status code $($response.StatusCode)"
            return $null
        }
    } catch {
        Write-Warning "Error extracting text from URL: $_"
        return $null
    }
}

function extract_output {
    $historyCmd = Get-History -Count 1

    if ($historyCmd) {
        Invoke-Expression -Command $historyCmd.CommandLine | Set-Clipboard
        Write-Host "output of last command succesfully copied to clipboard dipshit."
    } else {
        Write-Host "no recent commands found dippie."
    }
}


# Help Function
function Show-Help {
@"
PowerShell Profile Help
=======================


Update-PowerShell - Checks for the latest PowerShell release and updates if a new version is available.

Edit-Profile - Opens the current user's profile for editing using the configured editor.

touch <file> - Creates a new empty file.

ff <name> - Finds files recursively with the specified name.

Get-PubIP - Retrieves the public IP address of the machine.

winutil - Runs the WinUtil script from Chris Titus Tech.

uptime - Displays the system uptime.

reload-profile - Reloads the current user's PowerShell profile.

unzip <file> - Extracts a zip file to the current directory.

hb <file> - Uploads the specified file's content to a hastebin-like service and returns the URL.

grep <regex> [dir] - Searches for a regex pattern in files within the specified directory or from the pipeline input.

df - Displays information about volumes.

sed <file> <find> <replace> - Replaces text in a file.

which <name> - Shows the path of the command.

export <name> <value> - Sets an environment variable.

pkill <name> - Kills processes by name.

pgrep <name> - Lists processes by name.

head <path> [n] - Displays the first n lines of a file (default 10).

tail <path> [n] - Displays the last n lines of a file (default 10).

nf <name> - Creates a new file with the specified name.

mkcd <dir> - Creates and changes to a new directory.

docs - Changes the current directory to the user's Documents folder.

dtop - Changes the current directory to the user's Desktop folder.

ep - Opens the profile for editing.

k9 <name> - Kills a process by name.

la - Lists all files in the current directory with detailed formatting.

ll - Lists all files, including hidden, in the current directory with detailed formatting.

gs - Shortcut for 'git status'.

ga - Shortcut for 'git add.'.

gc <message> - Shortcut for 'git commit -m'.

gp - Shortcut for 'git push'.

g - Changes to the GitHub directory.

gcom <message> - Adds all changes and commits with the specified message.

lazyg <message> - Adds all changes, commits with the specified message, and pushes to the remote repository.

sysinfo - Displays detailed system information.

flushdns - Clears the DNS cache.

cpy <text> - Copies the specified text to the clipboard.

pst - Retrieves text from the clipboard.

google <query> - Opens Google search for the specified query.

wolframalpha <query> - Opens Wolfram Alpha for the specified query.

wiki <query> - Opens Wikipedia search for the specified query.

wiki_de <query> - Opens German Wikipedia search for the specified query.

yt <query> - Opens YouTube search for the specified query.

yf <query> - Opens Yahoo Finance for the specified stock ticker.

amazon <query> - Opens Amazon search for the specified query.

bing <query> - Opens Bing search for the specified query.

gemini <query> - Opens Gemini cryptocurrency exchange search.

openinsider <query> - Opens OpenInsider stock news search.

stockcharts <query> - Opens StockCharts search.

sec <query> - Opens SEC EDGAR company search.

whalewisdom <query> - Opens WhaleWisdom stock analysis.

seekingalpha <query> - Opens Seeking Alpha stock news.

gmail - Opens Gmail login page.

calendar - Opens Google Calendar.

reddit - Opens Reddit homepage.

twitter - Opens X (Twitter) login page (and searches for query if existing)

github - Opens GitHub.

extract_text - extracts all text from html

extract_output - extracts respectively copies last output to clipboard so you can use it in other programs


Use 'Show-Help' to display this help message.
"@
}
Write-Host "enjoy ur day - use 'Show-Help' to display help for personal prompts or search for PowerShell commands (cheetsheets)"

