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
- Shell: Windows powershell (cross platform).

I used 3 different package managers: Winget, Chocolatey and Scoop. People like Scoop as it installs apps into a single separate directory. As much as I wanted to stick to using Scoop, I realised some things which I needed are only available in certain package managers. I should look at optimising this in the future.

- Choose a Nerd font, download and right click all the files and install it. Go to settings in terminal and set to use the nerdfont just downloaded, under appearance
- Finnally install Neovim and Git<br />

Other things to install:
- ripgrep for telescope
- Treesitter may have error: "No C compliler found..." Use chocolatey to install mingw, then refreshenv in terminal.<br />

Thats all I remember for now, but I probably forgot some stuff.
