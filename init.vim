call plug#begin('~/.vim/plugged')
" javascript/ react
plug 'sheerun/vim-polyglot'

" ruby
plug 'tpope/vim-endwise'      " wisely add 'end' in ruby, endfunction/endif/mor
plug 'vim-ruby/vim-ruby'
plug 'ngmy/vim-rubocop'
" plug 'tpope/vim-rails'

" git
plug 'tpope/vim-fugitive'     " git wrapper
plug 'airblade/vim-gitgutter'

" navigation
plug 'scrooloose/nerdtree'
plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
plug 'junegunn/fzf.vim'
plug 'mileszs/ack.vim'

" misc
" plug 'rbong/vim-crystalline'
plug 'tomasiser/vim-code-dark'
" plug 'joshdick/onedark.vim'

plug 'w0rp/ale'

call plug#end()

" colorscheme smyck

set t_co=256
set t_ut=
let g:codedark_term256=1
colorscheme codedark
let g:airline_theme = 'codedark'

" colorscheme darkplus
" colorscheme lucario
" colorscheme onedark

" set runtimepath^=~/.vim/bundle/smyck-color-scheme/smyck.vim

set number              " display line number
set relativenumber      " display relative number
set cursorline          " highlight current line
set swapfile
set splitbelow
set splitright
set clipboard=unnamed   " set the clipboard as shared between mac and vim
set path+=**

" tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*,*/node_modules/**,*.png,*.jpg,*.mmdb,*.dat,*.sql,*/coverage/**,*/build/**,build,build/,build/**

" searching
set smartcase
set showmatch
set ignorecase

" formatting, indentation and tabbing
set expandtab           " use spaces instead of tabs
set smartindent         " smarter indent for c-like languages
set shiftwidth=2        " when reading, tabs are 2 spaces
set softtabstop=2       " in insert mode, tabs are 2 spaces
set tabstop=2           " number of visual spaces per tab
set formatoptions-=t formatoptions+=croql

" folding
set foldmethod=indent   "syntax highlighting items specify folds
set foldcolumn=1        "defines 1 col at window left, to indicate folding
set foldlevelstart=99   "start file with all folds opened

" misc
set updatecount=100     " write swap file to disk every 100 chars
set autoread            " reload files changed outside vim
set scrolloff=3         " keep the cursor visible within 3 lines when scrolling

" mapping/key bindings
let mapleader = " "

" disabling arrow keys in normal mode
nnoremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

" tab change
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" split panels vertical and horizontal
nnoremap <c-\> <c-w>v
nnoremap <c-_> <c-w>s

" highlight trailing spaces in annoying red
highlight extrawhitespace ctermbg=1 guibg=red
match extrawhitespace /\s\+$/
autocmd bufwinenter * match extrawhitespace /\s\+$/
autocmd insertenter * match extrawhitespace /\s\+\%#\@<!$/
autocmd insertleave * match extrawhitespace /\s\+$/
autocmd bufwinleave * call clearmatches()

" rubocop
let g:vimrubocop_config = './plugged/vim-rubocop/plugin/rubocop.vim'

" netrw
let g:netrw_liststyle = 3
let g:netrw_browse_split = 2                                   " open new files in horiontal way

""""""""""""""""""" vim polyglot
let g:vim_jsx_pretty_colorful_config = 1
"""""""""""""""""" vim javascript end

""""""""""""""""" ale
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_set_highlights = 0
let g:ale_set_signs = 1
let g:ale_sign_priority = 40
nmap <silent> <leader><c-k> <plug>(ale_previous_wrap)
nmap <silent> <leader><c-j> <plug>(ale_next_wrap)

""""""""""""""""" ale end

""""""""""""""""" gitgutter
set signcolumn=yes
highlight gitgutteradd    guifg=#009900 guibg=#1a1a1a ctermfg=2 ctermbg=none
highlight gitgutterchange guifg=#bbbb00 guibg=#1a1a1a ctermfg=3 ctermbg=none
highlight gitgutterdelete guifg=#ff2222 guibg=#1a1a1a ctermfg=1 ctermbg=none
""""""""""""""""" gitgutter end

