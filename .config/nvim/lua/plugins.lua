local util = require "util"

require "packer".startup(function()
  use "wbthomason/packer.nvim"

  -- Util and libraries
  use "LionC/nest.nvim"
  use "nvim-lua/plenary.nvim"
  use "nvim-lua/popup.nvim"

  -- Themeing
  use "kaicataldo/material.vim"
  use "kyazdani42/nvim-web-devicons"
  use { "RRethy/vim-hexokinase", run = "make hexokinase" }

  -- Syntax highlighting
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }

  -- Fuzzy finding
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-fzy-native.nvim"

  -- LSP
  use "neovim/nvim-lspconfig"
  use "L3MON4D3/LuaSnip"
  use { "hrsh7th/nvim-cmp", requires = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
  }}

  use "onsails/lspkind-nvim"
  use "ray-x/lsp_signature.nvim"
  use "glepnir/lspsaga.nvim"

  -- File browsing and status
  use "kyazdani42/nvim-tree.lua"
  use "glepnir/galaxyline.nvim"
  use "farmergreg/vim-lastplace"
  use "airblade/vim-gitgutter"

  -- Code formatting
  use "tpope/vim-surround"
  use "b3nj5m1n/kommentary"
  use "windwp/nvim-autopairs"
  use "FooSoft/vim-argwrap"
  use "sbdchd/neoformat"
  use "windwp/nvim-ts-autotag"

  -- Language plugins
  use "JoosepAlviste/nvim-ts-context-commentstring"
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
    sorting_strategy = "ascending",
    layout_strategy = "center",

    layout_config = {
      prompt_position = "top",
      width = 120,
    },

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

util.set_global {
  nvim_tree_show_icons = {
    ["git"] = 1,
    ["folders"] = 1,
    ["files"] = 1
  },

  nvim_tree_bindings = {
    { key = "s", cb = tree_cb("vsplit") },
    { key = "i", cb = tree_cb("split") },
  },

  nvim_tree_group_empty = 1,
  nvim_tree_lsp_diagnostics = 1,
  nvim_tree_disabled_window_picker = 1,
}

-- Treesitter
require "nvim-treesitter.configs".setup {
  ensure_installed = "maintained",
  indent = { enable = true },
  highlight = { enable = true },
}

util.set_opt {
  foldmethod = "expr",
  foldexpr = "nvim_treesitter#foldexpr()",
  foldlevelstart = 99,
}

util.set_global {
  -- neoformat
  neoformat_enabled_go = { "goimports" },

  -- Hexokinase
  Hexokinase_highlighters = { "virtual" },

  -- GitGutter
  gitgutter_signs = 0,
}
