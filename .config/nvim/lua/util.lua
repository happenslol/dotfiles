local M = {}

function M.bootstrap_packer()
  local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.cmd("!git clone git@github.com:wbthomason/packer.nvim " .. install_path)
    vim.cmd "packadd packer.nvim"
  end
end

local function assign_map(obj, map)
  for k, v in pairs(map) do obj[k] = v end
end

function M.set_global(map) assign_map(vim.g, map) end
function M.set_opt(map) assign_map(vim.opt, map) end

function M.cmd(cmds)
  for _, c in pairs(cmds) do vim.cmd(c) end
end

function M.extract_colors(material_colorscheme_map)
  local result = {}

  for color, values in pairs(material_colorscheme_map) do
    result[color] = values.gui
  end

  return result
end

function M.hi(symbol, fg, bg, style)
  if type(symbol) == "string" then
    local values = {}

    if fg then values[#values + 1] = "guifg=" .. fg end
    if bg then values[#values + 1] = "guibg=" .. bg end
    if style then values[#values + 1] = "gui=" .. style end

    local color_str = table.concat(values, " ")
    vim.cmd("autocmd ColorScheme * hi " .. symbol .. " " .. color_str)

    return
  end

  for _, arg in pairs(symbol) do
    M.hi(arg[1], arg[2], arg[3], arg[4])
  end
end

function M.hi_define(hl, text)
  if type(hl) == "string" then
    vim.fn.sign_define(hl, { text = text, texthl = hl })
    return
  end

  for _, arg in pairs(hl) do
    M.hi_define(arg[1], arg[2])
  end
end

return M
