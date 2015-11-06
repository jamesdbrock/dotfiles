" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" " https://github.com/tpope/vim-pathogen
" execute pathogen#infect()

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
" filetype plugin indent on

" https://github.com/begriffs/haskell-vim-now

" https://github.com/gmarik/Vundle.vim#about
" set the runtime path to include Vundle and initialize
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" " The following are examples of different formats supported.
" " Keep Plugin commands between vundle#begin/end.
" " plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" " plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" " Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" " git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" " The sparkup vim script is in a subdirectory of this repo called vim.
" " Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" " Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

" Plugin 'Valloric/YouCompleteMe'

" Support bundles
" Plugin 'jgdavey/tslime.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/syntastic'
" Plugin 'moll/vim-bbye'
" Plugin 'nathanaelkane/vim-indent-guides'
" Plugin 'vim-scripts/gitignore'

" Colorscheme
Plugin 'vim-scripts/wombat256.vim'

" Bars, panels, and files
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'

" Text manipulation
Plugin 'godlygeek/tabular'

" Git
Plugin 'tpope/vim-fugitive'
Plugin 'int3/vim-extradite'

" Haskell
" Plugin 'neovimhaskell/haskell-vim'
" Plugin 'enomsg/vim-haskellConcealPlus'
Plugin 'eagletmt/ghcmod-vim'
" Plugin 'eagletmt/neco-ghc'
" Plugin 'Twinside/vim-hoogle'

Plugin 'bitc/vim-hdevtools' " provides :HdevtoolsClear :HdevtoolsType :HdevtoolsInfo

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line






set number

set expandtab
set shiftwidth=4
set softtabstop=4
" http://stackoverflow.com/questions/9092347/how-to-make-vim-use-the-same-environment-as-my-login-shell-when-running-commands
set shell=bash\ -i

" set background=dark " tell vim what color the background is.
" highlight Normal guifg=white guibg=black
" " colorscheme solarized


noremap ; :
noremap : ;

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = " "
let g:mapleader = " "

" Leader key timeout
set tm=2000

" http://vim.wikia.com/wiki/Easy_edit_of_files_in_the_same_directory
cabbr <expr> %% expand('%:p:h')

" Find custom built ghc-mod, codex etc
let $PATH = $PATH . ':' . expand("~/.local/bin")



" Show trailing whitespace
set list
" But only interesting whitespace
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif


" http://stackoverflow.com/questions/164847/what-is-in-your-vimrc


" When started as "evim", evim.vim will already have done these settings.
" if v:progname =~? "evim"
"   finish
" endif


" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set whichwrap+=<,>,h,l


" Set to auto read when a file is changed from the outside
set autoread
set backup		" keep a backup file (restore to previous version)
set undofile		" keep an undo file (undo changes after closing)
set history=100		" keep 100 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set autoindent		" always set autoindenting on

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set vb t_vb=

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif


" Remap `Q` to play the macro stored in the 'q' register. This way you can
" record a throw-away macro with `qq` and play it with `Q`. Also, nobody ever
" uses ex-mode.
nnoremap Q @q

" for Shift-K
" set keywordprg=pophoogle
autocmd FileType haskell setlocal keywordprg=pophoogle

inoremap jk <Esc>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif


" Only do this part when compiled with support for autocommands.
if has("autocmd")


  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif





" http://stackoverflow.com/questions/4331776/change-vim-swap-backup-undo-file-name
" Save your backups to a less annoying place than the current directory.
" If you have .vim-backup in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/backup or . if all else fails.
if isdirectory($HOME . '/.vim/backup') == 0
  :silent !mkdir -p ~/.vim/backup >/dev/null 2>&1
endif
set backupdir-=.
set backupdir+=.
set backupdir-=~/
set backupdir^=~/.vim/backup/
set backupdir^=./.vim-backup/
set backup

" Save your swp files to a less annoying place than the current directory.
" If you have .vim-swap in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/swap, ~/tmp or .
if isdirectory($HOME . '/.vim/swap') == 0
  :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=./.vim-swap//
set directory+=~/.vim/swap//
set directory+=~/tmp//
set directory+=.

" viminfo stores the the state of your previous editing session
set viminfo+=n~/.vim/viminfo

