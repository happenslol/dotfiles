call plug#begin('~/.nvim-plugs')

" Themeing
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'kyazdani42/nvim-web-devicons'

" Syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

" Fuzzy finding
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'onsails/lspkind-nvim'
Plug 'ray-x/lsp_signature.nvim'

" File browsing and status
Plug 'kyazdani42/nvim-tree.lua'
" Plug 'glepnir/galaxyline.nvim', { 'branch': 'main' }
Plug 'itchyny/lightline.vim'
Plug 'farmergreg/vim-lastplace'

" Code formatting
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'Raimondi/delimitMate'
Plug 'FooSoft/vim-argwrap'
Plug 'sbdchd/neoformat'
Plug 'windwp/nvim-ts-autotag', { 'branch': 'main' }

" Language plugins
Plug 'JoosepAlviste/nvim-ts-context-commentstring', { 'branch': 'main' }
Plug 'HerringtonDarkholme/yats.vim', { 'for': ['typescript', 'typescriptreact']}
Plug 'sheerun/vim-polyglot'

Plug 'mattn/vim-goimpl'

" Plug 'elzr/vim-json', { 'for': 'json' }
" Plug 'uarun/vim-protobuf', { 'for': 'proto' }
" Plug 'udalov/kotlin-vim', { 'for': 'kotlin' }
" Plug 'cespare/vim-toml', { 'for': 'toml' }
" Plug 'jparise/vim-graphql', { 'for': 'graphql' }
" Plug 'rust-lang/rust.vim', { 'for': 'rust' }
" Plug 'fatih/vim-go', { 'for': 'go' }
" Plug 'maxmellon/vim-jsx-pretty', { 'for': 'javascript' }

call plug#end()

" use better prettier parser
let g:prettier#config#parser = 'babylon'

" Quickfix window mappings
nmap <silent> <c-f>k :copen<CR>
nmap <silent> <c-f>j :cclose<CR>
nmap <silent> <c-f>l :cnext<CR>
nmap <silent> <c-f>h :cprev<CR>

" Quickfix window mappings
nmap <silent> <c-d>k :lopen<CR>
nmap <silent> <c-d>j :lclose<CR>
nmap <silent> <c-d>l :lnext<CR>
nmap <silent> <c-d>h :lprev<CR>

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  let &t_ZH="\e[3m"
  let &t_ZR="\e[23m"
  set termguicolors
endif

let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
set background=dark
set t_Co=256
colorscheme material

let g:material_theme_style='darker'
let g:material_terminal_italics=1

" reverse bracket highlighting
autocmd ColorScheme * hi MatchParen gui=bold guifg=#89ddff guibg=#545454 cterm=bold ctermbg=117 ctermfg=59

set modeline
set modelines=5

set mouse=a

nnoremap <C-n> :NvimTreeToggle<CR>

set noshowmode
set laststatus=2
let g:lightline = {'colorscheme': 'material_vim'}

let g:go_gopls_enabled=0
let g:go_code_completion_enabled=0
let g:go_fmt_autosave=0
let g:go_echo_go_info=0

filetype plugin indent on

set number
set relativenumber
set numberwidth=4
set signcolumn=yes
hi LineNr guibg=black ctermfg=black ctermbg=black

set clipboard=unnamed
set wildmenu
set backspace=indent,eol,start
set encoding=utf-8 nobomb

let mapleader=','

set binary
set noeol
set wmh=0

syntax on
set hlsearch
set ignorecase
set smartcase
set incsearch
set noerrorbells
set nostartofline
set ruler
set shortmess=atI
set showcmd
set scrolloff=5

set expandtab
set tabstop=2
set shiftwidth=2

set completeopt-=preview
set undofile
set undodir=~/.nvim-undo/

let g:go_highlight_structs = 1 
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_diagnostic_errors = 0
let g:go_highlight_variable_declarations = 1
let g:go_highlight_trailing_whitespace_error=0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_chan_whitespace_error = 0
let g:go_highlight_space_tab_error = 0

nnoremap <silent> <leader>w :ArgWrap<CR>
nnoremap <silent> <leader>f :Neoformat<CR>

let g:neoformat_enabled_go = ['goimports']

" Autocompletion pum options
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

set pumheight=12

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR> compe#confirm({ 'keys': "\<Plug>delimitMateCR", 'mode': '' })
inoremap <silent><expr> <C-e> compe#close('<C-e>')

" Close pum on escape
inoremap <expr> <Esc> pumvisible() ? "\<C-e><Esc>" : "\<Esc>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" Telescope config
nnoremap <C-p> <cmd>Telescope find_files theme=get_dropdown<CR>
nnoremap <C-m> <cmd>Telescope live_grep theme=get_dropdown<CR>

" Folding with treesitter
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=99

set updatetime=500

" Lua config
let g:vimsyn_embed = 'l'
lua << EOF

local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  require('compe').setup{
    enabled = true,
    source = {
      path = true,
      buffer = true,
      nvim_lsp = true,
      nvim_lua = true
    }
  }

  -- require('completion').on_attach(client)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<C-h>', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<C-j>', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  buf_set_keymap('n', '[c', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']c', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

  vim.api.nvim_exec([[autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()]], false)

  require'lsp_signature'.on_attach()
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    update_in_insert = false
  }
)

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local servers = { "gopls", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

-- Telescope config
local telescope = require('telescope')
telescope.load_extension('fzy_native')
telescope.setup{
  defaults = {
    prompt_position = 'top',
    sorting_strategy = 'ascending'
  }
}

local tree_cb = require('nvim-tree.config').nvim_tree_callback

vim.g.nvim_tree_show_icons = {
  ["git"] = 0,
  ["folders"] = 1,
  ["files"] = 1
}

vim.g.nvim_tree_bindings = {
  ["s"] = tree_cb("vsplit"),
  ["i"] = tree_cb("split")
}

vim.g.nvim_tree_group_empty = 1

require('lspkind').init()

require('nvim-treesitter.configs').setup {
  ensure_installed = 'maintained',
  indent = {
    enable = true
  },
  highlight = {
    enable = true
  },
}

require'nvim-ts-autotag'.setup()

EOF