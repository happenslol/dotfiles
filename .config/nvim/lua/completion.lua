local util = require "util"
local nest = require "nest"
local lspconfig = require "lspconfig"
local cmp = require "cmp"
local luasnip = require "luasnip"
local lspkind = require "lspkind"

_G.default_float_config = {
	border = "rounded",
	max_width = 120,
	focusable = false,
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
	vim.lsp.handlers.hover, _G.default_float_config
)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    update_in_insert = false
  }
)

local on_lsp_attach = function()
	-- Attach signature help
	require "lsp_signature".on_attach {
		bind = true,
		hint_enable = false,
		max_width = 60,
	}

  -- LSP mappings
  nest.applyKeymaps {
    buffer = true,

    { "g", {
      { "d", [[<cmd>lua vim.lsp.buf.definition()<cr>]] },
      { "D", [[<cmd>lua vim.lsp.buf.declaration()<cr>]] },
      { "i", [[<cmd>lua vim.lsp.buf.implementation()<cr>]] },
      { "r", [[<cmd>lua vim.lsp.buf.references()<cr>]] },
    }},

    { "K", [[<cmd>lua vim.lsp.buf.hover({ focusable = false, border = rounded })<cr>]] },

    { "<space>", {
      { "a", [[<cmd>lua vim.lsp.buf.code_action()<cr>]] },
      { "r", [[<cmd>lua vim.lsp.buf.rename()<cr>]] },
			{ "c", [[<cmd>lua vim.lsp.diagnostic.goto_next({ border = rounded })<cr>]] },
			{ "v", [[<cmd>lua vim.lsp.diagnostic.goto_prev({ border = rounded })<cr>]] },
    }},
  }
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local servers = { "gopls", "tsserver", "rust_analyzer" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_lsp_attach,
    capabilities = capabilities,
  }
end

-- Setup lua completion
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

lspconfig.sumneko_lua.setup {
  cmd = {
    "/usr/bin/lua-language-server", "-E",
    "/usr/share/lua-language-server/main.lua"
  },
  on_attach = on_lsp_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path,
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
      },
      diagnostics = { globals = { "vim", "use" }},
      telemetry = { enable = false },
    },
  },
}

-- Avoid showing message extra message when using completion
vim.opt.shortmess:append "c"

util.set_opt {
  completeopt = "menuone,noselect",
  pumheight = 12,
}

-- Configure completion engine
local feed = function(key, mode)
  vim.fn.feedkeys(
    vim.api.nvim_replace_termcodes(key, true, true, true),
    mode
  )
end

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  formatting = {
    format = function(_, vim_item)
      -- Only show items for kind
      vim_item.kind = lspkind.presets.default[vim_item.kind]
      return vim_item
    end,
  },

  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
    ["<Tab>"] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        feed("<C-n>", "n")
      elseif luasnip.expand_or_jumpable() then
        feed("<Plug>luasnip-expand-or-jump", "")
      else fallback() end
    end,
    ["<S-Tab>"] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        feed("<C-p>", "n")
      elseif luasnip.jumpable(-1) then
        feed("<Plug>luasnip-jump-prev", "")
      else fallback() end
    end,
  },

  sources = {
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "buffer" },
    { name = "luasnip" },
  },
}
