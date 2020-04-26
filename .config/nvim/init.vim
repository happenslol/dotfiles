call plug#begin('~/.nvim-plugs')

Plug 'kaicataldo/material.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'Raimondi/delimitMate'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fatih/vim-go'
Plug 'rust-lang/rust.vim'
Plug 'uarun/vim-protobuf'
Plug 'udalov/kotlin-vim'
Plug 'cespare/vim-toml'
Plug 'jparise/vim-graphql'
Plug 'lervag/vimtex'
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
Plug 'elzr/vim-json'
Plug 'FooSoft/vim-argwrap'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'HerringtonDarkholme/yats.vim'

call plug#end()

" coc config
autocmd FileType json syntax match Comment +\/\/.\+$+

" use better prettier parser
let g:prettier#config#parser = 'babylon'

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" use <c-space>for trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

nmap <silent> <c-h> :call CocAction('doHover')<CR>

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <silent> <c-f>k :copen<CR>
nmap <silent> <c-f>j :cclose<CR>
nmap <silent> <c-f>l :cnext<CR>
nmap <silent> <c-f>h :cprev<CR>

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

let g:material_theme_style='dark'
let g:material_terminal_italics=1

set t_Co=256
set termguicolors
set background=dark
colorscheme material

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
  let width = float2nr(&columns * 0.6)
  let height = float2nr(&lines * 0.6)
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
