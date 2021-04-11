local cmd, fn = vim.cmd, vim.fn
local g, o, wo, bo = vim.g, vim.o, vim.wo, vim.bo

local gl = require "galaxyline"
local p_fileinfo = require "galaxyline.provider_fileinfo"
local condition = require "galaxyline.condition"

local mode_alias = function()
  local mode_aliases = {
    ["n"] = "NORMAL",
    ["i"] = "INSERT",
    ["c"] = "COMMAND",
    ["V"] = "VISUAL",
    [""] = "BLOCK",
    ["v"] = "VISUAL",
    ["R"] = "REPLACE",
  }

  return mode_aliases[fn.mode()] or "NORMAL"
end

local mode_color = function()
  local mode_colors = {
    ["n"] = _G.colors.blue,
    ["i"] = _G.colors.green,
    ["c"] = _G.colors.orange,
    ["V"] = _G.colors.magenta,
    [""] = _G.colors.magenta,
    ["v"] = _G.colors.magenta,
    ["R"] = _G.colors.red,
  }

  return mode_colors[fn.mode()] or _G.colors.purple
end

local spacing = function(count)
  return function() return string.rep(" ", count) end
end

local str = function(s)
  return function() return s end
end

local append = function(section, name, value)
  local to_append = { [name] = value }
  section[#section + 1] = to_append
end

-- Show short statusline for plugin windows
gl.short_line_list = { "NvimTree", "packer" }

-- Left

append(gl.section.left, "ViMode", {
  provider = function()
    cmd("hi GalaxyViMode guibg=" .. mode_color())
    return "  " .. mode_alias() .. " "
  end,
  highlight = { _G.colors.bg, _G.colors.bg, "bold" },
  separator = "  ",
  separator_highlight = { _G.colors.guides, _G.colors.guides },
})

append(gl.section.left, "FileIcon", {
  provider = "FileIcon",
  highlight = { p_fileinfo.get_file_icon_color, _G.colors.guides },
})

append(gl.section.left, "FileName", {
  provider = { "FileName", spacing(1) },
  highlight = { _G.colors.fg, _G.colors.guides },
  separator = "  ",
  separator_highlight = { _G.colors.selection, _G.colors.selection },
})

append(gl.section.left, "DiagnosticError", {
  provider = "DiagnosticError",
  icon = " ",
  highlight = { _G.colors.red, _G.colors.selection },
  separator = " ",
  separator_highlight = { _G.colors.selection, _G.colors.selection }
})

append(gl.section.left, "DiagnosticWarn", {
  provider = "DiagnosticWarn",
  icon = " ",
  highlight = { _G.colors.orange, _G.colors.selection },
  separator = " ",
  separator_highlight = { _G.colors.selection, _G.colors.selection }
})

append(gl.section.left, "DiagnosticInfo", {
  provider = "DiagnosticInfo",
  icon = "  ",
  highlight = { _G.colors.cyan, _G.colors.selection },
  separator = " ",
  separator_highlight = { _G.colors.selection, _G.colors.selection }
})

-- Right

append(gl.section.right, "DiffAdd", {
  provider = "DiffAdd",
  condition = condition.check_git_workspace,
  icon = "+",
  highlight = { _G.colors.green, _G.colors.selection },
  separator = " ",
  separator_highlight = { _G.colors.selection, _G.colors.selection },
})

append(gl.section.right, "DiffModified", {
  provider = "DiffModified",
  condition = condition.check_git_workspace,
  icon = "~",
  highlight = { _G.colors.yellow, _G.colors.selection },
  separator = " ",
  separator_highlight = { _G.colors.selection, _G.colors.selection },
})

append(gl.section.right, "DiffRemove", {
  provider = "DiffRemove",
  condition = condition.check_git_workspace,
  icon = "-",
  highlight = { _G.colors.red, _G.colors.selection },
  separator = " ",
  separator_highlight = { _G.colors.selection, _G.colors.selection },
})

append(gl.section.right, "GitBranch", {
  provider = { str(" "), "GitBranch", spacing(3) },
  condition = condition.check_git_workspace,
  highlight = { _G.colors.fg, _G.colors.selection },
  separator = "  ",
  separator_highlight = { _G.colors.selection, _G.colors.selection },
})

append(gl.section.right, "LinePercent", {
  provider = { spacing(2), "LinePercent" },
  highlight = { _G.colors.fg, _G.colors.guides }
})

append(gl.section.right, "LineInfo", {
  provider = function()
    cmd("hi GalaxyLineInfo guibg=" .. mode_color())
    local line = fn.line(".")
    local column = fn.col(".")
    return string.format(" %3d:%2d ", line, column)
  end,
  highlight = { _G.colors.bg, _G.colors.bg, "bold" },
  separator = " ",
  separator_highlight = { _G.colors.guides, _G.colors.guides },
})

gl.load_galaxyline()
