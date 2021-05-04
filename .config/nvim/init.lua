local cmd, fn = vim.cmd, vim.fn
local g, o, wo, bo = vim.g, vim.o, vim.wo, vim.bo

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  cmd("!git clone git@github.com:wbthomason/packer.nvim " .. install_path)
  cmd "packadd packer.nvim"
end

require "plugins"
require "theme"
require "mappings"
require "completion"
require "statusline"

bo.modeline = true
o.modeline = true
o.modelines = 5

o.mouse = "a"

o.showmode = false
o.laststatus = 2

cmd [[filetype plugin indent on]]
cmd [[syntax on]]

wo.number = true
wo.numberwidth = 4
wo.signcolumn = "yes"

o.clipboard = "unnamed"
o.wildmenu = true
o.backspace = "indent,eol,start"
o.fileencoding = "utf-8"

bo.binary = true
bo.endofline = false
o.startofline = false
o.winminheight = 0

o.hlsearch = true
o.ignorecase = true
o.smartcase = true
o.incsearch = true
o.errorbells = false
o.ruler = true
o.shortmess = "atI"
o.showcmd = true
o.scrolloff = 5

o.expandtab = true
o.tabstop = 2
o.shiftwidth = 2

bo.expandtab = true
bo.tabstop = 2
bo.shiftwidth = 2

o.undofile = true
bo.undofile = true

o.updatetime = 500
