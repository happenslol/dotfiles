local packer_config = {
  display = {
    open_fn = function()
      return require "packer.util".float({ border = "rounded" })
    end,
  },
}

require "packer".startup({function()
  use "wbthomason/packer.nvim"

  -- Util and libraries
  use "LionC/nest.nvim"
  use "nvim-lua/plenary.nvim"
  use "nvim-lua/popup.nvim"
  use  { "antoinemadec/FixCursorHold.nvim",
    config = function()
      require "util".set_global {
        cursorhold_updatetime = 100,
      }
    end,
  }

  -- Themeing
  use "kaicataldo/material.vim"
  use "kyazdani42/nvim-web-devicons"
  use { "RRethy/vim-hexokinase",
    run = "make hexokinase",
    config = function()
      require "util".set_global {
        Hexokinase_highlighters = { "virtual" },
      }
    end,
  }

  -- Syntax highlighting
  use { "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require "nvim-treesitter.configs".setup {
        ensure_installed = "maintained",
        indent = { enable = true },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = true,
        },
        autotag = { enable = false, },
        context_commentstring = { enable = true, },
      }

      require "util".set_opt {
        foldmethod = "expr",
        foldexpr = "nvim_treesitter#foldexpr()",
        foldlevelstart = 99,
      }

      require "tstheme".setup_hi()
    end,
  }

  -- Fuzzy finding
  use { "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-telescope/telescope-fzy-native.nvim",
      "edolphin-ydf/goimpl.nvim",
      "tami5/sqlite.lua",
      "nvim-telescope/telescope-frecency.nvim",
    },
    config = function()
      local telescope = require "telescope"
      local telescope_actions = require "telescope.actions"

      telescope.load_extension "fzy_native"
      telescope.load_extension "goimpl"
      telescope.load_extension "frecency"

      telescope.setup {
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = telescope_actions.close,
              ["<c-j>"] = telescope_actions.move_selection_next,
              ["<c-k>"] = telescope_actions.move_selection_previous,
            }
          }
        },
      }
    end,
  }

  -- LSP and completion
  use "neovim/nvim-lspconfig"
  use "kabouzeid/nvim-lspinstall"
  use "onsails/lspkind-nvim"
  use "L3MON4D3/LuaSnip"

  use { "hrsh7th/nvim-cmp", requires = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
  }}

	use { "folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup {
				use_lsp_diagnostic_signs = true,
			}
		end
	}

  -- File browsing and status
  use "famiu/feline.nvim"
  use { "kyazdani42/nvim-tree.lua",
    config = function()
      require "util".set_global {
        nvim_tree_show_icons = {
          git = 1,
          folders = 1,
          files = 1
        },

        nvim_tree_group_empty = 1,
        nvim_tree_disable_window_picker = 1,

        nvim_tree_icons = {
          git = {
            unstaged = "",
            staged = "",
            unmerged = "",
            renamed = "",
            untracked = "",
            deleted = "",
            ignored = "",
          },
          lsp = {
          },
        },
      }

      -- TODO: Use lua setup when it has feature parity
      local tree = require "nvim-tree.config".nvim_tree_callback
      require "nvim-tree".setup {
        diagnostics = {
					enable = true,
					icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
					},
				},
        update_cwd = true,
        view = {
          mappings = {
            custom_only = false,
            list = {
              { key = "s", cb = tree("vsplit") },
              { key = "i", cb = tree("split") },
            },
          },
        },
      }
    end,
  }

  use "farmergreg/vim-lastplace"

  -- Git integration
  use { "lewis6991/gitsigns.nvim",
    config = function()
      require "gitsigns".setup {
        signcolumn = false,
        keymaps = {},
        current_line_blame_formatter_opts = {
          relative_time = true,
        },
        yadm = {
          enable = true,
        },
      }
    end,
  }

  -- Code formatting
  use "tpope/vim-surround"
  use "tpope/vim-commentary"
  use "FooSoft/vim-argwrap"

  use { "sbdchd/neoformat",
    config = function()
      require "util".set_global {
        neoformat_enabled_go = { "goimports" },
      }
    end,
  }

  use "windwp/nvim-ts-autotag"

  use { "windwp/nvim-autopairs",
    config = function()
      require "nvim-autopairs".setup()
    end,
  }

  -- Language plugins
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use "mattn/vim-goimpl"

end, config = packer_config})
