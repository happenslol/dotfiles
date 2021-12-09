local util = require "util"

util.set_opt {
  termguicolors = true,
  background = "dark",
  fillchars = "eob: "
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
  { "DiagnosticSignError", "" },
  { "DiagnosticSignWarn", "" },
  { "DiagnosticSignInfo", "" },
  { "DiagnosticSignHint", "" },
}

util.hi {
  -- Reverse bracket highlighting
  { "MatchParen", _G.colors.cyan, _G.colors.comments, "bold" },

  -- Style lsp diagnostics
  { "DiagnosticUnderlineError", nil, nil, "underline guisp=" .. _G.colors.red },
  { "DiagnosticUnderlineWarn", nil, nil, "underline guisp=" .. _G.colors.yellow },
  { "DiagnosticUnderlineInfo", nil, nil, "underline guisp=" .. _G.colors.invisibles },

  { "DiagnosticError", _G.colors.red },
  { "DiagnosticWarn", _G.colors.yellow },

  { "NvimTreeGitDirty", _G.colors.orange },
  { "NvimTreeGitStaged", _G.colors.blue },
  { "NvimTreeGitMerge", _G.colors.red },
  { "NvimTreeGitNew", _G.colors.green },
  { "NvimTreeGitDeleted", _G.colors.red },

  { "DiagnosticSignError", _G.colors.red },
  { "DiagnosticSignWarn", _G.colors.yellow },
  { "DiagnosticSignHint", _G.colors.cyan },
  { "DiagnosticSignInfo", _G.colors.invisibles },

  -- Style floating windows
  { "NormalFloat", nil, _G.colors.selection },
  { "FloatBorder", nil, _G.colors.selection },

  -- Hide "~" on empty lines
  { "EndOfBuffer", _G.colors.bg, _G.colors.bg },
  { "NvimTreeEndOfBuffer", _G.colors.bg, _G.colors.bg },

  -- Style status messages
  { "ErrorMsg", _G.colors.red, _G.colors.bg },
  { "Error", _G.colors.red, _G.colors.bg },
  { "NvimInternalError", _G.colors.red, _G.colors.bg },

  -- Style cmp completion
  { "CmpItemAbbrDeprecated", _G.colors.comments, nil, "strikethrough" },
  { "CmpItemAbbr", "#666666", nil },
  { "CmpItemAbbrMatch", _G.colors.fg, nil, "bold" },
  { "CmpItemAbbrMatchFuzzy", _G.colors.invisibles, nil },
  { "CmpItemMenu", _G.colors.invisibles, nil },

  { "CmpItemKindDefault", _G.colors.paleblue, nil },
  { "CmpItemKindText", _G.colors.invisibles, nil },
  { "CmpItemKindFolder", _G.colors.cyan, nil },
}
