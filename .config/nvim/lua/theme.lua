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

util.hi_define {
  { "LspDiagnosticsSignError", "" },
  { "LspDiagnosticsSignWarning", "" },
  { "LspDiagnosticsSignInformation", "" },
  { "LspDiagnosticsSignHint", "" },
}

util.hi {
  -- Reverse bracket highlighting
  { "MatchParen", _G.colors.cyan, _G.colors.comments, "bold" },

  -- Style lsp diagnostics
  { "LspDiagnosticsUnderlineError", nil, nil, "underline" },
  { "LspDiagnosticsUnderlineWarning", nil, nil, "underline" },
  { "LspDiagnosticsUnderlineInformation", nil, nil, "underline" },

  { "LspDiagnosticsError", _G.colors.red, _G.colors.bg },
  { "LspDiagnosticsWarning", _G.colors.orange, _G.colors.bg },

  { "NvimTreeGitDirty", _G.colors.orange, _G.colors.bg },
  { "NvimTreeGitStaged", _G.colors.blue, _G.colors.bg },
  { "NvimTreeGitMerge", _G.colors.red, _G.colors.bg },
  { "NvimTreeGitNew", _G.colors.green, _G.colors.bg },
  { "NvimTreeGitDeleted", _G.colors.red, _G.colors.bg },

  { "LspDiagnosticsSignError", _G.colors.red, _G.colors.bg },
  { "LspDiagnosticsSignWarning", _G.colors.orange, _G.colors.bg },
  { "LspDiagnosticsSignHint", _G.colors.cyan, _G.colors.bg },
  { "LspDiagnosticsSignInformation", _G.colors.blue, _G.colors.bg },

  -- Style floating windows
  { "NormalFloat", nil, _G.colors.selection, nil },
  { "FloatBorder", nil, _G.colors.selection, nil },

  -- Hide "~" on empty lines
  { "EndOfBuffer", _G.colors.bg, _G.colors.bg },

  -- Style status messages
  { "errormsg", _G.colors.red, _G.colors.bg },
}
