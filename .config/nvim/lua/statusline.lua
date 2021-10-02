local vi_mode_colors = {
  NORMAL = _G.colors.blue,
  INSERT = _G.colors.green,
  VISUAL = _G.colors.yellow,
  OP = _G.colors.green,
  BLOCK = _G.colors.blue,
  REPLACE = _G.colors.red,
  ["V-REPLACE"] = _G.colors.red,
  ENTER = _G.colors.cyan,
  MORE = _G.colors.cyan,
  SELECT = _G.colors.orange,
  COMMAND = _G.colors.selection,
  SHELL = _G.colors.green,
  TERM = _G.colors.blue,
  NONE = _G.colors.purple,
}

local lsp = require "feline.providers.lsp"
local vi_mode_utils = require "feline.providers.vi_mode"
local cursor = require "feline.providers.cursor"

local c = {
  vi_mode = {
    provider = function()
      return " " .. vi_mode_utils.get_vim_mode() .. " "
    end,

    hl = function()
      local name = vi_mode_utils.get_mode_highlight_name()
      local fg = _G.colors.selection
      if vi_mode_utils.get_vim_mode() == "COMMAND" then
        fg = _G.colors.fg
      end

      return {
        name = name,
        fg = fg,
        bg = vi_mode_utils.get_mode_color(),
        style = "bold"
      }
    end,

    right_sep = " ",
  },
  file = function (mode)
    local result = {
      provider = {
        name = "file_info",
        opts = {
          type = "unique",
          file_modified_icon = " ",
        },
      },
      hl = { fg = _G.colors.fg, style = nil },

      right_sep = " ",
      left_sep = " ",
    }

    if mode == "active" then
      result.hl.style = "bold"
    end

    return result
  end,
  line_percentage = {
    provider = "line_percentage",
    hl = { style = "bold" },

    left_sep = " ",
    right_sep = " ",
  },
  position = {
    provider = function()
      return " " .. cursor.position() .. " "
    end,

    hl = function()
      return {
        name = vi_mode_utils.get_mode_highlight_name(),
        fg = _G.colors.bg,
        bg = vi_mode_utils.get_mode_color(),
        style = "bold"
      }
    end,

    left_sep = " ",
  },
  diag = {
    err = {
      provider = "diagnostic_errors",
      enabled = function()
        return lsp.diagnostics_exist("Error")
      end,
      hl = { fg = _G.colors.red },
    },
    warn = {
      provider = "diagnostic_warnings",
      enabled = function()
        return lsp.diagnostics_exist("Warning")
      end,
      hl = { fg = _G.colors.yellow }
    },
    hint = {
      provider = "diagnostic_hints",
      enabled = function()
        return lsp.diagnostics_exist("Hint")
      end,
      hl = { fg = _G.colors.cyan }
    },
    info = {
      provider = "diagnostic_info",
      enabled = function()
        return lsp.diagnostics_exist("Information")
      end,
      hl = { fg = _G.colors.blue }
    },
  },
  lsp = {
    provider = "lsp_client_names",
    hl = { fg = _G.colors.yellow },

    right_sep = " ",
    left_sep = " ",
  },
  git = {
    branch = {
      provider = "git_branch",
      icon = " ",
      hl = { fg = _G.colors.fg },
    },
    add = {
      provider = "git_diff_added",
      hl = { fg = _G.colors.green }
    },
    change = {
      provider = "git_diff_changed",
      hl = { fg = _G.colors.orange }
    },
    remove = {
      provider = "git_diff_removed",
      hl = { fg = _G.colors.red },
      right_sep = " ",
    }
  }
}

local properties = {
  force_inactive = {
    filetypes = {
      "NvimTree",
      "packer",
    },
    buftypes = { "terminal" },
    bufnames = {}
  }
}

require "feline".setup {
  colors = {
    bg = colors.selection,
    fg = colors.fg,
  },
  properties = properties,
  vi_mode_colors = vi_mode_colors,
  components = {
    active = {
      -- Left
      {
        c.vi_mode,
        c.file "active",
        c.lsp,
        c.diag.err,
        c.diag.warn,
        c.diag.hint,
        c.diag.info,
      },

      -- Middle
      {},

      -- Right
      {
        c.git.add,
        c.git.change,
        c.git.remove,
        c.line_percentage,
        c.position,
      },
    },
    inactive = {
      { c.file "inactive" },
      {},
      {},
    },
  },
}
