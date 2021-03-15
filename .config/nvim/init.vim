call plug#begin('~/.nvim-plugs')

" Themeing
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'ryanoasis/vim-devicons'

" Fuzzy finding
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

" File browsing and status
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'itchyny/lightline.vim'

" Code formatting
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'Raimondi/delimitMate'
Plug 'FooSoft/vim-argwrap'

" Language plugins
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'uarun/vim-protobuf', { 'for': 'proto' }
Plug 'udalov/kotlin-vim', { 'for': 'kotlin' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'jparise/vim-graphql', { 'for': 'graphql' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'fatih/vim-go', { 'for': 'go' }

Plug 'maxmellon/vim-jsx-pretty', { 'for': 'javascript' }
Plug 'HerringtonDarkholme/yats.vim', { 'for': ['typescript', 'typescriptreact']}

" Prettier for formatting
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'branch': 'release/1.x',
  \ 'for': [
    \ 'javascript',
    \ 'typescript',
    \ 'css',
    \ 'less',
    \ 'scss',
    \ 'json',
    \ 'graphql',
    \ 'markdown',
    \ 'vue',
    \ 'lua',
    \ 'php',
    \ 'python',
    \ 'ruby',
    \ 'html',
    \ 'swift' ] }


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
  set termguicolors
endif

let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
set termguicolors
set background=dark
set t_Co=256
colorscheme material

let g:material_theme_style='darker'
let g:material_terminal_italics=1

set modeline
set modelines=5

set mouse=a

let NERDTreeShowHidden=1
map <C-n> :NERDTreeToggle<CR>

let g:fzf_buffers_jump=1
map <C-i> :Rg<CR>
map <C-p> :Files<CR>
map <C-o> :Buffers<CR>

set noshowmode
set laststatus=2
let g:lightline = {'colorscheme': 'wombat'}

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

let $FZF_DEFAULT_OPTS .= '--color=bg:#212121 --border --layout=reverse'
function! FloatingFZF()
  let width = float2nr(&columns * 0.38)
  let height = float2nr(&lines * 0.25)
  let opts = { 'relative': 'editor',
       \ 'row': (&lines - height) / 2.4,
       \ 'col': (&columns - width) / 2,
       \ 'width': width,
       \ 'height': height,
       \ 'style': 'minimal'
       \}

  let win = nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
  call setwinvar(win, '&winhighlight', 'NormalFloat:TabLine')
endfunction

let g:fzf_preview_window = []
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

let g:vimtex_view_general_viewer = 'evince'

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

nnoremap <silent> <leader>w :ArgWrap<CR>

" Autocompletion pum options
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Close pum on escape
inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" LSP config
lua << EOF

local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  require('completion').on_attach{}
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<C-h>', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '[c', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']c', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<C-j>', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local servers = { "gopls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

EOF
