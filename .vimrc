call plug#begin('~/.vim/plugged')
" Javascript/ React
Plug 'isRuslan/vim-es6'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'maxmellon/vim-jsx-pretty'

" Ruby
Plug 'tpope/vim-endwise'      " Wisely add 'end' in ruby, endfunction/endif/mor
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'

" Git
Plug 'tpope/vim-fugitive'     " Git wrapper
Plug 'airblade/vim-gitgutter'

" Navigation
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
" Misc
Plug 'rbong/vim-crystalline'
Plug 'tomasiser/vim-code-dark'
Plug 'w0rp/ale'

filetype plugin indent on  " required!
call plug#end()

colorscheme codedark

set nocompatible        " be iMproved
set number              " display line number
set relativenumber      " display relative number
set cursorline          " highlight current line
set wildmenu            " visual autocomplete for command menu
set swapfile
set directory=~/.vim/swap       " Directory to use for the swap file
set splitbelow
set splitright
set clipboard=unnamed   " set the clipboard as shared between mac and vim
set path+=**
set backspace=indent,eol,start   " let backspace key to delete over lines, indent on insert mode
set list listchars=tab:>- " show extra space characters

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*,*/node_modules/**,*.png,*.jpg,*.mmdb,*.dat,*.sql,*/coverage/**,*/build/**,build,build/,build/**

" Searching
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set smartcase
set showmatch
set ignorecase

" encoding is utf 8
set encoding=utf-8
set fileencoding=utf-8

" Formatting, indentation and tabbing
set expandtab           " use spaces instead of tabs
set autoindent          " autoindent based on line above, works most of the time
set smartindent         " smarter indent for C-like languages
set smarttab            " Make <tab> and <backspace> smarter
set shiftwidth=2        " when reading, tabs are 2 spaces
set softtabstop=2       " in insert mode, tabs are 2 spaces
set tabstop=2           " number of visual spaces per TAB
set formatoptions-=t formatoptions+=croql

" Misc
set updatecount=100     " Write swap file to disk every 100 chars
set autoread            " reload files changed outside vim
set scrolloff=3         " keep the cursor visible within 3 lines when scrolling

" MAPPING/KEY BINDINGS
let mapleader=","
" Disabling arrow keys in normal mode
nnoremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Tab Change
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Split Panels Vertical and Horizontal
nnoremap <C-\> <C-w>v
nnoremap <C-_> <C-w>s

" highlight trailing spaces in annoying red
highlight ExtraWhitespace ctermbg=1 guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Rubocop
let g:vimrubocop_config = './plugged/.rubocop.vim'

" Netrw
let g:netrw_liststyle = 3
" let g:netrw_browse_split = 2
" let g:netrw_winsize = 25

""""""""""""""""""" Vim Javascript
let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0
"""""""""""""""""" Vim Javascript End

""""""""""""""""" Ale
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_set_highlights = 0
let g:ale_set_signs = 1
let g:ale_sign_priority = 40
""""""""""""""""" Ale End

""""""""""""""""" GitGutter
set signcolumn=yes
highlight GitGutterAdd    guifg=#009900 guibg=#1A1A1A ctermfg=2 ctermbg=NONE
highlight GitGutterChange guifg=#bbbb00 guibg=#1A1A1A ctermfg=3 ctermbg=NONE
highlight GitGutterDelete guifg=#ff2222 guibg=#1A1A1A ctermfg=1 ctermbg=NONE
""""""""""""""""" GitGutter End

"""""""""""""""" NERDTree
nnoremap <C-g> :NERDTreeToggle<cr>
nnoremap <C-f> :NERDTreeFind<cr>
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$', '\.o$',
                   \ '\.so$', '\.egg$', '^\.git$', '\.cmi', '\.cmo' ]
let NERDTreeShowHidden=1
let NERDTreeShowFiles=1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeDirArrows = 1

"""""""""""""""
"""""""""""""""" FZF
nnoremap <C-p> :Files<Cr>
"""""""""""""""

""""""""""""""" vim-fugitive
map <silent> <Leader>gd :Gdiff<CR>
map <silent> <Leader>gb :Gblame<CR>
map <silent> <Leader>gg :Gbrowse<CR>
"""""""""""""""

""""""""""""""" vim-jsx-retty
let g:vim_jsx_pretty_colorful_config = 1 " default 0
"""""""""""""""

""""""""""""""" vim-crystalline
function! StatusLine(current)
  "return (a:current ? crystalline#mode() . '%#Crystalline#' : '%#CystallineInactive#') . ' %f%h%w%m%r '
  return (a:current ? crystalline#mode() . '%#Crystalline#' : '%#CrystallineInactive#')
        \ . ' %f%h%w%m%r '
        \ . (a:current ? '%#CrystallineFill# %{fugitive#head()} ' : '')
        \ . '%=' . (a:current ? '%#Crystalline# %{&paste?"PASTE ":""}%{&spell?"SPELL ":""}' . crystalline#mode_color() : '')
        \ . ' %{&ft}[%{&enc}][%{&ffs}] %l/%L %c%V %P '
endfunction

let g:crystalline_statusline_fn = 'StatusLine'
let g:crystalline_theme = 'onedark'
set laststatus=2
"""""""""""""""
