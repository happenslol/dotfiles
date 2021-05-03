local cmd, fn = vim.cmd, vim.fn
local g, o, wo, bo = vim.g, vim.o, vim.wo, vim.bo
local vimp = require "vimp"

g.mapleader = ","

-- Quickfix window mappings
vimp.nmap({ "silent" }, "<c-f>k", [[:copen<CR>]])
vimp.nmap({ "silent" }, "<c-f>j", [[:cclose<CR>]])
vimp.nmap({ "silent" }, "<c-f>l", [[:cnext<CR>]])
vimp.nmap({ "silent" }, "<c-f>h", [[:cprev<CR>]])

-- Location list mappings
vimp.nmap({ "silent" }, "<c-d>k", [[:lopen<CR>]])
vimp.nmap({ "silent" }, "<c-d>j", [[:lclose<CR>]])
vimp.nmap({ "silent" }, "<c-d>l", [[:lnext<CR>]])
vimp.nmap({ "silent" }, "<c-d>h", [[:lprev<CR>]])

vimp.nnoremap({ "silent" }, "<C-n>", [[:NvimTreeToggle<CR>]])

vimp.nnoremap({ "silent" }, "<C-p>", [[:Telescope find_files<CR>]])
vimp.nnoremap({ "silent" }, "<leader>q", [[:Telescope live_grep<CR>]])
vimp.nnoremap({ "silent" }, "<leader>e", [[:Telescope buffers<CR>]])

vimp.nnoremap({ "silent" }, "<leader>w", [[:ArgWrap<CR>]])
vimp.nnoremap({ "silent" }, "<leader>f", [[:Neoformat<CR>]])

vimp.nnoremap({ "silent" }, "<leader>c", [[:LspTroubleToggle<CR>]])
