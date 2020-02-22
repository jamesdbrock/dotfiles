" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

set number

set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=4

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

" http://vim.wikia.com/wiki/256_colors_in_vim
" set t_Co=256
" set t_AB=<Esc>[48;5;%dm
" set t_AF=<Esc>[38;5;%dm

" set background=dark " tell vim what color the background is.

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

" highlight Normal guifg=white guibg=black
" " colorscheme solarized

" http://vi.stackexchange.com/questions/356/how-can-i-set-up-a-ruler-at-a-specific-column
set colorcolumn=81
highlight ColorColumn ctermbg=235 guibg=#262626
" let &colorcolumn="80,".join(range(120,999),",")

" http://vim.wikia.com/wiki/Highlight_current_line
set cursorline
highlight CursorLine ctermbg=234

" Remap `Q` to play the macro stored in the 'q' register. This way you can
" record a throw-away macro with `qq` and play it with `Q`. Also, nobody ever
" uses ex-mode.
nnoremap Q @q

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

" Enable syntax highlighting
syntax enable

" Use pleasant but very visible search hilighting
hi Search ctermfg=white ctermbg=173 cterm=none guifg=#ffffff guibg=#e5786d gui=none
hi! link Visual Search

" http://stackoverflow.com/questions/4256697/vim-search-and-highlight-but-do-not-jump
" nnoremap * *``
" nnoremap * :keepjumps normal *``<cr>
nnoremap * :keepjumps normal! mi*`i<CR>

" Enable filetype plugins
" filetype plugin on
" filetype indent on

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
:nnoremap <F5> :buffers<CR>:buffer<Space>

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
nnoremap <leader><cr> :noh<cr>

" Delete trailing white space on save
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

augroup whitespace
  autocmd!
  autocmd BufWrite *.hs :call DeleteTrailingWS()
  autocmd BufWrite *.ts :call DeleteTrailingWS()
  autocmd BufWrite *.tsx :call DeleteTrailingWS()
  autocmd BufWrite *.purs :call DeleteTrailingWS()
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

" colorscheme default, may be overridden by vimrc.plugins
try
  colorscheme murphy
catch
endtry

" Treat TypeScript React files as normal TypeScript files for the purpose
" of syntax highlighting.
augroup typescripthighlight
    autocmd!
    autocmd BufNewFile,BufRead *.tsx set filetype=typescript
augroup END
