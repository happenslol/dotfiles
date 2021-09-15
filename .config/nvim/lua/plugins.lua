require "packer".startup({function()
  use "wbthomason/packer.nvim"

  -- Util and libraries
  use { "LionC/nest.nvim", branch = "release-v1.1" }
  use "nvim-lua/plenary.nvim"
  use "nvim-lua/popup.nvim"

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
        highlight = { enable = true },
      }

      require "util".set_opt {
        foldmethod = "expr",
        foldexpr = "nvim_treesitter#foldexpr()",
        foldlevelstart = 99,
      }
    end,
  }

  -- Fuzzy finding
  use { "nvim-telescope/telescope.nvim",
    requires = { "nvim-telescope/telescope-fzy-native.nvim" },
    config = function()
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
              ["<c-j>"] = telescope_actions.move_selection_next,
              ["<c-k>"] = telescope_actions.move_selection_previous,
            }
          }
        }
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

	use "ray-x/lsp_signature.nvim"

  use { "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require "trouble".setup {
				mode = "lsp_workspace_diagnostics",
				auto_close = true,
			}
    end,
  }

  -- File browsing and status
  use { "kyazdani42/nvim-tree.lua",
    config = function()
      local tree_cb = require "nvim-tree.config".nvim_tree_callback

      require "util".set_global {
        nvim_tree_show_icons = {
          ["git"] = 0,
          ["folders"] = 1,
          ["files"] = 1
        },

        nvim_tree_bindings = {
          { key = "s", cb = tree_cb("vsplit") },
          { key = "i", cb = tree_cb("split") },
        },

        nvim_tree_group_empty = 1,
        nvim_tree_lsp_diagnostics = 0,
        nvim_tree_disable_window_picker = 1,
      }
    end,
  }

  use "glepnir/galaxyline.nvim"
  use "farmergreg/vim-lastplace"
  use { "airblade/vim-gitgutter",
		config = function()
			require "util".set_global {
				gitgutter_signs = 0,
			}
		end,
	}

	-- Git integration
	use { "lewis6991/gitsigns.nvim",
		config = function()
			require "gitsigns".setup {
				signcolumn = true,
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
  use "b3nj5m1n/kommentary"
  use "FooSoft/vim-argwrap"

  use { "sbdchd/neoformat",
		config = function()
			require "util".set_global {
				neoformat_enabled_go = { "goimports" },
			}
		end,
	}

  use { "windwp/nvim-ts-autotag",
    config = function()
      require "nvim-ts-autotag".setup()
    end,
  }

  use { "windwp/nvim-autopairs",
    config = function()
      require "nvim-autopairs".setup()
    end,
  }

  -- Language plugins
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use "mattn/vim-goimpl"

end,
config = {
  display = {
    open_fn = function()
      return require "packer.util".float({ border = "rounded" })
    end,
  },
}})
