local util = {}

function util.bootstrap_packer()
  local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.cmd("!git clone git@github.com:wbthomason/packer.nvim " .. install_path)
    vim.cmd "packadd packer.nvim"
  end
end

local function assign_map(obj, map)
  for k, v in pairs(map) do obj[k] = v end
end

function util.set_global(map) assign_map(vim.g, map) end
function util.set_opt(map) assign_map(vim.opt, map) end

function util.cmd(cmds)
  for _, c in pairs(cmds) do vim.cmd(c) end
end

function util.extract_colors(material_colorscheme_map)
  local result = {}

  for color, values in pairs(material_colorscheme_map) do
    result[color] = values.gui
  end

  return result
end

function util.hi(symbol, fg, bg, style)
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
    util.hi(arg[1], arg[2], arg[3], arg[4])
  end
end

function util.hi_define(hl, text)
  if type(hl) == "string" then
    vim.fn.sign_define(hl, { text = text, texthl = hl })
    return
  end

  for _, arg in pairs(hl) do
    util.hi_define(arg[1], arg[2])
  end
end

return util
