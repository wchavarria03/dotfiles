call plug#begin('~/.config/nvim/plugged')

 Plug 'glepnir/lspsaga.nvim'
 Plug 'neovim/nvim-lspconfig'

" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}


" Javascript/ React
" Plug 'sheerun/vim-polyglot'

" Ruby
" Plug 'tpope/vim-endwise'      " Wisely add 'end' in ruby, endfunction/endif/mor
" Plug 'vim-ruby/vim-ruby'
" plug 'ngmy/vim-rubocop'
" Plug 'tpope/vim-rails'

" Git
" Plug 'tpope/vim-fugitive'     " Git wrapper
" Plug 'airblade/vim-gitgutter'

" Navigation
" Plug 'scrooloose/nerdtree'
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
" Plug 'junegunn/fzf.vim'
" Plug 'jremmen/vim-ripgrep'

" Misc
Plug 'tomasiser/vim-code-dark'
" Plug 'w0rp/ale'
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

filetype plugin indent on  " required!
call plug#end()

colorscheme codedark

" LAU --- set number              " display line number
" LAU --- set relativenumber      " display relative number
" LAU --- set cursorline          " highlight current line
" LAU --- set swapfile
" LAU --- set splitbelow
" LAU --- set splitright
" LUA --- set clipboard=unnamed   " set the clipboard as shared between mac and vim
set path+=**

""""""""""""""""" LUA
" lua require('init')

""""""""""""""""" LUA END


" Tab completion
" LAU ---set wildmode=list:longest,list:full
" LAU --- set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*,*/node_modules/**,*.png,*.jpg,*.mmdb,*.dat,*.sql,*/coverage/**,*/build/**,build,build/,build/**

" Searching
" LUA --- set smartcase
" LAU --- set showmatch
" LAU --- set ignorecase

" Formatting, indentation and tabbing
" LUA --- set expandtab           " use spaces instead of tabs
" LUA --- set smartindent         " smarter indent for C-like languages
" LUA --- set shiftwidth=2        " when reading, tabs are 2 spaces
" LAU --- set softtabstop=2       " in insert mode, tabs are 2 spaces
" LUA --- set tabstop=2           " number of visual spaces per TAB
" LAU --- set formatoptions-=t formatoptions+=croql

" folding TODO CHECK IF REQUIRED
" LAU --- set foldmethod=indent   "syntax highlighting items specify folds
" LAU --- set foldcolumn=1        "defines 1 col at window left, to indicate folding
" LAU --- set foldnestmax=10
" LAU --- set nofoldenable
" LAU --- set foldlevel=2

" Misc
" LAU --- set updatecount=100     " Write swap file to disk every 100 chars
" LAU --- set autoread            " reload files changed outside vim
" LAU --- set scrolloff=3         " keep the cursor visible within 3 lines when scrolling

" MAPPING/KEY BINDINGS
" LAU --- let mapleader = " "

" Disabling arrow keys in normal mode
" LAU --- nnoremap <Up> <NOP>
" LAU --- noremap <Down> <NOP>
" LAU --- noremap <Left> <NOP>
" LAU --- noremap <Right> <NOP>

" Tab Change
" LAU --- nnoremap <C-h> <C-w>h
" LAU --- nnoremap <C-j> <C-w>j
" LAU --- nnoremap <C-k> <C-w>k
" LAU --- nnoremap <C-l> <C-w>l

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
let g:vimrubocop_config = './plugged/vim-rubocop/plugin/rubocop.vim'

" Netrw
let g:netrw_liststyle = 3
let g:netrw_browse_split = 2                       " open new files in horiontal way

""""""""""""""""""" vim polyglot
let g:vim_jsx_pretty_colorful_config = 1
"""""""""""""""""" vim polyglot end

""""""""""""""""" Ale
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_set_highlights = 0
let g:ale_set_signs = 1
let g:ale_sign_priority = 40
nmap <silent> <leader><c-k> <plug>(ale_previous_wrap)
nmap <silent> <leader><c-j> <plug>(ale_next_wrap)
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
let g:nerdtreewinpos = "right"
let NERDTreeShowHidden=1
let NERDTreeShowFiles=1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeDirArrows = 1
"""""""""""""""

"""""""""""""""" FZF
let g:fzf_preview_window = 'right:40%'
nnoremap <C-p> :Files<Cr>
" nnoremap <C-p> :Files<Cr>
"""""""""""""""

