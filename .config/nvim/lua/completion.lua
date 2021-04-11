local cmd, fn = vim.cmd, vim.fn
local g, o, wo, bo = vim.g, vim.o, vim.wo, vim.bo
local vimp = require "vimp"

local nvim_lsp = require('lspconfig')

require "compe".setup {
  enabled = true,
  source = {
    path = true,
    buffer = true,
    nvim_lsp = true,
    nvim_lua = true
  }
}

local on_lsp_attach = function(client, bufnr)
  require "lsp_signature".on_attach()

  local function buf_set_keymap(key, command)
    vim.api.nvim_buf_set_keymap(bufnr, "n", key, command, { silent = true, noremap = true })
  end

  -- LSP mappings
  local opts = { noremap=true, silent=true }
  buf_set_keymap("gD", [[:lua vim.lsp.buf.declaration()<CR>]])
  buf_set_keymap("gd", [[:lua vim.lsp.buf.definition()<CR>]])
  buf_set_keymap("gi", [[:lua vim.lsp.buf.implementation()<CR>]])
  buf_set_keymap("gr", [[:lua vim.lsp.buf.references()<CR>]])

  buf_set_keymap("<C-h>", [[:lua vim.lsp.buf.hover()<CR>]])
  buf_set_keymap("<C-j>", [[:lua vim.lsp.diagnostic.set_loclist()<CR>]])

  buf_set_keymap("<leader>a", [[:lua vim.lsp.buf.code_action()<CR>]])

  buf_set_keymap("[c", [[:lua vim.lsp.diagnostic.goto_prev()<CR>]])
  buf_set_keymap("]c", [[:lua vim.lsp.diagnostic.goto_next()<CR>]])

  vim.api.nvim_exec([[autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()]], false)
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    update_in_insert = false
  }
)

-- TODO
-- custom code action selection
--[[ local function custom_codeAction_callback(_, _, action)
  print(vim.inspect(action))
end ]]

-- vim.lsp.handlers["textDocument/codeAction"] = custom_codeAction_callback

local servers = { "gopls", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_lsp_attach }
end

require "lspkind".init()

-- Set completeopt to have a better completion experience
o.completeopt = "menuone,noselect"

-- Avoid showing message extra message when using completion
o.shortmess = o.shortmess .. "c"

-- Configure pum
o.pumheight = 12

-- Use <Tab> and <S-Tab> to navigate through popup menu
vimp.inoremap({ "expr" }, "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
vimp.inoremap({ "expr" }, "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])

-- Trigger completion with C-space
vimp.inoremap({ "expr", "silent" }, "<C-Space>", [[compe#complete()]])

-- Close pum on escape
vimp.inoremap({ "expr", "silent" }, "<C-e>", [[compe#close('<C-e>')]])
vimp.inoremap({ "expr" }, "<Esc>", [[pumvisible() ? "\<C-e><Esc>" : "\<Esc>"]])

-- Make confirmation work with autopairs
local npairs = require "nvim-autopairs"
_G.confirm_completion = function()
  if fn.pumvisible() == 0 then
    return npairs.check_break_line_char()
  end

  if fn.complete_info()["selected"] ~= -1 then
    fn["compe#confirm"]()
    return npairs.esc("")
  end

  vim.api.nvim_select_popupmenu_item(0, false, false, {})
  fn["compe#confirm"]()
  return npairs.esc("<c-n>")
end

vimp.inoremap({ "expr" }, "<CR>", [[v:lua.confirm_completion()]])
