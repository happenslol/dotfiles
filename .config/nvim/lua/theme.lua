local util = require "util"

util.set_opt {
  termguicolors = true,
  background = "dark",
}

util.set_global {
  material_theme_style = "darker",
  material_terminal_italics = 1,
}

util.cmd {
  [[let $NVIM_TUI_ENABLE_TRUE_COLOR = 1]],
  [[let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"]],
  [[let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"]],
  [[let &t_ZH="\e[3m"]],
  [[let &t_ZR="\e[23m"]],
  [[set t_Co=256]],

  [[colorscheme material]],
}

_G.colors = util.extract_colors(vim.g.material_colorscheme_map)

util.hi {
  -- Reverse bracket highlighting
  { "MatchParen", _G.colors.cyan, _G.colors.comments, "bold" },

  -- Style lsp diagnostics
  { "LspDiagnosticsUnderlineError", nil, nil, "underline" },
  { "LspDiagnosticsUnderlineWarning", nil, nil, "underline" },
  { "LspDiagnosticsUnderlineInformation", nil, nil, "underline" },
}

util.hi_define {
  { "LspDiagnosticsSignError", "x" },
  { "LspDiagnosticsSignWarning", "!" },
  { "LspDiagnosticsSignInformation", "i" },
  { "LspDiagnosticsSignHint", "?" },
}

util.hi {
  { "LspDiagnosticsSignError", _G.colors.red, _G.colors.bg },
  { "LspDiagnosticsSignWarning", _G.colors.orange, _G.colors.bg },
  { "LspDiagnosticsSignInformation", _G.colors.cyan, _G.colors.bg },
  { "LspDiagnosticsSignHint", _G.colors.paleblue, _G.colors.bg },

  -- Hide "~" on empty lines
  { "EndOfBuffer", _G.colors.bg, _G.colors.bg },

  -- Style gitgutter icons
  { "GitGutterAdd", _G.colors.green, _G.colors.bg },
  { "GitGutterChange", _G.colors.yellow, _G.colors.bg },
  { "GitGutterDelete", _G.colors.red, _G.colors.bg },

  -- Style status messages
  { "errormsg", _G.colors.red, _G.colors.bg },

  -- Lspsaga popup
  { "LspFloatWinBorder", _G.colors.red, _G.colors.bg },

  { "LspSagaCodeActionBorder", _G.colors.invisibles, "NONE" },
  { "LspSagaCodeActionTruncateLine", _G.colors.invisibles, "NONE" },

  { "LspSagaDiagnosticBorder", _G.colors.invisibles, "NONE" },
  { "LspSagaDiagnosticTruncateLine", _G.colors.invisibles, "NONE" },

  { "LspSagaHoverBorder", _G.colors.invisibles, "NONE" },
  { "LspSagaDocTruncateLine", _G.colors.invisibles, "NONE" },

  { "LspSagaRenameBorder", _G.colors.invisibles, "NONE" },
  { "LspSagaSignatureHelpBorder", _G.colors.invisibles, "NONE" },
  { "LspSagaDefPreviewBorder", _G.colors.invisibles, "NONE" }
}