""""""""""""""" vim-fugitive
map <silent> <Leader>gd :Gdiff<CR>
map <silent> <Leader>gb :Gblame<CR>
map <silent> <Leader>gg :Gbrowse<CR>
"""""""""""""""

""""""""""""""" Markdown Preview
let g:mkdp_auto_close = 1
"""""""""""""""

""""""""""""""" Ack
" nnoremap <Leader>a :Ack! --ignore-dir={coverage,build,dist,node_modules,test,tests}<Space>
" nnoremap <Leader>aa :Ack!<Space>
"""""""""""""""

""""""""""""""" RipGrep

nnoremap <Leader>a :Rg --vimgrep -g '!coverage/**' -g '!tests/**' -g '!*.test.js' -g '!spec/**'
nnoremap <Leader>aa :Rg
"""""""""""""""

"""""""""""""""
" status line custom
"""""""""""""""
let g:currentMode={
    \ 'n'      : 'n ',
    \ 'no'     : 'n·operator pending ',
    \ 'v'      : 'v ',
    \ 'V'      : 'v·line ',
    \ "\<C-v>" : 'v·block ',
    \ 's'      : 'select ',
    \ 'S'      : 's·line ',
    \ '\<c-s>' : 's·block ',
    \ 'i'      : 'i ',
    \ 'R'      : 'r ',
    \ 'Rv'     : 'v·replace ',
    \ 'c'      : 'command ',
    \ 'cv'     : 'vim ex ',
    \ 'ce'     : 'ex ',
    \ 'r'      : 'prompt ',
    \ 'rm'     : 'more ',
    \ 'r?'     : 'confirm ',
    \ '!'      : 'shell ',
    \ 't'      : 'terminal '
    \}

" automatically change the statusline color depending on mode
function! ChangeStatuslineColor(new_mode)
  let l:mode = a:new_mode
  if (l:mode =~# '\v(v|V)' || g:currentMode[l:mode] ==# 'v·block' || get(g:currentMode, l:mode, '') ==# 't') || l:mode ==# "\<C-v>"
    exe 'hi! statusline guifg=black guibg=#5d9ee7 ctermfg=black ctermbg=blue'
    return 'Visual'
  elseif (l:mode ==# 'i')
    exe 'hi! statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=magenta'
    return 'Insert'
  else
    exe 'hi! statusline guifg=black guibg=#cbd09b ctermfg=black ctermbg=lightgreen'
    return 'Normal'
  endif
endfunction

function! SetStatusLineColorVisual()
    set updatetime=0
    call ChangeStatuslineColor('v')
    return ''
endfunction

function! ResetCursorLineNrColor()
    set updatetime=4000
    call ChangeStatuslineColor('n')
    return ''
endfunction

vnoremap <silent> <expr> <SID>SetStatusLineColorVisual SetStatusLineColorVisual()
vnoremap <silent> <expr> <SID>ResetCursorLineNrColor ResetCursorLineNrColor()
nnoremap <silent> <script> v v<SID>SetStatusLineColorVisual<right><left>
nnoremap <silent> <script> V V<SID>SetStatusLineColorVisual<right><left>
nnoremap <silent> <script> <C-v> <C-v><SID>SetStatusLineColorVisual<right><left>

augroup cursorlinenrcolorswap
   autocmd InsertEnter * call ChangeStatuslineColor('i')
   autocmd InsertChange * call ChangeStatuslineColor('i')
   autocmd InsertLeave * call ResetCursorLineNrColor()
   autocmd CursorHold * call ResetCursorLineNrColor()
augroup end

" default with normal color when initial rendering
exe 'hi! statusline guifg=black guibg=#cbd09b ctermfg=black ctermbg=lightgreen'
exe 'hi! statuslineNC guifg=black guibg=#fff ctermfg=black ctermbg=white'

function! MakeStatusLine() abort
  let line = ''
  let line ..= ' %{ChangeStatuslineColor(mode())}     '
  let line ..= '%<'             " truncate point.
  let line ..= '%m'             " modified flag.
  let line ..= '%r'             " readonly flag.
  let line ..= '%f'             " short file name
  let line ..= '%='             " separation point.
  let line ..= ' %3l/'           " current line
  let line ..= '%L'   " total lines
  let line ..= ' %cc'        " column number
  let line ..= ' %3p%%'         " percentage through file in lines.

  return line
endfunction

set laststatus=2 statusline=%!MakeStatusLine()
