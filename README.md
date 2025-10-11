# LAX settings - README 

![BenvenidoBenny](https://i.imgur.com/27bUq.jpeg)

---

📚 In general, this file summarizes LAX digital approach respectively displays the most important settings when starting a new device. This includes the keyboard settings but also more in detail the setup of a proper PowerShell in order to facilitate quick access to do proper research. Additionally, the browser settings as well as the nvim settings are being displayed/explained.

---

## Table of Contents

- [Keyboard Configuration 🎹](#keyboard-configuration)
  - [Search 🧐](#search)
  - [Browse 📁](#browse)
  - [Create 🧮](#create)
  - [Trading 💸](#trading)
  - [Media 🎬](#media)
- [PowerShell settings 🖥️](#powershell-settings)
  - [Features 🌟](#features)
  - [Configuration 📁](#configuration)
  - [Setup 🚀](#setup)
  - [Web Search Commands ⭐](#web-search-commands)
  - [Supported Linux Commands 🐧](#supported-linux-commands)
- [Browser Settings 🖥️](#browser-settings)
  - [Features 🌟](#features-)
  - [Components Installed 🛠️](#components-installed-️)
  - [Configuration 📁](#configuration-)
  - [Usage 🚀](#usage-)
  - [Contributing 🤝](#contributing-)
  - [Personalization 🎨](#personalization-)
  - [License 📜](#license-)
- [NVIM/VIM settings 🖥️](#NVIM/VIM-settings)
  - [Features 🌟](#features-)
  - [Components Installed 🛠️](#components-installed-️)
  - [Configuration 📁](#configuration-)
  - [Usage 🚀](#usage-)
  - [Contributing 🤝](#contributing-)
  - [Personalization 🎨](#personalization-)
  - [License 📜](#license-)
- [Windows Settings 🖥️](#windows-settings)
  - [Features 🌟](#features-)
  - [Components Installed 🛠️](#components-installed-️)
  - [Configuration 📁](#configuration-)
  - [Usage 🚀](#usage-)
  - [Contributing 🤝](#contributing-)
  - [Personalization 🎨](#personalization-)
  - [License 📜](#license-)
- [NVIM/VIM settings 🖥️](#NVIM/VIM-settings)
---

## Keyboard Configuration

🎹 The ultimate goal of taking control via **1 key to go/be mentally**. It can be applied to any computer and/or mobile device. 


![KEY](https://png.pngtree.com/png-vector/20250518/ourmid/pngtree-elegant-golden-key-with-intricate-designs-depicted-on-a-transparent-background-png-image_16281536.png)

---


### Search

> 1️⃣
> ⛏️**alt-1**

**PowerShell** (laptop)

*(mobile):*
- Google/Gemini/Lens/Maps
- ChatGPT
- Grok
- Claude
- Perplexity
- DeepSeek
- Phind.com
- Wikipedia
- Giphy
- (Alexa/G-Assistant/Translate)

---

### Browse

> 2️⃣
> ⛏️**alt-2**

**Firefox** (laptop)

*(mobile):*
- Firefox
- Chrome
- Opera
- Calendar
- Explorer
- Gallery/Secure Folder
- One Drive
- Google Drive
- Google Photos
- Google Tasks
- Dropbox
- Google Play Store
- Research Gate

---

### Create

>3️⃣
> ⛏️**alt-3**

**VIM/NVIM** (laptop)

*(mobile):*
- GitHub
- Trello
- Visual Studio Code
- Ipynb Viewer
- Pydroid 3
- Samsung Notes
- Obsidian
- OneNote
- Excel
- Powerpoint
- Word
- Google Slides
- Google Docs
- Google Sheets
- QuickEdit
- Adobe Acrobat

---

### Trading

>4️⃣
> ⛏️**alt-4**

**TradingView** (laptop)

*(mobile)*:
- Kraken
- Stocktwits
- PayPal
- comdirect/photoTAN
- Sparkasse/S-pushTAN
- yahoofinance

---

### Media

>5️⃣
> ⛏️***alt-5***



***Calibre*** (laptop)

*(mobile):*
- Watching (VLC)
- Photoshop (GIMP)
- AnkiDroid
- X
- Reddit
- Substack
- YT
- ESPN
- Netflix
- PrimeVideo
- kicker
- ARD/ZDF
- WOW
- SkyGo
- Spotify
- Phonograph
- SoundCloud
- Genius
- radio.net
- Datpiff
- Yacht Cabin
- FB Messenger
- SeaPeople
- LinkedIn/Learning
- Audible
- Kindle
- GoogleTV
- Imgur
- Librera

  
[⬆️ Back to Table of Contents](#table-of-contents)

---
---

## PowerShell settings
![Powershell](https://cdn.icon-icons.com/icons2/2248/PNG/512/powershell_icon_136294.png)

Welcome to the underlying personal PowerShell profile repository for all LAX devices! This collection of PowerShell scripts is designed to bring personaltouch to the Powershell and enable quick access to the most important features of the Internet. Most importantly, it helps us to go mentally to the first SEARCH respectively RESEARCH function.


### Features

- **Bash-like Shell Experience**: Mimics Unix shell functionality, bringing familiarity to Windows PowerShell. 🐧
- **Oh My Posh Integration**: Enhances the user interface with stylish prompts and Git status indicators. ⚡
- **Deferred Loading**: Improves function loading time for a smoother experience. 🕒
- **Automatic Installation**: The scripts automatically install necessary modules and components on first execution. 🛠️
- **Terminal-Icons Module**: Enhances terminal UI with icons. 🎨
- **PoshFunctions**: Essential functions for PowerShell. ⚙️
- **PSReadLine**: Cmdlets for customizing the editing environment, used for autocompletion 🏋️
- **z**: Directory jumper 🏄‍♂️
- **PSFzf**: Fuzzy finder 🕵️
- **set-alias**: quick search & functional shortcuts ⏩
- **Hack Font**: personalized & visually attractive font ✍️

### Configuration

- The configuration file is located at: `~/powershell/user_profile.ps1' (functionality). 
- The oh-my-posh customization JSON file is located at `~/powershell/LAX.omp.json' (style/appearance)
- Both files should be stored in your '~/.config' folder. 
- Additionally, you should store the JSON file as well as the Microsoft.Powershell_profile.ps1 (located at: `~/powershell/ Microsoft.Powershell_profile.ps1) in your respective Powershell folder within the Documents folder (subfolder Powershell).
- The entire Directory structure should look like this:

<img width="1041" height="703" alt="grafik" src="https://github.com/user-attachments/assets/2de34758-997a-404a-8f21-e818d04e143d" />


### Setup

1. Install Font _Hack Bold italic Nerd Font Complete Mono_ (download & install: https://github.com/ryanoasis/nerd-fonts/releases) 
2. Configure Terminal (Windows Terminal): open WindowsPowershell + adjust default terminal in settings to TERMINAL + Appearance (acrylic in tab row) + Default Appearance Color One Half Dark + Default Appearance Text Hack NF & enable acrylic (10% opacity)
3. Download & Install PowerShell (Store) + change it to default shell
4. Change the terminal background color (copy paste this into the json settings file) + change color in default appearance
```
  {
    "$help": "https://aka.ms/terminal-documentation",
    "$schema": "https://aka.ms/terminal-profiles-schema",
    "actions": [],
    "copyFormatting": "none",
    "copyOnSelect": false,
    "defaultProfile": "{574e775e-4f2a-5b96-ac1e-a2962a402336}",
    "keybindings": 
    [
        {
            "id": "Terminal.CopyToClipboard",
            "keys": "ctrl+c"
        },
        {
            "id": "Terminal.PasteFromClipboard",
            "keys": "ctrl+v"
        },
        {
            "id": "Terminal.DuplicatePaneAuto",
            "keys": "alt+shift+d"
        }
    ],
    "newTabMenu": 
    [
        {
            "type": "remainingProfiles"
        }
    ],
    "profiles": 
    {
        "defaults": 
        {
            "colorScheme": "One Half Dark",
            "elevate": false,
            "font": 
            {
                "face": "Hack Nerd Font Mono"
            },
            "opacity": 10,
            "padding": "50",
            "useAcrylic": true
        },
        "list": 
        [
            {
                "commandline": "%SystemRoot%\\System32\\WindowsPowerShell\\v1.0\\powershell.exe",
                "guid": "{61c54bbd-c2c6-5271-96e7-009a87ff44bf}",
                "hidden": false,
                "name": "Windows PowerShell",
                "opacity": 14
            },
            {
                "commandline": "%SystemRoot%\\System32\\cmd.exe",
                "guid": "{0caa0dad-35be-5f56-a8ff-afceeeaa6101}",
                "hidden": false,
                "name": "Eingabeaufforderung"
            },
            {
                "guid": "{b453ae62-4e3d-5e58-b989-0a998ec441b8}",
                "hidden": false,
                "name": "Azure Cloud Shell",
                "source": "Windows.Terminal.Azure"
            },
            {
                "guid": "{574e775e-4f2a-5b96-ac1e-a2962a402336}",
                "hidden": false,
                "name": "PowerShell",
                "source": "Windows.Terminal.PowershellCore"
            },
            {
                "guid": "{2ece5bfe-50ed-5f3a-ab87-5cd4baafed2b}",
                "hidden": false,
                "name": "Git Bash",
                "source": "Git"
            }
        ]
    },
    "schemes": [
        {
            "name": "My Modified Dark",
            "foreground": "#DCDFE4",
            "background": "#282C34",
            "cursorColor": "#FFFFFF",
            "selectionBackground": "#FFFFFF",
            "black": "#282C34",
            "blue": "#61AFEF",
            "cyan": "#56B6C2",
            "green": "#98C379",
            "purple": "#C678DD",
            "red": "#E06C75",
            "white": "#DCDFE4",
            "yellow": "#E5C07B",
            "brightBlack": "#5A6374",
            "brightBlue": "#61AFEF",
            "brightCyan": "#56B6C2",
            "brightGreen": "#98C379",
            "brightPurple": "#C678DD",
            "brightRed": "#E06C75",
            "brightWhite": "#DCDFE4",
            "brightYellow": "#E5C07B"
        }
    ],
    "themes": [],
    "useAcrylicInTabRow": true
}
```

5. Install Scoop (comamnd-line installer) by using *iwr -useb get.scoop.sh | iex* & *scoop install curl sudo jq* (in commandline)
6. Install Git for Windows by using *winget install -e --id Git.Git* (in commandline)
7. Install Neovim by using *scoop install neovim gcc* (in commandline)
8. Make user profile save it to a C:\Users\*username*\.config\powershell\user_profile.ps1 file
9. Update Profile by first using *New-Item -ItemType Directory -Path (Split-Path -Parent $PROFILE.CurrentUserCurrentHost) -Force* (in commandline) then using *nvim $PROFILE.CurrentUserCurrentHost* (in commandline) and insert (*. $env:USERPROFILE\.config\powershell\user_profile.ps1*)
10. Install Oh My Posh (Prompt theme engine) (*Install-Module posh-git -Scope CurrentUser -Force* and *winget install JanDeDobbeleer.OhMyPosh --source winget --scope user --force* in command line in .conf\powershell\ directory) & copy paste LAX.omp.json in same folder as user_profile (C:\Users\*username*\.config\powershell\)
11. setup Git
'''
╰─❯ git config --global user.name "samo-L-B"
╰─❯ git config --global user.email "leon@andresen.at"
╰─❯ ssh-keygen -t ed25519 -C "leon@andresen.at"
'''
12. install node.js by using *scoop install nvm* & *nvm install 14.16.0* & *nvm use 14.16.0* (in command line)
13. install terminal icons by using *Install-Module -Name Terminal-Icons -Repository PSGallery -Force* & *Import-Module Terminal-Icons* (in commandline but actually in .config\powershell folder) 
14. install z by using '''Install-Module -Name z -Force''' (in commandline but actually in .config\powershell folder)
15. install PSReadLine by using '''Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck''' & '''Set-PSReadLineOption -PredictionViewStyle ListView'''' (in commandline but actually in .confiug\powershell folder)
16. install fzf by using '''scoop install fzf''' & '''Install-Module -Name PSFzf -Scope CurrentUser -Force''' & '''Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' - PSReadlineChordReversedHistory 'Ctrl+r''' (in commandline but actually in .confiug\powershell folder)
  
After finishing this process you can open a new powershell instance and enjoy the enhanced PowerShell experience! 🎉

### Web Search Commands

The PowerShell profile includes aliases and functions that mimic everyday workflow of LAX: (Start Process or)

- `google`: googles "search term".
- `wolframalpha`: direct access wolframalpha and search "equation/searchterm"
- `wiki`: wiki "search term".
- `wiki_de`: deutsches wiki "search term".
- `yt`: youtube "search term".
- `amazon`: searches amazon "search term".
- `bing`: bings "search term".
- `gemini`: starts google gemini
- `yf`: YahooFinance "search term". (search for Stock Tickers)
- `openinsider`: openinsider "search term". (search for Stock Tickers)
- `stockcharts`: stockcharts "search term". (search for Stock Tickers)
- `sec`: serches for SEC filings respectively insider transaactions "search term". (search for Stock Tickers)
- `seekingalpha`: seekingalpha "search term". (search for Stock Tickers)
- `gmail`: open googlemail
- `calendar`: open calendar
- `reddit`: open reddit
- `twitter`: open twitter

### Supported Linux Commands

The PowerShell profile includes aliases and functions that mimic common Linux commands, providing a familiar environment for users accustomed to Linux shell environments. Here are some of the supported Linux commands:

- `cd`: Changes the current directory. PowerShell equivalent: `Set-Location`.
- `ls`: Lists the contents of a directory. PowerShell equivalent: `Get-ChildItem`.
- `dirs`: Lists directories recursively.
- `sed`: Stream editor for filtering and transforming text.
- `which`: Locates a command.
- `export`: Sets environment variables. PowerShell equivalent: `Set-Item`.
- `pgrep`: Searches for processes by name. PowerShell equivalent: `Get-Process`.
- `grep`: Searches for patterns in files.
- `pkill`: Terminates processes by name.
- `head`: Displays the beginning of a file.
- `tail`: Displays the end of a file.
- `unzip`: Extracts files from a zip archive. PowerShell equivalent: function `expand-archive`.
- `du`: Displays disk usage statistics.
- `ll`: Lists files in a directory.
- `df`: Displays disk space usage. PowerShell equivalent: `Get-Volume`.
- `reboot`: Reboots the system.
- `poweroff`: Shuts down the system.
- `cd...`: Changes the directory to the parent's parent directory.
- `cd....`: Changes the directory to the parent's parent's parent directory.
- `md5`: Computes the MD5 hash of a file.
- `sha1`: Computes the SHA1 hash of a file.
- `sha256`: Computes the SHA256 hash of a file.
- `uptime`: Displays system uptime.
- `ssh-copy-key`: Copies SSH public keys to a remote server.
- `explrestart`: Restarts Windows Explorer.
- `expl`: Opens File Explorer at the currenct location.
- `Get-PubIP`: Retrieves the public IP address.
- `Get-PrivIP`: Retrieves the private IP address.
- `gitpush`: Also known as lazy-git, pulls, adds all, commits the message after gitpush and then pushes.
- `ptw`: Send text/files pipe output to a wastebin server, important: contact me via issue for this.

### Contributing 

- Feel free to fork, modify, and contribute improvements or additional features.
- For any issues, questions, or help, please create an issue in the repository. 💬
- These videos helped me to deepen my skills regarding the setting up of my config files (https://www.youtube.com/watch?v=5-aK2_WwrmM AND https://christitus.com/pretty-powershell/)

## Personalization 🎨

- Customize the scripts according to personal preferences or specific system requirements.
- To use a forked version, update the `githubUser` variable to point to your own forked repository.
- To insert your own OhMyPosh config, just fork the repo and change the URL in the main file to your own.

PowerShell setup (Windows) included installition of

    Scoop - A command-line installer
    Git for Windows
    Oh My Posh - Prompt theme engine
    Terminal Icons - Folder and file icons
    PSReadLine - Cmdlets for customizing the editing environment, used for autocompletion
    z - Directory jumper
    PSFzf - Fuzzy finder


[⬆️ Back to Table of Contents](#table-of-contents)

---

---


 # Browser Settings

![Firefox](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRzwexAU2kRlg1oqzxtyBLc6-B8Bjhj-Ej9Q&s)>)


---

# Personal Firefox Configuration 🖥️

Welcome to my personal Firefox profile settings! 🎉 This collection of Firefox scripts respectively Add-Ons, Designs, Themes, etc are designed to bring your personaltouch to the Mozilla Firefox.

Feel free to use, fork, and customize these scripts to enhance your own command-line experience. 🔧

## Features 🌟

- **Bash-like Shell Experience**: Mimics Unix shell functionality, bringing familiarity to Windows PowerShell. 🐧

## Components Installed 🛠️

Add-Ons:

- **A**: Enhances the user interface with stylish prompts and Git status indicators. ⚡
- **A**: Improves function loading time for a smoother experience. 🕒
- **A**: The scripts automatically install necessary modules and components on first execution. 🛠️

## Configuration 📁

- Check Add-Ons and enable respectively disable features you like or dislike.

## Usage 🚀

- Save those Files as described in Configuration
- Next try to adjust respectively tweak the appearance of your terminal/powershell and install all necessary packages.
-

After finishing this process you can open a new powershell instance and enjoy the enhanced PowerShell experience! 🎉

## Contributing 🤝

- Feel free to fork, modify, and contribute improvements or additional features.
- For any issues, questions, or help, please create an issue in the repository. 💬

## Personalization 🎨

- Customize the scripts according to personal preferences or specific system requirements.
- To insert your own OhMyPosh config, just fork the repo and change the URL in the main file to your own.


[⬆️ Back to Table of Contents](#table-of-contents)

---

---

---

# NVIM/VIM settings 

![NVIM](<[https://i.imgur.com/27bUq.jpeg](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRzwexAU2kRlg1oqzxtyBLc6-B8Bjhj-Ej9Q&s)>)

---

# Personal NVIM Configuration 🖥️

Welcome to my personal NVIM profile settings! 🎉 This collection of NVIM scripts respectively Plugins, Themes, etc are designed to bring your personaltouch to the NVIM text editor. There is still a lot of room for improvement.

Feel free to use, fork, and customize these scripts to enhance your own command-line experience. 🔧

## Features 🌟

- **Bash-like Shell Experience**: Mimics Unix shell functionality, bringing familiarity to Windows PowerShell. 🐧
- **lazy.vim**:
    - cloak.lua: Automatic activation for matched file patterns respectively customizable masking character (defaults to '*')
    :CloakDisable
    :CloakEnable
    :CloakToggle
    :CloakPreviewLine (temporarily reveals masked content)
    - colors.lua: colorscheme & transparency 
    - conform.lua:  automatic code formatting (for different languages (like clang-format for C/C++, stylua for Lua, and prettier for JavaScript)
    
optional?
    - dap.lua: complete setup for debugging code, including window management, UI controls, and automatic debugger installation
    :DAP (Debug Adapter Protocol) (F8-F12 for navigation)
    :shortcuts for different debug views (scopes, watches, etc.)
    :<F8> to start the debugger
    :<leader>b to set a breakpoint
    :<F10>: Step over (execute current line)
    :<F11>: Step into (enter functions)
    :<F12>: Step out (finish current function)
    ;<F8>: Continue to next breakpoint
    - fugitive.lua: shortcuts for git 
    :g<leader>gs: Opens Git status interface
    :<leader>p: Push changes to remote
    :<leader>P: Pull with rebase (keeps history clean)
    :<leader>t: Push with tracking (useful for new branches)
    :gu: Accept changes from left side
    :gh: Accept changes from right side
    -golf.lua: enhances Vim's built-in f/t; motion commands
    : f followed by any character: searches forward 
    : F followed by any character: searches backward
    : ; to repeat the search
    : , to repeat backward
    : t followed by any character: searches until before target
    : T followed by any character: searches backward until
    - jai.lua: jumplist navigation commands
    :Ctrl-I: Jump forward in the jump list
    :Ctrl-O: Jump backward in the jump list
    :ju: List all jump points
    - local.lua: manages local plugins
        - harpoon: navigation
            :<leader>a - Add current file
            :<leader>A - Prepend current file
            :<C-e> - Toggle quick menu
            :<C-h/t/n/s> - Jump to files 1-4
            :<leader><C-h/t/n/s> - Replace files 1-4
        - cursor-ai: 
            :<leader>ca opens panel
        - cockpit: testing interface for code
            :<leader>ct: Execute tests
            :<leader>cr: Refresh test results
    - lsp.lua: intelligent code editing
        :K         = Show documentation
        :gd        = Go to definition
        :gD        = Go to declaration
        :gr        = Find references
        :<lead=    = Format code (from conform.nvim)
        :<C-p>=    = Previous item
        :<C-n>=    = Next item
        :<C-y>     = Confirm selection
        :<C-Space> = Trigger completion
        :]d        = Next diagnostic
        :[d        = Previous diagnostic
        ;<leader>d = Show diagnostic under cursor
    - neotest.lua: powerful testing framework
        :<leader>tr	= run nearest test (execute test under cursor)
        :<leader>tv	= toggle test summary (view all available tests & their status
        :<leader>ts = run test suite (all tests)
        :<leader>td	= debug nearest test
        :<leader>to	= open test output
        :<leader>ta	= run directory tests
    - peek.lua: markdown preview plugin
        :PeekOpen - Opens the preview window
        :PeekClose - Closes the preview window
        ;use navigation keys to toggle arround (classical vim nav)
    -snippets.lua: creates snippet system that automatically expands predefined code templates + provides forward/backward navigation between snippet fields + enables choice selection for multiple options (work both insert mode (i) + select mode (s))
        :<C-s>e	Expand snippet (only in insert mode)
        :<C-s>; jump forward
        :C-s>, jump backwards
        :<C-E>   change choice
    - telescope: powerful fuzzy finder
        :<leader>pf	Find files (through all project files)
        :<C-p>	Git files (through tracked Git files)
        :<leader>pws	Word search (current word under cursor)
        :<leader>pWs	WORD search
        :<leader>ps	Interactive search	Search with custom input
        :<leader>vh	Help tags	Search through help documentation
    - tj: creates PHP development environment that provides syntax highlighting and parsing + enables PHP-specific features + integrates with Treesitter for enhanced capabilities + sets up basic PHP language support
        :<leader>pp	Run PHP files
        :<leader>pi	Organize imports	
        :<leader>pf	Format file	Standard
    - treesitter.lua: enhanced editing environment (enhanced syntax highlighting + smart identification + code context intendation + code context in different window)
    - trouble.lua: diagnostic viewer (shows errors, warnings, issues in a floating window + enables quick navigation between problems
        :<leader>tt to toggle the trouble window
        :[t to go to previous issue
        ; ]t to go to next issue
    - undotree.lua: visual undo/redo system
        :<leader>u to toggle the undotree window (j/k for nav -> enter to jump to specific change + use <leader>u again to close the window)
    - zenmode.lua: creates two focus modes
        : <leader>zz for focused mode with numbers
        : <leader>zZ for minimal distraction mode
        : press either again to toggle off



## Components Installed 🛠️

Add-Ons:

- **A**: Enhances the user interface with stylish prompts and Git status indicators. ⚡
- **A**: Improves function loading time for a smoother experience. 🕒
- **A**: The scripts automatically install necessary modules and components on first execution. 🛠️

## Configuration 📁

- Check Add-Ons and enable respectively disable features you like or dislike.

## Usage 🚀

- Save those Files as described in Configuration
- Next try to adjust respectively tweak the appearance of your terminal/powershell and install all necessary packages.
-

After finishing this process you can open a new powershell instance and enjoy the enhanced PowerShell experience! 🎉



[⬆️ Back to Table of Contents](#table-of-contents)


# Windows settings 🖥️

  Welcome to my personal windows settings! 🎉 In general, keep in mind that by increasing focus and avoiding distraction you benefit in your everyday life and your workflow. Always keep in mind that you are most productive when using linux instead of windows but sometimes you can't help it and you have to work with the system presen. All the info present are designed to bring your personaltouch to the windows OS. There is still a lot of room for improvement.

Feel free to use, fork, and customize these scripts to enhance your own command-line experience. 🔧

## MUST-HAVES 🌟

- *Virtual Desktops*: at least 4: main / coding / trading / media
--> MAIN:       everyday tasks/research
--> CODING:     (start olá beleza)
--> TRADING:    tradingview & start downtown81 
--> MEDIA:      spotify/youtube 
## Components Installed 🛠️

Software/Apps:
- Calibre
- Deepl
- Git
- Mozilla Firefox
- Opera
- PowerShell
- PowerToys
- Spotify
- TranslucentTB
- Trello
- X

## Configuration 📁

Install software preferably straight from the web and avoid Microsoft Store (some apps are not supported or running slowly in the version provided)
## Usage 🚀
 
- Be aware Satya Nadella respectively Bill Gates is a son of a bitch.
- Be aware that less > more.

[⬆️ Back to Table of Contents](#table-of-contents)

--------------------------------------------------------------------------------------------------------------
## Contributing 🤝

- Feel free to fork, modify, and contribute improvements or additional features.
- For any issues, questions, or help, please create an issue in the repository. 💬

## Personalization 🎨

- Customize the scripts according to personal preferences or specific system requirements.
- To insert your own OhMyPosh config, just fork the repo and change the URL in the main file to your own.

## License 📜

This project is licensed under the LAX licence. README was initialized 2022. DO NOT FUCK WITH THE LAX!

_Developed by samo-L-B with ❤️_
