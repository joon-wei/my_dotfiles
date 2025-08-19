-- ~/.config/nvim/init.lua

-- Bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup plugins
require("lazy").setup({
	-- Theme
	{
	  "ronisbr/nano-theme.nvim",
	  init = function ()
		 vim.o.background = "light" -- or "dark".
	  end
	},

  -- LSP Support
  {"williamboman/mason.nvim", config = true},
  {"williamboman/mason-lspconfig.nvim"},
  {"neovim/nvim-lspconfig"},

  -- Autocompletion
  {"hrsh7th/nvim-cmp"},
  {"hrsh7th/cmp-nvim-lsp"},
  {"hrsh7th/cmp-buffer"},
  {"hrsh7th/cmp-path"},
  {"hrsh7th/cmp-cmdline"},
  {"L3MON4D3/LuaSnip"}, -- snippets engine
})

-- Setup LSP
local lspconfig = require("lspconfig")
local cmp = require("cmp")

-- nvim-cmp setup
cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  }),
})

-- LSP capabilities for completion
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Ensure pyright is installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
  ensure_installed = { "pyright" },
})

-- Use setup_handlers if available (new API), otherwise fall back
if mason_lspconfig.setup_handlers then
  mason_lspconfig.setup_handlers({
    function(server_name)
      lspconfig[server_name].setup({
        capabilities = capabilities,
      })
    end,
  })
else
  -- Fallback for older versions of mason-lspconfig
  for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
    lspconfig[server_name].setup({
      capabilities = capabilities,
    })
  end
end

-- Basic keymaps for LSP
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })

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
