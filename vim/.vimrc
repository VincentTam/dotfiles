" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" ================= Vundle Config ====================

filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-repeat'

Plugin 'junegunn/vim-easy-align'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'bronson/vim-visual-star-search'
Plugin 'visualrepeat'

Plugin 'vim-latex/vim-latex'
Plugin 'plasticboy/vim-markdown'
Plugin 'kana/vim-textobj-lastpat'
Plugin 'kana/vim-textobj-user'
Plugin 'sgur/vim-textobj-parameter'
Plugin 'thinca/vim-textobj-between'

Plugin 'tomtom/tlib_vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

Plugin 'tpope/vim-fugitive'
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" TODO: this may not be in the correct place. It is intended to allow overriding <Leader>.
" source ~/.vimrc.before if it exists.
if filereadable(expand("~/.vimrc.before"))
  source ~/.vimrc.before
endif

" ================ General Config ====================

set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
" The mapleader has to be set before vundle starts loading all 
" the plugins.
let mapleader=","

" =============== Vundle Initialization ===============
" This loads all the plugins specified in ~/.vim/vundles.vim
" Use Vundle plugin to manage all other plugins
if filereadable(expand("~/.vim/vundles.vim"))
  source ~/.vim/vundles.vim
endif
au BufNewFile,BufRead *.vundle set filetype=vim

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo') && !isdirectory(expand('~').'/.vim/backups')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj    "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.pdf

"
" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Search ===========================

set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital
" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" ================ Custom Settings ========================

set textwidth=70
set pastetoggle=<F2> " Practical Vim Tip 63

" Practical Vim Tip 34: Avoid cursors when rcl'g cmd from hist
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" vim-easy-algin settings start
" Start interactive EasyAlign in visual mode
xmap ga <Plug>(EasyAlign)

augroup textCompletion
  au!
  au Filetype html,markdown,text inoremap <buffer> (     ()<++><Left><Left><Left><Left><Left>
  au Filetype html,markdown,text inoremap <buffer> ((    (
  au Filetype html,markdown,text inoremap <buffer> ()    ()<++><Left><Left><Left><Left><Left>
  au Filetype html,markdown,text inoremap <buffer> [     []<++><Left><Left><Left><Left><Left>
  au Filetype html,markdown,text inoremap <buffer> [[    [
  au Filetype html,markdown,text inoremap <buffer> []    []<++><Left><Left><Left><Left><Left>
  au Filetype html,markdown,text inoremap <buffer> {     {}<++><Left><Left><Left><Left><Left>
  au Filetype html,markdown,text inoremap <buffer> {{    {
  au Filetype html,markdown,text inoremap <buffer> {}    {}<++><Left><Left><Left><Left><Left>
  au Filetype html,markdown,text inoremap <buffer> ''    ''<++><Left><Left><Left><Left><Left>
  au Filetype html,markdown,text inoremap <buffer> ""    ""<++><Left><Left><Left><Left><Left>
  au Filetype html,markdown,text inoremap <buffer> <     <<Left><Right>><++><Left><Left><Left><Left><Left>
  au Filetype html,markdown,text inoremap <buffer> <<    <

  au Filetype markdown inoremap <buffer> ``    ``<++><Left><Left><Left><Left><Left>
  au Filetype markdown inoremap <buffer> **    **<++><Left><Left><Left><Left><Left>
augroup END

augroup specIndent
  au!
  au Filetype tex,markdown,css,scss,html,javascript,vim setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup END

" ============ EasyMotion config ============================

let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" ===========================================================

" Start interactive EasyAlign with a Vim movement
nmap ga <Plug>(EasyAlign)
" =============== vim-easy-algin settings end ===============

" =============== vim-latex settings ===============

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" 131001: change default output format
" http://superuser.com/questions/186283/compile-tex-files-to-pdf-as-default-in-gvim-with-latexsuite-plugin
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='pdf'

" 131212: add dir to $PATH for runtime to avoid too long $PATH in other prog
let $PATH .= '/mnt/c/Program Files/SumatraPDF'
let g:Tex_ViewRule_pdf='SumatraPDF'

" 131204: For better Chin and Unicode support
let g:Tex_CompileRule_pdf='xelatex -interaction=nonstopmode $*'
" LaTeX-Suite settings end

" =========== end of vim-latex settings ============

" ============== Gist settings start ==================

let g:github_user = 'VincentTam'
let g:gist_clip_command = 'putclip'
let g:gist_detect_filetype = 1
let g:gist_get_multiplefile = 1

" ============== Gist settings end ====================

" Improve visibility of cursor
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"
