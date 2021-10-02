local util = require "util"
local nest = require "nest"

local telescope = require "telescope"
local telescope_builtin = require "telescope.builtin"
local telescope_themes = require "telescope.themes"

local find_files_config = telescope_themes.get_dropdown {
  previewer = false,
  layout_config = {
    width = 0.4,
    height = 0.6,
  },
}

local live_grep_config = {
  layout_strategy = "horizontal",
  layout_config = {
    prompt_position = "top",
    width = 0.9,
    height = 0.8,
  },
}

util.set_global { mapleader = "," }

nest.applyKeymaps {
  -- Quickfix window mappings
  { "<c-f>", {
    { "k", [[:copen<CR>]] },
    { "j", [[:cclose<CR>]] },
    { "l", [[:cnext<CR>]] },
    { "h", [[:cprev<CR>]] },
  }},

  -- Location list mappings
  { "<c-d>", {
    { "k", [[:lopen<CR>]] },
    { "j", [[:lclose<CR>]] },
    { "l", [[:lnext<CR>]] },
    { "h", [[:lprev<CR>]] },
  }},

  { "<C-n>", [[:NvimTreeToggle<CR>]] },
  { "<C-p>", function() telescope_builtin.find_files(find_files_config) end },

  { "<leader>", {
    { "q", function() telescope_builtin.live_grep(live_grep_config) end },
    { "ii", function() telescope.extensions.goimpl.goimpl() end },

    { "w", [[:ArgWrap<CR>]] },
    { "f", [[:Neoformat<CR>]] },
  }},

	{ "<space>", {
		{ "w", [[<cmd>TroubleToggle lsp_workspace_diagnostics<cr>]] },
		{ "d", [[<cmd>TroubleToggle lsp_document_diagnostics<cr>]] },
	}},
}