if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.vim/undo//
  set undofile
endif



set scrolloff=5 " scroll if cursor is within 5 lines of edge
set ignorecase " case-insensitive search
set smartcase " case-sensitive when exists uppercase

" search up directories for tags file.
set tags=tags;

try
  colorscheme wombat256mod
catch
endtry


" Enable syntax highlighting
syntax enable

" Adjust signscolumn and syntastic to match wombat
hi! link SignColumn LineNr
hi! link SyntasticErrorSign ErrorMsg
hi! link SyntasticWarningSign WarningMsg

" Use pleasant but very visible search hilighting
hi Search ctermfg=white ctermbg=173 cterm=none guifg=#ffffff guibg=#e5786d gui=none
hi! link Visual Search

" Enable filetype plugins
" filetype plugin on
" filetype indent on

" Match wombat colors in nerd tree
hi Directory guifg=#8ac6f2

" Searing red very visible cursor
hi Cursor guibg=red

" " Use same color behind concealed unicode characters
" hi clear Conceal

" Don't blink normal mode cursor
set guicursor=n-v-c:block-Cursor
set guicursor+=n-v-c:blinkon0

" Set extra options when running in GUI mode
if has("gui_running")
  set guioptions-=T
  set guioptions-=e
  set guitablabel=%M\ %t
endif
set t_Co=256

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" http://vim.wikia.com/wiki/Easier_buffer_switching
" :nnoremap <F5> :buffers<CR>:buffer<Space>

" https://github.com/mileszs/ack.vim
" :nnoremap <F6> :Ack<CR>

" http://stackoverflow.com/questions/2404879/in-vim-how-can-i-have-a-permenant-status-line-showing-me-the-name-of-the-curren
set laststatus=2


" Open file prompt with current path
nnoremap <leader>e :e <C-R>=expand("%:p:h") . '/'<CR>

" Show undo tree
" nmap <silent> <leader>u :GundoToggle<CR>

" Fuzzy find files
nnoremap <silent> <Leader><space> :CtrlP<CR>
let g:ctrlp_max_files=0
let g:ctrlp_show_hidden=1
let g:ctrlp_custom_ignore = { 'dir': '\v[\/](.git|.cabal-sandbox)$' }

" Copy and paste to os clipboard
nmap <leader>y "*y
vmap <leader>y "*y
nmap <leader>d "*d
vmap <leader>d "*d
nmap <leader>p "*p
vmap <leader>p "*p


" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>


" Treat long lines as break lines (useful when moving around in them)
nnoremap j gj
nnoremap k gk

" window focus change bindings
noremap <c-h> <c-w>h
noremap <c-k> <c-w>k
noremap <c-j> <c-w>j
noremap <c-l> <c-w>l

" Space-CR means quit out of everything.
" Disable highlight when <leader><cr> is pressed
" but preserve cursor coloring
" nnoremap <leader><cr> :noh\|hi Cursor guibg=red<cr>
nnoremap <leader><cr> :noh<cr>:NERDTreeClose<cr>
augroup haskell
  autocmd!
  autocmd FileType haskell nnoremap <leader><cr> :noh<cr>:NERDTreeClose<cr>:SyntasticReset<cr>:GhcModTypeClear<cr>:HdevtoolsClear<cr>
"  autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
augroup END

" Delete trailing white space on save
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

augroup whitespace
  autocmd!
  autocmd BufWrite *.hs :call DeleteTrailingWS()
augroup END


function! CmdLine(str)
  exe "menu Foo.Bar :" . a:str
  emenu Foo.Bar
  unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  elseif a:direction == 'gv'
    call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.' . a:extra_filter)
  elseif a:direction == 'replace'
    call CmdLine("%s" . '/'. l:pattern . '/')
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction


" NERDTree

" Close nerdtree after a file is selected
let NERDTreeQuitOnOpen = 1

function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

function! ToggleFindNerd()
  if IsNERDTreeOpen()
    exec ':NERDTreeToggle'
  else
    exec ':NERDTreeFind'
  endif
endfunction

" If nerd tree is closed, find current file, if open, close it
" nmap <silent> <leader>f <ESC>:call ToggleFindNerd()<CR>
" nmap <silent> <leader>f <ESC>:NERDTreeToggle<CR>
nnoremap <silent> <leader>f <ESC>:NERDTreeFind<cr>


