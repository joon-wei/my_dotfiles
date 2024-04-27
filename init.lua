-- NVIM Config File

-- load Lazy package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- set plugins and opts tuple
local plugins = {
	{"rebelot/kanagawa.nvim", name = kanagawa, priority = 1000},
	{'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
	{'nvim-telescope/telescope.nvim', tag = '0.1.6', dependencies = { 'nvim-lua/plenary.nvim' }},
	{"nvim-neo-tree/neo-tree.nvim", branch = "v3.x",
	dependencies = {"nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim",}},
	{"williamboman/mason.nvim",
	 "williamboman/mason-lspconfig.nvim",
	 "neovim/nvim-lspconfig",},
	 {'hrsh7th/nvim-cmp',
	  'L3MON4D3/LuaSnip',
	  'saadparwaiz1/cmp_luasnip',
	  'rafamadriz/friendly-snippets',
  	  'hrsh7th/cmp-nvim-lsp'},
	  {'nvimtools/none-ls.nvim'},
	  {"pappasam/nvim-repl",
      init = function()
      vim.g["repl_filetype_commands"] = {
      javascript = "node",
      python = "ipython --no-autoindent"
  }
  end,
  }

}
local opts = {}

require("lazy").setup(plugins, opts)


-- set colourscheme
vim.cmd("colorscheme kanagawa-wave")

-- config Treesitter
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  auto_install = true,
  ignore_install = { "javascript" },

  highlight = {
    enable = true,

    disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    additional_vim_regex_highlighting = false,
  },
}

-- Config for Telescope, setting keybindings for usage
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Config for Neotree
require("neo-tree").setup({
    window = {position = "left", width = 30},
})
vim.keymap.set('n', '<leader>t', ':Neotree<CR>')

-- Config for Mason
require('mason').setup()
require('mason-lspconfig').setup({
	ensure_installed = {"pyright", "lua_ls"},
})
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')

lspconfig.pyright.setup{capabilities = capabilities}
lspconfig.lua_ls.setup{capabilities = capabilities}
vim.keymap.set('n', '<leader>K', vim.lsp.buf.hover, {})
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, {})
vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})

-- Config for cmp
local cmp = require'cmp'
require("luasnip.loaders.from_vscode").lazy_load()
cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
             end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
    }, {
      { name = 'buffer' },
    })
  })

-- Config for null-ls 
local null_ls = require("null-ls")
null_ls.setup({ sources = {
		null_ls.builtins.formatting.black,
		null_ls.builtins.diagnostics.flake8
	    },
})
vim.keymap.set("n","<leader>fm", vim.lsp.buf.format,{})

-- Config for nvim-repl
vim.cmd("nnoremap <Leader>rt <Cmd>ReplToggle<CR>")
--vim.cmd("nmap     <Leader>rc <Plug>ReplSendCell")
vim.cmd("nmap     <Leader>rr <Plug>ReplSendLine")
vim.cmd("xmap     <Leader>rv  <Plug>ReplSendVisual")
vim.cmd("nnoremap <Leader>rc <Cmd>ReplRunCell<CR>")

-- Other settings
vim.cmd("set number")
vim.cmd("set splitbelow splitright")

-- Remap splits navigation to CTRL + hjkl
vim.cmd("nnoremap <C-h> <C-w>h")
vim.cmd("nnoremap <C-j> <C-w>j")
vim.cmd("nnoremap <C-k> <C-w>k")
vim.cmd("nnoremap <C-l> <C-w>l")

-- Remap adjusting split sizes to CTRL + arrow key 
vim.cmd("nnoremap <silent> <C-Left> :vertical resize +3<CR>")
vim.cmd("nnoremap <silent> <C-Right> :vertical resize -3<CR>")
vim.cmd("nnoremap <silent> <C-Up> :resize +3<CR>")
vim.cmd("nnoremap <silent> <C-Down> :resize -3<CR>")

-- Setting Tab spacings
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- Remapping simple escape key in terminal mode
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])

-- Clipboard support
vim.cmd("set clipboard+=unnamedplus")

--[[
First, things to intall:
Better Terminal: Windows Terminal Preview from msft store
Better shell: Windows powershell (cross platform). Can use winget or chocolatey to install. Set as default shell in terminal.
Nerd font, download and right click all the files and install it. Go settings in terminal and set nerdfont under appearance
Install neovim and Git with Scoop or winget or chocolatey.
Other things to install:
 -ripgrep for telescope
 -Treesitter may have error: No C compliler found. Use chocolatey to install mingw, then refreshenv in terminal.
For Python:
nvm for windows, update node version with nvm install latest
Remember to set python in the PATH environment variables: Start > environment variables or smth > in system variables find PATH and edit > add the location which python is installed. (Move up above microsoft store)
Same for ipython.

Thats all I remember for now, but I prob forgot some stuff.
--]]
