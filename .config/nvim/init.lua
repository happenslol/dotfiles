local util = require "util"

util.bootstrap_packer()

require "plugins"
require "theme"
require "mappings"
require "completion"
require "statusline"

vim.cmd [[filetype plugin indent on]]
vim.cmd [[syntax on]]

util.set_opt {
  modeline = true,
  modelines = 5,

  mouse = "a",

  showmode = false,
  laststatus = 2,

  number = true,
  numberwidth = 4,
  signcolumn = "yes",

  clipboard = "unnamed",
  wildmenu = true,
  backspace = "indent,eol,start",
  fileencoding = "utf-8",

  binary = true,
  endofline = false,
  startofline = false,
  winminheight = 0,

  title = true,
  titlestring = "nvim | %{substitute(getcwd(), $HOME, '~', '')}",

  hlsearch = true,
  ignorecase = true,
  smartcase = true,
  incsearch = true,
  inccommand = "nosplit",
  errorbells = false,
  ruler = true,
  shortmess = "atIO",
  showcmd = true,
  scrolloff = 5,

  expandtab = true,
  tabstop = 2,
  shiftwidth = 2,

  undofile = true,
  undodir = vim.fn.stdpath("data") .. "/undo",
  directory = vim.fn.stdpath("data") .. "/swap",
  updatetime = 250,
}