" Enable some tabular presets for Haskell
let g:haskell_tabular = 1


" Tags

" set tags=tags;/,codex.tags;/
"
" let g:tagbar_type_haskell = {
"     \ 'ctagsbin'  : 'hasktags',
"     \ 'ctagsargs' : '-x -c -o-',
"     \ 'kinds'     : [
"         \  'm:modules:0:1',
"         \  'd:data: 0:1',
"         \  'd_gadt: data gadt:0:1',
"         \  't:type names:0:1',
"         \  'nt:new types:0:1',
"         \  'c:classes:0:1',
"         \  'cons:constructors:1:1',
"         \  'c_gadt:constructor gadt:1:1',
"         \  'c_a:constructor accessors:1:1',
"         \  'ft:function types:1:1',
"         \  'fi:function implementations:0:1',
"         \  'o:others:0:1'
"     \ ],
"     \ 'sro'        : '.',
"     \ 'kind2scope' : {
"         \ 'm' : 'module',
"         \ 'c' : 'class',
"         \ 'd' : 'data',
"         \ 't' : 'type'
"     \ },
"     \ 'scope2kind' : {
"         \ 'module' : 'm',
"         \ 'class'  : 'c',
"         \ 'data'   : 'd',
"         \ 'type'   : 't'
"     \ }
" \ }

" " Generate haskell tags with codex and hscope
" map <leader>tg :!codex update --force<CR>:call system("git-hscope -X TemplateHaskell")<CR><CR>:call LoadHscope()<CR>
"
" map <leader>tt :TagbarToggle<CR>
"
" set csprg=~/.local/bin/hscope
" set csto=1 " search codex tags first
" set cst
" set csverb
" nnoremap <silent> <C-\> :cs find c <C-R>=expand("<cword>")<CR><CR>
" " Automatically make cscope connections
" function! LoadHscope()
"   let db = findfile("hscope.out", ".;")
"   if (!empty(db))
"     let path = strpart(db, 0, match(db, "/hscope.out$"))
"     set nocscopeverbose " suppress 'duplicate connection' error
"     exe "cs add " . db . " " . path
"     set cscopeverbose
"   endif
" endfunction
" au BufEnter /*.hs call LoadHscope()
"
" "


" https://github.com/scrooloose/syntastic#3-recommended-settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
" To always show the errors list when editing we can set the following flag
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:syntastic_haskell_checkers = ['ghc_mod', 'hdevtools', 'hlint']
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }

" Haskell Lint
" let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['haskell'] }
" let g:syntastic_haskell_hdevtools_args = '-g -Wall -g -isrc'
let g:hdevtools_options = '-g-ilib -g-isrc -g-i. -g-Wall -g-XOverloadedStrings'
let g:syntastic_haskell_hdevtools_args = '-g-ilib -g-isrc -g-i. -g-Wall -g-XOverloadedStrings'

nnoremap <leader>sm :SyntasticToggleMode<CR>
nnoremap <leader>sl :SyntasticCheck hlint<CR>
nnoremap <leader>sc :SyntasticCheck<CR>
nnoremap <leader>sr :SyntasticReset<CR>

" http://www.stephendiehl.com/posts/vim_haskell.html
" au FileType haskell nnoremap <buffer> <F2> :HdevtoolsType<CR>
" au FileType haskell nnoremap <buffer> <F3> :HdevtoolsClear<CR>
" au FileType haskell nnoremap <buffer> <F4> :HdevtoolsInfo<CR>
au FileType haskell nnoremap <buffer> t :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> T :HdevtoolsInfo<CR>


" Show types in completion suggestions
" let g:necoghc_enable_detailed_browse = 1

" Type of expression under cursor
nnoremap <silent> <leader>ht :GhcModType<CR>
" Insert type of expression under cursor
nnoremap <silent> <leader>hT :GhcModTypeInsert<CR>
" GHC errors and warnings
nnoremap <silent> <leader>hc :SyntasticCheck ghc_mod<CR>

" Shift-plus go to next error
nnoremap + :lnext<cr>
" Shift-minus go to previous error
nnoremap _ :lprev<cr>

