local util = require "util"
local cmp = require "cmp"
local cmp_lsp = require "cmp_nvim_lsp"
local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local cmp_compare = require "cmp.config.compare"
local luasnip = require "luasnip"
local lspkind = require "lspkind"
local lspinstaller = require "nvim-lsp-installer"
local mappings = require "mappings"
local lspconfig = require "lspconfig"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, mappings.float_config
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, mappings.float_config
)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    update_in_insert = false,
  }
)

function _G.show_line_diagnostics()
  if util.get_vim_mode() ~= "NORMAL" then return end
  if mappings.get_existing_float() ~= nil then return end
  vim.lsp.diagnostic.show_line_diagnostics(mappings.float_config)
end

local on_lsp_attach = function()
  mappings.map_lsp_keys()
  util.cmd { [[autocmd CursorHold * silent! lua show_line_diagnostics()]] }
end

-- Avoid showing message extra message when using completion
vim.opt.shortmess:append "c"

util.set_opt {
  completeopt = "menu,menuone,noselect",
  pumheight = 12,
}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  formatting = {
    format = lspkind.cmp_format(),
  },

  experimental = {
    ghost_text = true,
    native_menu = false,
  },

  mapping = mappings.cmp_mappings,
  preselect = cmp.PreselectMode.None,

  sorting = {
    priority_weight = 1.0,
    comparators = {
      cmp_compare.locality,
      cmp_compare.recently_used,
      cmp_compare.score,
      cmp_compare.offset,
      cmp_compare.order,
    },
  },

  sources = {
    { name = "nvim_lsp", priority = 4 },
    { name = "nvim_lua", priority = 3 },
    { name = "path", priority = 2 },
    { name = "luasnip", priority = 1 },
    { name = "buffer", priority = 0 },
  },

  window = {
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
  }
}

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { text = "" }}))

local function make_config(extra_options)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = cmp_lsp.update_capabilities(capabilities)
  capabilities.textDocument.completion.completionItem.snippetSupport = true

	local result = {
    capabilities = capabilities,
    on_attach = on_lsp_attach,
  }

	for k, v in pairs(extra_options) do result[k] = v end
  return result
end

lspinstaller.setup {
  ensure_installed = {
    "bashls", "elixirls", "gopls", "html", "jsonls",
    "kotlin_language_server", "rust_analyzer", "sumneko_lua",
    "tsserver",
  },
  automatic_installation = true,
}

lspconfig.bashls.setup(make_config {})
lspconfig.elixirls.setup(make_config {})
lspconfig.gopls.setup(make_config {})
lspconfig.html.setup(make_config {})
lspconfig.jsonls.setup(make_config {})
lspconfig.kotlin_language_server.setup(make_config {})
lspconfig.rust_analyzer.setup(make_config {})

lspconfig.sumneko_lua.setup(make_config {
  on_attach = on_lsp_attach,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				globals = {"vim", "use"},
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
			},
		}
	},
})

require "typescript".setup {
  server = make_config {}
}

require "rust-tools".setup {
	tools = {
		autoSetHints = false,
	},

  server = make_config {
		on_attach = on_lsp_attach,
	}
}
