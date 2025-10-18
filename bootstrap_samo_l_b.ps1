# ⚡samo-L-B's Dotfiles Bootstrap Script for Windows (PowerShell)
# Created by samo-L-B 🧠
# License: LAX
# Last updated: 2025-10
# ───────────────────────────────────────────────────────────────
# INITIAL CHECKS & PREP
# ───────────────────────────────────────────────────────────────

# SAFETY GUARD
$ErrorActionPreference = "Stop"

Write-Host "🚀 Starting samo-L-B's dotfiles bootstrap setup..."

function Ensure-Admin {
    if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Write-Warning "This script needs to be run as Administrator. Relaunching..."
        Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
        exit}}
Ensure-Admin

function Ensure-Command($cmd, $installer) {
    if (-not (Get-Command $cmd -ErrorAction SilentlyContinue)) {
        Write-Host "[+] Installing $cmd..."
        Invoke-Expression $installer}
    else {Write-Host "[✓] $cmd already installed."}}

# ───────────────────────────────────────────────────────────────
# INSTALL SCOOP & PACKAGES
# ───────────────────────────────────────────────────────────────

if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host "[+] Installing Scoop..."
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    Invoke-RestMethod get.scoop.sh | Invoke-Expression
} else {
    Write-Host "[✓] Scoop already installed."
}
if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Invoke-RestMethod get.scoop.sh | Invoke-Expression
    scoop bucket add extras
    scoop bucket add nerd-fonts
    scoop bucket add versions}
    scoop install oh-my-posh WindowsTerminal

$packages = @(
    # ── Terminals & Shells ─────────────────────────
    "windows-terminal",    # Windows Terminal
    # ── Fonts ──────────────────────────────────────
    "jetbrainsmono-nerd-font",  # Nerd Font w/icons for NeoVim, OhMyPosh, etc.
    # ── Editors & IDEs ─────────────────────────────
    "neovim"                # NeoVim
#    "vscode",              # VS Code
#    "sublime-text",        # Sublime Text
#    "notepadplusplus",     # For simple editing
#    "typora",              # Markdown editor
#    "obsidian",            # Markdown knowledge base
    # ── Browsers ───────────────────────────────────
    "firefox",             # Firefox
    "opera",               # Opera
#   "googlechrome",        # Chrome
    # ── Version Control & Git Tools ────────────────
    "git",                 # Git itself
    "gh",                  # GitHub CLI
    "lazygit",             # TUI Git interface
#   "tortoisegit",         # Git GUI client for Windows
    # ── Neovim & Language Tools ────────────────────
    "ripgrep",             # Needed for Telescope
    "fd",                  # Fast file search
    "lua",                 # Lua interpreter
    "python",              # Required for some LSP/debug tools
    "nodejs-lts",          # Node.js runtime
    "prettier",            # Formatter for JS, HTML, etc.
    "stylua",              # Lua formatter
    "gcc",                 # C/C++ compiler
    "clang",               # Optional: Clang toolchain
    # ── AI / Code Assist ───────────────────────────
#   "ollama",              # Local AI backend (if used)
    # ── Social / Productivity ──────────────────────
    "spotify",             # Music
#   "discord",             # Communication
#   "whatsapp",            # Messaging
#   "telegram",            # Messaging
#   "notion",              # Productivity & docs
    "twitter",             # Social browser-based PWA
    # ── Utilities ──────────────────────────────────
    "powertoys",           # PowerToys for Windows enhancements
    "7zip",                # File compression
    "everything",          # Local file search
    "qbittorrent",         # Torrent client
    "dotnet-sdk",          # Required for some LSPs & Omnisharp
    "curl",                # Networking
    "wget",                # Download utility
    "sudo",                # Unix-like sudo in Powershell
    "fzf",                 # Terminal fuzzy finder
    "jq",                  # JSON processor
    "bat",                 # `cat` alternative
    "htop",                # System monitor
    "neofetch",            # System info
    "nvm",                 # Node version manager
    "scoop-search",
    "git",
    "nodejs-lts",
    "python",
    "go",
    "ripgrep",
    "fd",
    "gh",
#   "delta",
    "less",
    "make",
    "gcc",
    "ninja",
#    "cmake",
#    "clink",
    "nodejs",
    "diffutils",
    # CLI for searching scoop buckets
    # ── Testing / Web Dev / Others ─────────────────
#   "chromedriver",        # Selenium/browser testing
#   "httpie",              # HTTP client for APIs
#   "postman",             # API testing GUI
    # ── Optional / Nice-to-Have ─────────────────────
#   "vlc",                 # Media player
#   "paint.net",           # Quick image editing
#   "sharex",              # Screenshot tool
#   "gimp",                # Advanced image editing
)

    foreach ($pkg in $packages) {scoop install $pkg}
