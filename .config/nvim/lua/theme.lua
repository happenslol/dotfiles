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

  { "LspDiagnosticsDefaultError", _G.colors.red },
  { "LspDiagnosticsDefaultWarning", _G.colors.yellow },

  { "NvimTreeGitDirty", _G.colors.orange },
  { "NvimTreeGitStaged", _G.colors.blue },
  { "NvimTreeGitMerge", _G.colors.red },
  { "NvimTreeGitNew", _G.colors.green },
  { "NvimTreeGitDeleted", _G.colors.red },

  { "LspDiagnosticsSignError", _G.colors.red },
  { "LspDiagnosticsSignWarning", _G.colors.yellow },
  { "LspDiagnosticsSignHint", _G.colors.cyan },
  { "LspDiagnosticsSignInformation", _G.colors.invisibles },

  -- Style floating windows
  { "NormalFloat", nil, _G.colors.selection },
  { "FloatBorder", nil, _G.colors.selection },

  -- Hide "~" on empty lines
  { "EndOfBuffer", _G.colors.bg, _G.colors.bg },

  -- Style status messages
  { "errormsg", _G.colors.red, _G.colors.bg },
}
