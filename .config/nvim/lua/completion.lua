local util = require "util"
local lspconfig = require "lspconfig"
local cmp = require "cmp"
local cmp_lsp = require "cmp_nvim_lsp"
local luasnip = require "luasnip"
local lspkind = require "lspkind"
local lspinstall = require "lspinstall"
local mappings = require "mappings"

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

local on_lsp_attach = function()
  mappings.map_lsp_keys()
  util.cmd { [[autocmd CursorHold * silent! lua show_line_diagnostics()]] }
end

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
      vim_item.kind = lspkind.presets.default[vim_item.kind]
        .. " [" .. vim_item.kind .. "]"
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
      select = false,
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

local custom_lsp_settings = {
  lua = {
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
}

local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = cmp_lsp.update_capabilities(capabilities)
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  return {
    capabilities = capabilities,
    on_attach = on_lsp_attach,
  }
end

-- Get automatically installed servers
lspinstall.setup()
local servers = lspinstall.installed_servers()

for _, server in pairs(servers) do
  local config = make_config()

  if custom_lsp_settings[server] ~= nil then
    config.settings = custom_lsp_settings[server]
  end

  lspconfig[server].setup(config)
end