"""""""""""""""" nerdtree
nnoremap <c-g> :nerdtreetoggle<cr>
nnoremap <c-f> :nerdtreefind<cr>
let nerdtreeignore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$', '\.o$',
                   \ '\.so$', '\.egg$', '^\.git$', '\.cmi', '\.cmo' ]
let g:nerdtreewinpos = "right"
let nerdtreeshowhidden=1
let nerdtreeshowfiles=1
let nerdtreeautodeletebuffer = 1
let nerdtreedirarrows = 1
"""""""""""""""

"""""""""""""""" fzf
nnoremap <c-p> :files<cr>
"""""""""""""""

""""""""""""""" vim-fugitive
map <silent> <leader>gd :gdiff<cr>
map <silent> <leader>gb :gblame<cr>
map <silent> <leader>gg :gbrowse<cr>
"""""""""""""""

""""""""""""""" ack
nnoremap <leader>a :ack!<space> --ignore-dir={coverage,build,dist,node_modules,test,tests,spec,mysql}
nnoremap <leader>aa :ack!<space>
"""""""""""""""

"""""""""""""""
" status line custom
"""""""""""""""
let g:currentmode={
    \ 'n'      : 'n ',
    \ 'no'     : 'n·operator pending ',
    \ 'v'      : 'v ',
    \ 'v'      : 'v·line ',
    \ "\<c-v>" : 'v·block ',
    \'s'      : 'select ',
    \ 's'      : 's·line ',
    \ '\<c-s>' : 's·block ',
    \ 'i'      : 'i ',
    \ 'r'      : 'r ',
    \ 'rv'     : 'v·replace ',
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
function! changestatuslinecolor(new_mode)
  let l:mode = a:new_mode
  if (l:mode =~# '\v(v|v)' || g:currentmode[l:mode] ==# 'v·block' || get(g:currentmode, l:mode, '') ==# 't') || l:mode ==# "\<c-v>"
    exe 'hi! statusline guifg=black guibg=#5d9ee7 ctermfg=black ctermbg=blue'
    return 'visual'
  elseif (l:mode ==# 'i')
    exe 'hi! statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=magenta'
    return 'insert'
  else
    exe 'hi! statusline guifg=black guibg=#cbd09b ctermfg=black ctermbg=white'
    return 'normal'
  endif
endfunction

function! setcursorlinenrcolorvisual()
    set updatetime=10

    call changestatuslinecolor('v')
endfunction

vnoremap <silent> <expr> <sid>setcursorlinenrcolorvisual setcursorlinenrcolorvisual()
nnoremap <silent> <script> v v<sid>setcursorlinenrcolorvisual
nnoremap <silent> <script> v v<sid>setcursorlinenrcolorvisual
nnoremap <silent> <script> <c-v> <c-v><sid>setcursorlinenrcolorvisual

augroup cursorlinenrcolorswap
  autocmd insertenter * call changestatuslinecolor('i')
  autocmd insertleave * call changestatuslinecolor('n')
  autocmd cursorhold * call changestatuslinecolor('n')
augroup end

" default with normal color when initial rendering
exe 'hi! statusline guifg=black guibg=#cbd09b ctermfg=black ctermbg=white'

function! makestatusline(...) abort
  let line = ''
  let line ..= ' %{changestatuslinecolor(mode())}     '
  let line ..= '%<'             " truncate point.
  let line ..= '%m'             " modified flag.
  let line ..= '%r'             " readonly flag.
  let line ..= '%t'            " short file name
  let line ..= '%='             " separation point.
  let line ..= ' %3l/%ll:%-2c'
  let line ..= ' %3p%%'         " percentage through file in lines.

  return line
endfunction

set laststatus=2 statusline=%!makestatusline()
