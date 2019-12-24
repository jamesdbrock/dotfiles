" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
" filetype plugin indent on

" https://github.com/begriffs/haskell-vim-now

" https://github.com/junegunn/vim-plug
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Plugin 'Valloric/YouCompleteMe'

" Support bundles
" Plugin 'jgdavey/tslime.vim'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'ervandew/supertab'
Plug 'scrooloose/syntastic'
" Plugin 'moll/vim-bbye'
" Plugin 'nathanaelkane/vim-indent-guides'
" Plugin 'vim-scripts/gitignore'

" Colorscheme
Plug 'vim-scripts/wombat256.vim'

" Bars, panels, and files
Plug 'scrooloose/nerdtree'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1

Plug 'kien/ctrlp.vim'
" Plugin 'majutsushi/tagbar' " causes vim to background on startup when set shell=bash bashrc.vim-hdevtools

" Text manipulation
Plug 'godlygeek/tabular'

" Git
Plug 'tpope/vim-fugitive'
Plug 'int3/vim-extradite'
Plug 'airblade/vim-gitgutter'

" Haskell
Plug 'bitc/vim-hdevtools' " provides :HdevtoolsClear :HdevtoolsType :HdevtoolsInfo

" HTML
" Plugin 'alvan/vim-closetag'
Plug 'tpope/vim-ragtag'

Plug 'vim-scripts/gnupg.vim' " edit gpg encrypted files

Plug 'mileszs/ack.vim' " provides :Ack

" Nix
Plug 'LnL7/vim-nix' " Nix syntax highlighting

" Purescript
Plug 'purescript-contrib/purescript-vim' " Purescript syntax highlighting

" Initialize plugin system
call plug#end()

" for HdevtoolsType 2-line results
set cmdheight=2

" Find custom built ghc-mod, codex etc
let $PATH = $PATH . ':' . expand("~/.local/bin")

" for Shift-K
" set keywordprg=pophoogle
autocmd FileType haskell setlocal keywordprg=pophoogle

try
  colorscheme wombat256mod
catch
endtry

" Adjust signscolumn and syntastic to match wombat
hi! link SignColumn LineNr
hi! link SyntasticErrorSign ErrorMsg
hi! link SyntasticWarningSign WarningMsg

" Match wombat colors in nerd tree
hi Directory guifg=#8ac6f2

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

let g:hdevtools_stack = 1
" let g:hdevtools_cabal_sandbox = 1
let g:hdevtools_options = '-g-Wall -g-fdefer-type-errors'
let g:syntastic_haskell_hdevtools_args = g:hdevtools_options

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



" Git

let g:extradite_width = 60
" Hide messy Ggrep output and copen automatically
function! NonintrusiveGitGrep(term)
  execute "copen"
  " Map 't' to open selected item in new tab
  execute "nnoremap <silent> <buffer> t <C-W><CR><C-W>T"
  execute "silent! Ggrep " . a:term
  execute "redraw!"
endfunction

command! -nargs=1 GGrep call NonintrusiveGitGrep(<q-args>)
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gg :copen<CR>:GGrep
nnoremap <leader>gl :Extradite!<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gb :Gblame<CR>

function! CommittedFiles()
  " Clear quickfix list
  let qf_list = []
  " Find files committed in HEAD
  let git_output = system("git diff-tree --no-commit-id --name-only -r HEAD\n")
  for committed_file in split(git_output, "\n")
    let qf_item = {'filename': committed_file}
    call add(qf_list, qf_item)
  endfor
  " Fill quickfix list with them
  call setqflist(qf_list, '')
endfunction

" Show list of last-committed files
nnoremap <silent> <leader>g? :call CommittedFiles()<CR>:copen<CR>

" " filenames like *.xml, *.html, *.xhtml, ...
" let g:closetag_filenames = "*.html,*.xhtml,*.htm,*.xml,*.md,*.markdown"
" " copied from the internals of closetag.vim
" " exec "au BufNewFile,Bufread " . g:closetag_filenames . " inoremap <silent> <buffer> ,, :call <SID>CloseTagFun()<Cr>"

" vim-ragtag
let g:ragtag_global_maps = 1

" repeated, to override some plugin that is setting this
highlight ColorColumn ctermbg=235 guibg=#262626

" gnupg
let g:GPGExecutable = 'gpg2'

" https://github.com/mileszs/ack.vim
:nnoremap <F6> :Ack!<CR>

