local util = require "util"
local nest = require "nest"
local lspconfig = require "lspconfig"
local cmp = require "cmp"
local luasnip = require "luasnip"

local on_lsp_attach = function()
  require "lsp_signature".on_attach{
    bind = false,
    hint_enable = false,
    use_lspsaga = true,
  }

  -- LSP mappings
  nest.applyKeymaps {
    buffer = true,

    { "g", {
      { "d", [[:lua vim.lsp.buf.definition()<CR>]] },
      { "D", [[:lua vim.lsp.buf.declaration()<CR>]] },
      { "i", [[:lua vim.lsp.buf.implementation()<CR>]] },
      { "r", [[:lua vim.lsp.buf.references()<CR>]] },
    }},

    { "<C-h>", [[:Lspsaga hover_doc<CR>]] },

    { "<leader>", {
      { "aa", [[:Lspsaga code_action<CR>]] },
      { "ar", [[:Lspsaga rename<CR>]] },
    }},

    { "[c", [[:Lspsaga diagnostic_jump_prev<CR>]] },
    { "]c", [[:Lspsaga diagnostic_jump_next<CR>]] },
  }
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    update_in_insert = false
  }
)

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

-- Lspsaga setup
require "lspsaga".init_lsp_saga {
  use_saga_diagnostic_sign = false,
  dianostic_header_icon = " ",
  code_action_icon = " ",
  code_action_prompt = {
    enable = true,
    sign = false,
    virtual_text = false,
  },
  code_action_keys = {
    quit = { "q", "<Esc>" },
    exec = "<CR>"
  },
  rename_action_keys = {
    quit = { "<C-c>", "<Esc>" },
    exec = "<CR>"
  },
  border_style = "round",
  rename_prompt_prefix = " "
}

-- Configure completion engine
local feed = function(key)
  vim.fn.feedkeys(
    vim.api.nvim_replace_termcodes(key, true, true, true),
    "n"
  )
end

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<Tab>"] = function(fallback)
      if vim.fn.pumvisible() == 1 then feed "<C-n>"
      else fallback() end
    end,
    ["<S-Tab>"] = function(fallback)
      if vim.fn.pumvisible() == 1 then feed "<C-p>"
      elseif luasnip.jumpable(-1) then feed "<Plug>luasnip-jump-prev"
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
