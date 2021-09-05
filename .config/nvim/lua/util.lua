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

return util
