" vim: set foldmethod=marker foldlevel=0:
" ============================================================================
" mbriggs neovim configs
"
" plugins {{{
call plug#begin('~/.nvim/plugged')

Plug 'chriskempson/base16-vim'
Plug 'kien/ctrlp.vim'
Plug 'SirVer/ultisnips'
Plug 'Shougo/deoplete.nvim'
Plug 'junegunn/vim-emoji'
Plug 'junegunn/vim-oblique' | Plug 'junegunn/vim-pseudocl'
Plug 'junegunn/vim-after-object'
Plug 'junegunn/vim-journal'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary',        { 'on': '<Plug>Commentary' }
Plug 'tpope/vim-eunuch'
Plug 't9md/vim-surround_custom_mapping'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'vim-scripts/nginx.vim'
Plug 'othree/yajs.vim'
Plug 'mxw/vim-jsx'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'zerowidth/vim-copy-as-rtf', { 'on': 'CopyRTF' }
Plug 'justinmk/vim-gtfo'
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv', { 'on': 'Gitv' }
Plug 'mhinz/vim-signify'
Plug 'vim-ruby/vim-ruby'
Plug 'plasticboy/vim-markdown'
Plug 'honza/dockerfile.vim'
Plug 'chrisbra/unicode.vim', { 'for': 'journal' }
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
Plug 'sodapopcan/vim-twiggy'

call plug#end()
" }}}
" settings {{{
colorscheme base16-eighties
set background=dark

set showcmd                               " show commands in the lower right hand corner
set backupdir=~/.nvim/backup               " save backups to .vim/backup
set directory=~/.nvim/backup               " save .swp files to .vim/backup
set undodir=~/.nvim/backup                 " persistant undo
set undofile                              " save undo info
set undolevels=1000                       " for a long time
set undoreload=10000                      " ..
filetype plugin indent on                 " load the plugin and indent settings for the detected filetype
set backspace=indent,eol,start            " allow backspacing over everything in insert mode
set laststatus=2                          " always have status bar
set wildmode=list:longest,list:full       " bash-like tab completion
set ignorecase                            " ignore case when searching
set smartcase                             " disable ignorecase when there are caps
set nowrap                                " turn off line wrapping
set tabstop=2                             " tabs are 2 spaces
set shiftwidth=2                          " >> goes 2 spaces
set softtabstop=2                         " auto tabs are 2 spaces
set autoread                              " load file if it changed on disk
set expandtab                             " spaces instead of tabs
set list listchars=tab:\ \ ,trail:.       " show leading and trailings spaces/tabs
set encoding=utf-8                        " default encoding to utf-8
set ruler                                 " cursor position in modeline
syntax on                                 " syntax highlighting
set novisualbell                          " turn off blinking
set history=1000                          " lots of history
set linebreak                             " wrap at word
set showtabline=2                         " always show tabs
set wrap                                  " word wrap
set showbreak=...                         " show ... at line break
set confirm                               " confirm save when leaving unsaved buffers
set foldlevelstart=99                     " turn off default folding
set wildignore+=.git,.hg,node_modules,tmp " dont search these places
set clipboard=unnamed                     " use system clipboard
set background=dark                       " use dark bg
set timeoutlen=1000 ttimeoutlen=0         " fix esc delay
set shell=zsh\ -l
" }}}
" ag {{{
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
" }}}
" text objects {{{
autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ')
" }}}
" snippets {{{
let g:UltiSnipsEditSplit="vertical"
" }}}
" mappings {{{
let mapleader=' '
let maplocalleader='  '

nmap <Leader>so <esc>:source ~/.nvim/vimrc.vim
nmap <Leader>p <esc>:CtrlP

" tab indents
vnoremap <tab> ==

" kill line
inoremap <c-s-bs> <esc>ddi
noremap <c-s-bs> <esc>ddi

" ret open new line below
inoremap <c-cr> <esc>o
noremap <c-cr> <esc>o

" ctrl-ret open new line above
inoremap <c-s-cr> <esc>O
noremap <c-s-cr> <esc>O

" join in insert mode
inoremap <c-s-j> <esc>Ji

" duplicate line
nnoremap <c-d> mpyyp`p

" save
map <c-s> :w<cr>

" duplicate selection
vnoremap <c-d> mpy`>p`p

"new line, but stay in command mode
nnoremap <c-return> mpo<esc>`p

