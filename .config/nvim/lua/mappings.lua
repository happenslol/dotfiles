local util = require "util"
local nest = require "nest"
local cmp = require "cmp"
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
	sorting_strategy = "ascending",
	layout_config = {
		prompt_position = "top",
		width = 0.9,
		height = 0.8,
	},
}

local code_actions_config = {
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

local lsp_goto_config = {
	layout_strategy = "horizontal",
	sorting_strategy = "ascending",
	layout_config = {
		prompt_position = "top",
		width = 0.7,
		height = 0.6,
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

		{ "w", [[:ArgWrap<CR>]] },
		{ "f", [[:Neoformat<CR>]] },
	}},

	{ "<space>", {
		{ "w", [[<cmd>TroubleToggle<cr>]] },
	}}
}

local M = {}

M.float_config = {
	border = "rounded",
	max_width = 120,
	focusable = false,
	close_events = {
		"CursorMoved",
		"CursorMovedI",
		"BufHidden",
		"InsertCharPre",
		"BufLeave"
	}
}

function M.get_existing_float()
	local bufnr = vim.api.nvim_get_current_buf()
	local existing_float = vim.F.npcall(vim.api.nvim_buf_get_var, bufnr, "lsp_floating_preview")
	if existing_float and vim.api.nvim_win_is_valid(existing_float) then
		return existing_float
	end
end

local function close_previous_float()
	local existing_float = M.get_existing_float()
	if existing_float == nil then return end

	vim.api.nvim_win_close(existing_float, true)
end

local function goto_next_diagnostic()
	close_previous_float()
	vim.diagnostic.goto_next(M.float_config)
end

local function goto_prev_diagnostic()
	close_previous_float()
	vim.diagnostic.goto_prev(M.float_config)
end

function M.map_lsp_keys()
	nest.applyKeymaps {
		buffer = true,

		{ "K", function() vim.lsp.buf.hover(M.float_config) end },
		{ mode = "i", { "<C-k>", function() vim.lsp.buf.signature_help(M.float_config) end }},

		{ "g", {
			{ "d", [[<cmd>lua vim.lsp.buf.definition()<cr>]] },
			{ "D", [[<cmd>lua vim.lsp.buf.declaration()<cr>]] },
			{ "i", [[<cmd>lua vim.lsp.buf.implementation()<cr>]] },
			{ "r", [[<cmd>lua vim.lsp.buf.references()<cr>]] },
		}},

		{ "<space>", {
			{ "a", function() telescope_builtin.lsp_code_actions(code_actions_config) end },
			{ "r", vim.lsp.buf.rename },
			{ "c", goto_next_diagnostic },
			{ "v", goto_prev_diagnostic },
			{ "ig", telescope.extensions.goimpl.goimpl },

			{ "s", {
				{ "d", function() telescope_builtin.lsp_definitions(lsp_goto_config) end },
				{ "i", function() telescope_builtin.lsp_implementations(lsp_goto_config) end },
				{ "r", function() telescope_builtin.lsp_references(lsp_goto_config) end },

				{ "s", function() telescope_builtin.lsp_document_symbols(lsp_goto_config) end },
				{ "e", function() telescope_builtin.diagnostics(lsp_goto_config) end },
				{ "t", function() telescope_builtin.lsp_type_definitions(lsp_goto_config) end },
			}},
		}},
	}
end

M.cmp_mappings = {
  ["<Tab>"] = function(fallback)
    if cmp.visible() then cmp.select_next_item()
    else fallback() end
  end,

  ["<S-Tab>"] = function(fallback)
    if cmp.visible() then cmp.select_prev_item()
    else fallback() end
  end,

  ["<C-p>"] = cmp.mapping.select_prev_item(),
  ["<C-n>"] = cmp.mapping.select_next_item(),
  ["<C-Space>"] = cmp.mapping.complete(),
  ["<C-e>"] = cmp.mapping.close(),
  ["<CR>"] = cmp.mapping.confirm {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
}

return M
