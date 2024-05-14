# Neovim Configuration

Starting out experimenting with Vim to do some code, heres my simple config for editing in python. 

As of now, I have gotten a basic setup to write and run python code with full linting, formatting and autofilling functionality. The code is run with a simple plugin that sends it to a REPL within Neovim

## Current plugins used:
- Lazy - Plugin manager
- Treesitter - syntax highlighting
- Telescope - fuzzy finding files, grepping through code
- Neotree - convenient to navigate through different files
- Mason, Mason-lspconfig, nvim-lspconfig - LSP support for linting, formatting
- cmp - autofilling
- nvim-repl - allows running and sending blocks of code to a terminal running ipython (if installed)

## Other settings
Some key remaps for QOL:
- CTRL + hjkl - navigates the cursor through different splits
- CTRL + arrowkeys - resizes the split 

Terminal mode:
- Esc - exits insert mode in terminal normally

Visual mode:
- Y - Yank yanks content to clipboard for pasting to external sources
<br />

The config file is  messy and unformatted, though I will most definitely be modifying it in the future so I will leave as such for now. Still, if you have the necessary apps installed in your system, running this config file should get you up and running!

## Installing Neovim
If you are interested in installing Neovim, heres the things I had to do to get it running on Windows: <br /><br />
First, things to install:
- Terminal: Good one is Windows Terminal Preview from msft store
- Shell: Windows powershell (Powershell Core).

I mainly used Scoop to install the packages. People like Scoop as it installs apps into a single separate directory. Powershell core can be installed using msi installer if you do not want to go through winget.

- Choose a Nerd font, download and right click all the files and install it. Go to settings in terminal and set to use the nerdfont just downloaded, under appearance
- Finnally install Git and Neovim <br />

Other things to install:
- ripgrep for telescope
- Treesitter may have error: "No C compliler found..." Use scoop/chocolatey to install mingw, then refreshenv in terminal.<br />
- When installing pyright with Mason (which this config does), you will have to intall/update node.js to version 20. This does not come natively on windows computers. To do this, install nvm-windows then run the following code to update node
```
nvm install latest
nvm use 22.1.0  #or watever version you downloaded
```
Thats all I remember for now, but I probably forgot some stuff.
