-------------------------------------------------------------------------------
-- These are example settings to use with nvim-metals and the nvim built-in
-- LSP. Be sure to thoroughly read the `:help nvim-metals` docs to get an
-- idea of what everything does. Again, these are meant to serve as an example,
-- if you just copy pasta them, then should work,  but hopefully after time
-- goes on you'll cater them to your own liking especially since some of the stuff
-- in here is just an example, not what you probably want your setup to be.
--
-- Unfamiliar with Lua and Neovim?
--  - Check out https://github.com/nanotee/nvim-lua-guide
--
-- The below configuration also makes use of the following plugins besides
-- nvim-metals, and therefore is a bit opinionated:
--
-- - https://github.com/hrsh7th/nvim-cmp
--   - hrsh7th/cmp-nvim-lsp for lsp completion sources
--   - hrsh7th/cmp-vsnip for snippet sources
--   - hrsh7th/vim-vsnip for snippet sources
--
-- - https://github.com/wbthomason/packer.nvim for package management
-- - https://github.com/mfussenegger/nvim-dap (for debugging)
-------------------------------------------------------------------------------

local api = vim.api
local cmd = vim.cmd
local map = vim.keymap.set
local opt = vim.opt

----------------------------------
-- PLUGINS -----------------------
----------------------------------
cmd([[packadd packer.nvim]])
require("packer").startup(function(use)
  use({ "wbthomason/packer.nvim", opt = true })
  use({ "preservim/nerdtree" })
  use({ "pocco81/auto-save.nvim" })
  use({ "airblade/vim-gitgutter" })
  use({ "rafi/awesome-vim-colorschemes" })
  use({ "vim-airline/vim-airline" })
  use({ "vim-airline/vim-airline-themes" })
  use({ "tpope/vim-fugitive" })
  use({ "sindrets/diffview.nvim" })
  use({ "nvim-tree/nvim-web-devicons" })
  use({ "tpope/vim-surround" })
  use { "junegunn/fzf", run = ":call fzf#install()" }
  use { "junegunn/fzf.vim" }
  use { "neovim/nvim-lspconfig" }
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-vsnip" },
      { "hrsh7th/vim-vsnip" },
    },
  })
  use({
    "scalameta/nvim-metals",
    requires = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
  })
  use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate"
  }
end)

-- LSP mappings
map("n", "gd",  vim.lsp.buf.definition)
map("n", "K",  vim.lsp.buf.hover)
map("n", "gi", vim.lsp.buf.implementation)
map("n", "gr", vim.lsp.buf.references)
map("n", "gds", vim.lsp.buf.document_symbol)
map("n", "gws", vim.lsp.buf.workspace_symbol)
map("n", "<leader>cl", vim.lsp.codelens.run)
map("n", "<leader>sh", vim.lsp.buf.signature_help)
map("n", "<leader>rn", vim.lsp.buf.rename)
map("n", "<leader>f", vim.lsp.buf.format)
map("n", "<leader>ca", vim.lsp.buf.code_action)

map("n", "<leader>ws", function()
  require("metals").hover_worksheet()
end)

-- all workspace diagnostics
map("n", "<leader>aa", vim.diagnostic.setqflist)

-- all workspace errors
map("n", "<leader>ae", function()
  vim.diagnostic.setqflist({ severity = "E" })
end)

-- all workspace warnings
map("n", "<leader>aw", function()
  vim.diagnostic.setqflist({ severity = "W" })
end)

-- buffer diagnostics only
map("n", "<leader>d", vim.diagnostic.setloclist)

map("n", "[c", function()
  vim.diagnostic.goto_prev({ wrap = false })
end)

map("n", "]c", function()
  vim.diagnostic.goto_next({ wrap = false })
end)

-- completion related settings
-- This is similiar to what I use
local cmp = require("cmp")
cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "vsnip" },
  },
  snippet = {
    expand = function(args)
      -- Comes from vsnip
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    -- None of this made sense to me when first looking into this since there
    -- is no vim docs, but you can't have select = true here _unless_ you are
    -- also using the snippet stuff. So keep in mind that if you remove
    -- snippets you need to remove this select
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    -- I use tabs... some say you should stick to ins-completion but this is just here as an example
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  }),
})

----------------------------------
-- LSP Setup ---------------------
----------------------------------
local metals_config = require("metals").bare_config()

-- Example of settings
metals_config.settings = {
  showImplicitArguments = true,
  excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
}

metals_config.init_options.statusBarProvider = "on"

-- Example if you are using cmp how to make sure the correct capabilities for snippets are set
metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Debug settings if you're using nvim-dap
local dap = require("dap")

dap.configurations.scala = {
  {
    type = "scala",
    request = "launch",
    name = "RunOrTest",
    metals = {
      runType = "runOrTestFile",
      --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
    },
  },
  {
    type = "scala",
    request = "launch",
    name = "Test Target",
    metals = {
      runType = "testTarget",
    },
  },
}

metals_config.on_attach = function(client, bufnr)
  require("metals").setup_dap()
end

-- Autocmd that will actually be in charging of starting the whole thing
local nvim_metals_group = api.nvim_create_augroup("nvim-metals", { clear = true })
api.nvim_create_autocmd("FileType", {
  -- NOTE: You may or may not want java included here. You will need it if you
  -- want basic Java support but it may also conflict if you are using
  -- something like nvim-jdtls which also works on a java filetype autocmd.
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})

-- vim.opt_global.shortmess:remove("F")

----------------------------------
-- OPTIONS -----------------------
----------------------------------
-- global
vim.opt_global.completeopt = { "menuone", "noinsert", "noselect" }

-- tabbing
vim.cmd([[
set autoindent
set tabstop=4
set shiftwidth=4
]])

-- navigate between panels
vim.cmd([[
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
]])

-- enable theme
vim.cmd([[
set termguicolors
set background=dark
]])
vim.g.airline_theme = "molokai"
vim.g.airline_powerline_fonts = 1
vim.cmd("colorscheme molokai")

-- nerd tree
map("n", "<C-t>", "<CMD>:NERDTreeToggle<CR>")
map("n", "<C-f>", "<CMD>:NERDTreeFocus<CR>")
vim.g.NERDTreeWinSize = 50

-- system clipboard
vim.cmd("set clipboard=unnamedplus")

-- quick save and quit
map("n", "<leader>u", "<CMD>:update<CR>")
map("n", "<leader>x", "<CMD>:qall<CR>")
map("n", "<leader>z", "<CMD>:q<CR>")
map("n", "<leader>a", "<CMD>:ASToggle<CR>", {})

-- line numbers
vim.cmd("set number")

-- FZF
map("n", "<C-p>", "<CMD>:FZF<CR>")

-- hlsearch
map("n", "<leader>s", "<CMD>:nohlsearch<CR>")

-- split
map("n", "<leader>hs", "<CMD>:split<CR>")
map("n", "<leader>vs", "<CMD>:vsplit<CR>")
map("n", "<leader>d", "<CMD>:Gdiffsplit<CR>")

vim.g.gitgutter_grep = 'rg'
vim.cmd([[set signcolumn=yes:1]])

-- tree-sitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
  sync_install = false,
  auto_install = true,
  ignore_install = { "scala" },
  highlight = {
    enable = true,
    disable = { "rust", "scala" },
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

-- lsp config
local lspconfig = require('lspconfig')
lspconfig.smithy_ls.setup {}
lspconfig.tsserver.setup {}
