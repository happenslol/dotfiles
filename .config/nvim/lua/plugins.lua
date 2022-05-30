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
  use { "norcalli/nvim-colorizer.lua",
    config = function()
      require "colorizer".setup()
    end,
  }

	use { "folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup {
				backdrop = 1,
				width = 100,
				height = 1,
			}
		end
	}

  -- Syntax highlighting
  use { "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require "nvim-treesitter.configs".setup {
        ensure_installed = "all",
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

  use "earthly/earthly.vim"

  -- Fuzzy finding
  use { "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-telescope/telescope-fzy-native.nvim",
      "edolphin-ydf/goimpl.nvim",
      "tami5/sqlite.lua",
			"nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      local telescope = require "telescope"
      local telescope_actions = require "telescope.actions"

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

        extensions = {
          ["ui-select"] = {
            layout_strategy = "cursor",
            results_title = false,
            preview_title = false,
            prompt_title = false,
            prompt_prefix = " ",
            previewer = false,
            sorting_strategy = "ascending",
            initial_mode = "normal",
            layout_config = {
              width = 60,
              height = 10,
            },
          }
        }
      }

      telescope.load_extension "fzy_native"
      telescope.load_extension "goimpl"
      telescope.load_extension "ui-select"
    end,
  }

  -- LSP and completion
  use "neovim/nvim-lspconfig"
  use "williamboman/nvim-lsp-installer"
  use "onsails/lspkind-nvim"
	use "jose-elias-alvarez/typescript.nvim"
	use "simrat39/rust-tools.nvim"

  use "L3MON4D3/LuaSnip"

  use { "tamago324/nlsp-settings.nvim",
    config = function()
      require "nlspsettings".setup {
        local_settings_root_markers = { ".git" },
      }
    end,
  }

  use { "rafamadriz/friendly-snippets",
    config = function()
      require "luasnip/loaders/from_vscode".lazy_load()
    end,
  }

  use { "hrsh7th/nvim-cmp", requires = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/vim-vsnip",
  }}

  use { "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        use_diagnostic_signs = true,
      }
    end
  }

  -- File browsing and status
  use "feline-nvim/feline.nvim"
  use { "kyazdani42/nvim-tree.lua",
    config = function()
      local tree = require "nvim-tree.config".nvim_tree_callback
      require "nvim-tree".setup {
				renderer = {
					group_empty = true,
					icons = {
						show = {
							git = true,
							folder = true,
							file = true,
						},
						glyphs = {
							git = {
								unstaged = "",
								staged = "",
								unmerged = "",
								renamed = "",
								untracked = "",
								deleted = "",
								ignored = "",
							},
						},
					},
				},
        diagnostics = {
          enable = true,
          icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
          },
        },
        git = {
          enable = true,
          ignore = false,
          timeout = 500
        },
        update_cwd = true,
        actions = {
          open_file = {
            window_picker = {
              enable = true,
              chars = "1234567890",
            },
          }
        },
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

	use "kevinhwang91/nvim-bqf"
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
  use "FooSoft/vim-argwrap"

  use { "JoosepAlviste/nvim-ts-context-commentstring",
    event = "BufReadPost",
  }

  use { "sbdchd/neoformat",
    config = function()
      require "util".set_global {
        neoformat_enabled_go = { "goimports" },
      }
    end,
  }

  use { "numToStr/Comment.nvim",
    config = function()
      require "Comment".setup()
    end
  }

  use { "windwp/nvim-autopairs",
    config = function()
      require "nvim-autopairs".setup {
        check_ts = true,
      }
    end,
  }

  use { "windwp/nvim-ts-autotag",
    config = function ()
      require "nvim-ts-autotag".setup()
    end
  }

  -- Language plugins
  use "mattn/vim-goimpl"
  use "cappyzawa/starlark.vim"

  -- LaTeX
  use { "lervag/vimtex", ft = "tex" }

end, config = packer_config})