# ───────────────────────────────────────────────────────────────
# NEOVIM CONFIG SETUP
# ───────────────────────────────────────────────────────────────
$ConfigDir = "$HOME\AppData\Local\nvim"
$DotfilesSource = "$HOME\.config\nvim" # Adjust if using git clone
if (-not (Test-Path $DotfilesSource)) {
    Write-Host "[!] Dotfiles not found in $DotfilesSource. You must clone or sync them first." -ForegroundColor Red
    exit 1}

if (-not (Test-Path $ConfigDir)) {
    New-Item -ItemType SymbolicLink -Path $ConfigDir -Target $DotfilesSource
    Write-Host "[✓] Created symlink: $ConfigDir -> $DotfilesSource"}
    else {Write-Host "[✓] Config directory already exists: $ConfigDir"}

# ───────────────────────────────────────────────────────────────
# FONTS (JETBRAINS MONO)
# ───────────────────────────────────────────────────────────────
# actual font but need for finding exact Font ( https://github.com/ryanoasis/nerd-fonts/releases)
$fontURL = "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip"
$fontZip = "$env:TEMP\JetBrainsMono.zip"
$fontDir = "$env:TEMP\JetBrainsMono"

Invoke-WebRequest $fontURL -OutFile $fontZip
Expand-Archive $fontZip -DestinationPath $fontDir -Force
$fontFiles = Get-ChildItem -Path $fontDir -Include *.ttf -Recurse

foreach ($font in $fontFiles) {Copy-Item $font.FullName -Destination "$env:WINDIR\Fonts"}

Write-Host "[✓] JetBrainsMono Nerd Font installed."

# ───────────────────────────────────────────────────────────────
# OH-MY-POSH THEME SETUP
# ───────────────────────────────────────────────────────────────
$poshThemeURL = "https://raw.githubusercontent.com/samo-l-b/my-posh-theme/main/theme.omp.json"
$themePath = "$HOME\AppData\Local\Programs\oh-my-posh\themes\custom.omp.json"
Invoke-WebRequest $poshThemeURL -OutFile $themePath
# Set permanent PowerShell profile
$ProfilePath = "$PROFILE"
if (-not (Test-Path $ProfilePath)) {New-Item -ItemType File -Path $ProfilePath -Force}

Add-Content -Path $ProfilePath -Value @"
oh-my-posh init pwsh --config "$themePath" | Invoke-Expression
"@

Write-Host "[✓] Oh My Posh theme set in $PROFILE"

# ───────────────────────────────────────────────────────────────
# LAZY.VIM INITIALIZATION
# ───────────────────────────────────────────────────────────────
nvim --headless "+Lazy! sync" +qa
Write-Host "[✓] Neovim plugins installed."
# ───────────────────────────────────────────────────────────────
# DONE 🎉
# ───────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "🚀 All done! Restart your terminal or run 'nvim' to begin your journey." -ForegroundColor Green
Write-Host ""
Write-Host "👉 If you customized your dotfiles: check :Lazy to enable/disable plugins."
Write-Host ""

