# LAX settings - README

![BenvenidoBenny](https://i.imgur.com/27bUq.jpeg)

---

In general, this file summarizes LAX digital approach respectively displays the most important settings when starting a new device.

---

## Table of Contents


- [0. Keyboard Configuration (LAX Settings) 🎹](#0-keyboard-configuration-lax-settings)
- [1. PowerShell settings (LAX settings) 🖥️](#1-powershell-settings-lax-settings)
  - [Features 🌟](#features)
  - [Configuration 📁](#configuration)
  - [Usage 🚀](#usage)
  - [Web Search Commands ⭐](#web-search-commands)
---

This includes the keyboard settings but also more in detail the setup of a proper PowerShell in order to facilitate quick access to do proper research.

---

## 0. Keyboard Configuration (LAX Settings)

The ultimate goal of taking control via **1 key to go/be mentally:**

### **alt-one**: *search*
- Google/Gemini
- ChatGPT
- Claude
- Perplexity
- DeepSeek
- Phind.com

### **alt-two**: *browse*
- Firefox
- Oracle
- Calendar
- Explorer

### **alt-three**: *create/programming*
- Vim
- Visual Studio Code
- Trello

### **alt-four**: *trading*
- TradingView

### **alt-five**: *media*
- Reading (Calibre)
- Watching (VLC)
- Photoshop (GIMP)

---

## 1. PowerShell settings (LAX settings)

![Powershell](https://cdn.icon-icons.com/icons2/2248/PNG/512/powershell_icon_136294.png)

Welcome to my personal PowerShell profile repository! 🎉 This collection of PowerShell scripts is designed to bring LAX personaltouch to the Powershell and enable quick access to the most important features of the Internet.

Feel free to use, fork, and customize these scripts to enhance your own command-line experience. 🔧

### Features

- **Bash-like Shell Experience**: Mimics Unix shell functionality, bringing familiarity to Windows PowerShell. 🐧
- **Oh My Posh Integration**: Enhances the user interface with stylish prompts and Git status indicators. ⚡
- **Deferred Loading**: Improves function loading time for a smoother experience. 🕒
- **Automatic Installation**: The scripts automatically install necessary modules and components on first execution. 🛠️

- **Terminal-Icons Module**: Enhances terminal UI with icons. 🎨
- **PoshFunctions**: Essential functions for PowerShell. ⚙️
- **Oh My Posh**: Provides customizable prompt themes and init my personal start theme. 🎨
- **PSReadLine**: Cmdlets for customizing the editing environment, used for autocompletion
- **z**: Directory jumper
- **PSFzf**: Fuzzy finder

### Configuration

- The configuration file is located at: `~/powershell/usr_profile.ps1 and the oh-my-posh JSON file is located at `~/powershell/andresen.omp.json.
- Both files should be stored in your .config folder.
- Additionally, you should store the JSON file as well as the Microsoft.Powershell_profile.ps1 (located at: `~/powershell/ Microsoft.Powershell_profile.ps1) in your respective Powershell folder within the Documents folder (subfolder Powershell).

### Usage

- Save those Files as described in Configuration
- Next try to adjust respectively tweak the appearance of your terminal/powershell and install all necessary packages.
- More in detail:
- Configure Windows Terminal
- Install Font _Hacker Nerd Font Mono_ (Installs a stylish font for code readability)
- Install PowerShell
- Change the default shell
- Change the terminal background color
- Install Scoop (Comamnd-line installer) iwr -useb get.scoop.sh | iex (in commandline)
- Install Git for Windows
- Install Neovim
- Make a user profile link it to a .config file folder which is in your User directory ()
- Install Oh My Posh (Prompt theme engine) (Install-Module posh-git -Scope CurrentUser -Force and Install-Module oh-my-posh -Scope CurrentUser -Force in .conf\powershell\ directory)
- Install Terminal Icons
- Install z - Directory jumper
- Install PSReadLine - Autocompletion
- Install Fzf - Fuzzy finder

After finishing this process you can open a new powershell instance and enjoy the enhanced PowerShell experience! 🎉

### Web Search Commands ⭐

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

## Supported Linux Commands 🐧

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

## Contributing 🤝

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

---

---

<h2> LAX settings - Firefox  </h2>

![Firefox](<[https://i.imgur.com/27bUq.jpeg](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRzwexAU2kRlg1oqzxtyBLc6-B8Bjhj-Ej9Q&s)>)

# Contents

- [Contents](#contents)
- [LAX Personal Firefox Configuration 🖥️](#personal-firefox-configuration)
  - [TL:DR](#tldr)
  - [Features 🌟](#features-)
  - [Components Installed 🛠️](#components-installed-️)
  - [Configuration 📁](#configuration-)
  - [Usage 🚀](#usage-)
  - [Contributing 🤝](#contributing-)
  - [Personalization 🎨](#personalization-)
  - [License 📜](#license-)

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

---

---

---

<h2> LAX settings - nvim  </h2>

![NVIM](<[https://i.imgur.com/27bUq.jpeg](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRzwexAU2kRlg1oqzxtyBLc6-B8Bjhj-Ej9Q&s)>)

# Contents

- [Contents](#contents)
- [LAX Personal Nvim Configuration 🖥️](#personal-firefox-configuration)
  - [TL:DR](#tldr)
  - [Features 🌟](#features-)
  - [Components Installed 🛠️](#components-installed-️)
  - [Configuration 📁](#configuration-)
  - [Usage 🚀](#usage-)
  - [Contributing 🤝](#contributing-)
  - [Personalization 🎨](#personalization-)
  - [License 📜](#license-)

---

# Personal NVIM Configuration 🖥️

Welcome to my personal NVIM profile settings! 🎉 This collection of NVIM scripts respectively Plugins, Themes, etc are designed to bring your personaltouch to the NVIM text editor. There is still a lot of room for improvement.

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

## License 📜

This project is licensed under the LAX licence. DO NOT FUCK WITH THE LAX!

---

_Developed by samo-L-B with ❤️_
