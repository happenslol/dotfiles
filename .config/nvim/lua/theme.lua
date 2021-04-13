local cmd, fn = vim.cmd, vim.fn
local g, o, wo, bo = vim.g, vim.o, vim.wo, vim.bo

cmd [[let $NVIM_TUI_ENABLE_TRUE_COLOR = 1]]
cmd [[let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"]]
cmd [[let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"]]
cmd [[let &t_ZH="\e[3m"]]
cmd [[let &t_ZR="\e[23m"]]
o.termguicolors = true

o.background = "dark"
cmd [[set t_Co=256]]

g.material_theme_style = "darker"
g.material_terminal_italics = 1
cmd [[colorscheme material]]

_G.colors = {
  bg = g.material_colorscheme_map.bg.gui,
  fg = g.material_colorscheme_map.fg.gui,
  invisibles = g.material_colorscheme_map.invisibles.gui,
  comments = g.material_colorscheme_map.comments.gui,
  caret = g.material_colorscheme_map.caret.gui,
  selection = g.material_colorscheme_map.selection.gui,
  guides = g.material_colorscheme_map.guides.gui,
  line_numbers = g.material_colorscheme_map.line_numbers.gui,
  line_highlight = g.material_colorscheme_map.line_highlight.gui,
  white = g.material_colorscheme_map.white.gui,
  black = g.material_colorscheme_map.black.gui,
  red = g.material_colorscheme_map.red.gui,
  orange = g.material_colorscheme_map.orange.gui,
  yellow = g.material_colorscheme_map.yellow.gui,
  green = g.material_colorscheme_map.green.gui,
  cyan = g.material_colorscheme_map.cyan.gui,
  blue = g.material_colorscheme_map.blue.gui,
  paleblue = g.material_colorscheme_map.paleblue.gui,
  purple = g.material_colorscheme_map.purple.gui,
  brown = g.material_colorscheme_map.brown.gui,
  pink = g.material_colorscheme_map.pink.gui,
  violet = g.material_colorscheme_map.violet.gui
}

local function hi(symbol, fg, bg, style)
  local values = {}

  if fg then values[#values + 1] = "guifg=" .. fg end
  if bg then values[#values + 1] = "guibg=" .. bg end
  if style then values[#values + 1] = "gui=" .. style end

  local color_str = table.concat(values, " ")
  cmd("autocmd ColorScheme * hi " .. symbol .. " " .. color_str)
end

-- Reverse bracket highlighting
hi("MatchParen", _G.colors.cyan, _G.colors.comments, "bold")

-- Style lsp diagnostics
hi("LspDiagnosticsUnderlineError", nil, nil, "underline")
hi("LspDiagnosticsUnderlineWarning", nil, nil, "underline")
hi("LspDiagnosticsUnderlineInformation", nil, nil, "underline")

fn.sign_define("LspDiagnosticsSignError", { text = "", texthl = "LspDiagnosticsSignError" })
fn.sign_define("LspDiagnosticsSignWarning", { text = "", texthl = "LspDiagnosticsSignWarning" })
fn.sign_define("LspDiagnosticsSignInformation", { text = "", texthl = "LspDiagnosticsSignInformation" })
fn.sign_define("LspDiagnosticsSignHint", { text = "", texthl = "LspDiagnosticsSignHint" })

hi("LspDiagnosticsSignError", _G.colors.red, _G.colors.bg)
hi("LspDiagnosticsSignWarning", _G.colors.orange, _G.colors.bg)
hi("LspDiagnosticsSignInformation", _G.colors.cyan, _G.colors.bg)
hi("LspDiagnosticsSignHint", _G.colors.paleblue, _G.colors.bg)

-- Hide "~" on empty lines
hi("EndOfBuffer", _G.colors.bg, _G.colors.bg)

-- Style gitgutter icons
hi("GitGutterAdd", _G.colors.green, _G.colors.bg)
hi("GitGutterChange", _G.colors.yellow, _G.colors.bg)
hi("GitGutterDelete", _G.colors.red, _G.colors.bg)

-- Style status messages
hi("errormsg", _G.colors.red, _G.colors.bg)

-- Lspsaga popup
local saga_popup_hi = {
  "LspFloatWinBorder",

  "LspSagaCodeActionBorder",
  "LspSagaCodeActionTruncateLine",

  "LspSagaDiagnosticBorder",
  "LspSagaDiagnosticTruncateLine",

  "LspSagaHoverBorder",
  "LspSagaDocTruncateLine",

  "LspSagaRenameBorder",
  "LspSagaSignatureHelpBorder",
  "LspSagaDefPreviewBorder"
}

for _, tag in pairs(saga_popup_hi) do
  hi(tag, _G.colors.invisibles, "NONE")
end