"new line, but stay at current position
inoremap <c-return> <esc><c-return>a

" alt-tab
nmap <Leader><tab> <c-^>

" close all other splits
nmap - :only<cr>

" CTags
nmap <C-F5> :!ctags --extra=+f -R *<CR><CR>
nmap <C-\> :tnext<CR>

" jump to matching pair
nnoremap <Leader> %

nmap <right> :lnext<cr>
nmap <left> :lprevious<cr>
nmap <down> :cnext<cr>
nmap <up> :cprevious<cr>

"c-backspace to delete word
imap <C-BS> <C-W>
cmap <C-BS> <C-W>

" Hit return to clear a search
nnoremap <silent> <expr> <CR> &bt == "" ? ":nohlsearch<CR>" : "\<CR>"

" %% for current dir
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" front and back of a line
nnoremap <s-h> ^
nnoremap <s-l> $

"toggle spellcheck
nmap <f4> :set spell!<cr>

" why isn't it this by default??
nnoremap <s-y> y$

"resize window
nnoremap <silent> + :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> _ :exe "resize " . (winheight(0) * 2/3)<CR>

"\  goes back a jump
nnoremap \ ,
" }}}
" completion {{{
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

let g:deoplete#enable_at_startup = 1
imap <expr> <TAB> UltiSnips#ExpandSnippetOrJump() ? "" :  pumvisible() ? "\<C-n>" : "\<TAB>"
imap <expr> ; pumvisible() ? deoplete#mappings#smart_close_popup() : ";"
" }}}
" auto mkdir {{{
augroup vimrc-auto-mkdir
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
  function! s:auto_mkdir(dir, force)
    if !isdirectory(a:dir)
          \   && (a:force
          \       || input("'" . a:dir . "' does not exist. Create? [y/N]") =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction
augroup END
" }}}
" copy path {{{
nnoremap <f8> :<C-u>call <SID>copy_path()<CR>
function! s:copy_path()
  let @*=expand('%')
  let @"=expand('%')
  let @+=expand('%')
endfunction
" }}}
" gist {{{
let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1
" }}}
" navigation {{{
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" }}}
" syntastic {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_html_checkers = ['']
let g:syntastic_javascript_checkers = ['']
" }}}
" surround {{{
let g:surround_custom_mapping = {}
let g:surround_custom_mapping.ruby = {
            \ '-':  "<% \r %>",
            \ '=':  "<%= \r %>",
            \ '%':  "%|\r|",
            \ 'w':  "%w(\r)",
            \ '#':  "#{\r}",
            \ }
let g:surround_custom_mapping.javascript = {
            \ 'f':  "function(){ \r }"
            \ }
" }}}
" git changes {{{
let g:signify_sign_add                 = "|"
let g:signify_sign_delete              = "|"
let g:signify_sign_delete_first_line   = "|"
let g:signify_sign_change              = g:signify_sign_add
let g:signify_sign_changedelete        = g:signify_sign_add
let g:signify_vcs_list                 = ['git']
let g:signify_cursorhold_normal        = 1

set background=dark

augroup sign-column
  autocmd!
  autocmd BufEnter * call s:force_sign_col()
  function! s:force_sign_col()
    sign define dummy
    execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')
  endfunction
augroup END
" }}}
" modeline {{{
set statusline=%f       "tail of the filename

set statusline+=%y      "filetype
set statusline+=%r      "read only flag
set statusline+=%m      "modified flag

set statusline+=\ \ \ %{FileSize()}

set statusline+=%#warningmsg#
set statusline+=%*

set statusline+=%=      "left/right separator
set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set laststatus=2


function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction


function! FileSize()
  let bytes = getfsize(expand("%:p"))
  let kb = 1024.0
  let mb = kb * 1000.0
  let gb = mb * 1000.0

  if bytes <= 0
    return ""
  endif

  if bytes > gb
    return printf('%.2f', bytes / gb) . "gb"
  endif

  if bytes > mb
    return printf('%.2f', bytes / mb) . "mb"
  endif

  if bytes > kb
    return printf('%.2f', bytes / kb) . "kb"
  endif

  return bytes
endfunction
" }}}

