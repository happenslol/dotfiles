local cmd, fn = vim.cmd, vim.fn
local g, o, wo, bo = vim.g, vim.o, vim.wo, vim.bo

local packer = require "packer".startup(function()
  use "wbthomason/packer.nvim"

  -- Util and libraries
  use "svermeulen/vimpeccable"
  use "nvim-lua/plenary.nvim"
  use "nvim-lua/popup.nvim"

  -- Themeing
  use { "kaicataldo/material.vim", branch = "main" }
  use "kyazdani42/nvim-web-devicons"
  use { "RRethy/vim-hexokinase", run = "make hexokinase" }

  -- Syntax highlighting
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }

  -- Fuzzy finding
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-fzy-native.nvim"

  -- LSP
  use "neovim/nvim-lspconfig"
  use "hrsh7th/nvim-compe"
  use "onsails/lspkind-nvim"
  use "ray-x/lsp_signature.nvim"
  use "glepnir/lspsaga.nvim"

  -- File browsing and status
  use "kyazdani42/nvim-tree.lua"
  use { "glepnir/galaxyline.nvim", branch = "main" }
  use "farmergreg/vim-lastplace"
  use "airblade/vim-gitgutter"

  -- Code formatting
  use "tpope/vim-surround"
  use { "b3nj5m1n/kommentary", branch = "main" }
  use "windwp/nvim-autopairs"
  use "FooSoft/vim-argwrap"
  use "sbdchd/neoformat"
  use { "windwp/nvim-ts-autotag", branch = "main" }

  -- Language plugins
  use { "JoosepAlviste/nvim-ts-context-commentstring", branch = "main" }
  use "mattn/vim-goimpl"

end)

require "nvim-ts-autotag".setup()
require "nvim-autopairs".setup()

-- Telescope
local telescope = require "telescope"
local telescope_actions = require "telescope.actions"

telescope.load_extension "fzy_native"
telescope.setup {
  defaults = {
    prompt_position = "top",
    sorting_strategy = "ascending",
    layout_strategy = "center",
    width = 120,
    results_height = 20,

    borderchars = {
      { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
      prompt = {"─", "│", " ", "│", "╭", "╮", "│", "│"},
      results = {"─", "│", "─", "│", "├", "┤", "╯", "╰"},
      preview = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
    },

    mappings = {
      i = {
        ["<esc>"] = telescope_actions.close,
        ["<C-j>"] = telescope_actions.move_selection_next,
        ["<C-k>"] = telescope_actions.move_selection_previous,
      }
    }
  }
}

-- nvim-tree
local tree_cb = require('nvim-tree.config').nvim_tree_callback
vim.g.nvim_tree_show_icons = {
  ["git"] = 0,
  ["folders"] = 1,
  ["files"] = 1
}

vim.g.nvim_tree_bindings = {
  ["s"] = tree_cb("vsplit"),
  ["i"] = tree_cb("split")
}

vim.g.nvim_tree_group_empty = 1

-- Treesitter
require "nvim-treesitter.configs".setup {
  ensure_installed = "maintained",
  indent = { enable = true },
  highlight = { enable = true },
}

wo.foldmethod = "expr"
wo.foldexpr = "nvim_treesitter#foldexpr()"
o.foldlevelstart = 99

-- neoformat
g.neoformat_enabled_go = { "goimports" }

-- Hexokinase
g.Hexokinase_highlighters = { "virtual" }

-- Disable git gutter signs
g.gitgutter_signs = 0

return packer
