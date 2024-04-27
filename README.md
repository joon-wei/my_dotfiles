# Neovim Configuration

TLDR; Starting out experimenting with Vim to code, heres my simple config for editing in python. 

## Background
Recently I got into Vim for doing some coding. Expectation: Fully customisable configuration and optimised keybindings (I _love_ not having to reach for the mouse). In reality: One of the steepest learning curves in the history of learning curves.

Vim is the first software in my life which took me a solid couple of days just to learn how to write in a txt file, but it is truly one of the most fulfilling experiences when everything works in sync and runs smoothly, and the level of workflow optimisation that can be achieved with nvim is incredible. As a computer nerd, I'm definitely going to continue explore the world of vim.

As of now, I have gotten a basic setup to write and run python code in Vim, with full linting, formatting and autofilling functionality. It feels awesome! I am hoping to explore functionality to link Vim with Jupyter console to run plots, and to run R files within Vim as well. I know there are packages which allow python functionality in R and vice versa, can't wait to explore more on that area and how that can integrate with the Vim workflow. An awesome end goal set up for me would be a configuration which allows seamless work in python and R.

Also, there are convenient packs such as Kickstart project and Nvchad configuration which automatically provides a 1-stop configuration to get started with an environment to code in. I may use those in the future if I get stuck with my own, but I defintely wanted to try my hand at creating my own setup so I can understand the functionality of each plugin better, as well as get a bit of experience in lua. If you are just starting out Vim, I'd recommend creating your own config too! You're already in the rabbit hole, might as well get used to it down here.

## The Meat and Potatoes
### Current plugins used:
- Lazy - Plugin manager
- Treesitter - syntax highlighting
- Telescope - fuzzy finding files, grepping through code
- Neotree - convenient to navigate through different files
- Mason, Mason-lspconfig, nvim-lspconfig - LSP support for linting, formatting and autofilling
- nvim-repl - allows running and sending blocks of code to a terminal running ipython (if installed)

Some key remaps for QOL:
- CTRL + hjkl - navigates the cursor through different splits
- CTRL + arrowkeys - resizes the split 

Terminal mode:
- Esc - exits insert mode in terminal normally

Visual mode:
- Y - Yank now yanks content to clipboard for pasting to external sources
<br />
The config file is  messy and unformatted, though I will most definitely be modifying it in the future so I will leave as such for now. Still, if you have the necessary apps installed in your system, running Neovim with this config file should get you up and running!

## Installing Neovim
If you are interested in installing Neovim, heres the things I had to do to get it running on Windows: <br /><br />
First, things to install:
- Better Terminal: Good one is Windows Terminal Preview from msft store
- Better shell: Windows powershell (cross platform). Download using winget or chocolatey. Set as default shell in terminal settings.

I used 3 different package managers: Winget, Chocolatey and Scoop. People like Scoop as it installs apps into a single separate directory. As much as I wanted to stick to using 1 package manager for most things (Scoop), I realise some things which I needed are only available in certain package managers. Perhaps I will look at optimising this in the future.

- Choose a Nerd font, download and right click all the files and install it. Go to settings in terminal and set to use the nerdfont just downloaded, under appearance
- Install neovim and Git (I used scoop)<br />

Other things to install:
- ripgrep for telescope
- Treesitter may have error: "No C compliler found..." Use chocolatey to install mingw, then refreshenv in terminal.<br />

For Python:
- Download nvm for windows, update node version with `nvm install latest`
- Remember to set python in the PATH environment variables: Start menu > Edit system environment variables > in system variables find PATH and edit > add the location which python is installed. (Move up above microsoft store, as it reads for variables from top to bottom.)
- Same for ipython.

Thats all I remember for now, but I probably forgot some stuff.
