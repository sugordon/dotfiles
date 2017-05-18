" Default vimrc settings {{{
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2011 Apr 15
"
" To use it, copy it to
"   for Unix and OS/2:  ~/.vimrc
"	for Amiga:  s:.vimrc
"   for MS-DOS and Win32:  $VIM\_vimrc
"   for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

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

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

"}}}

" Vim Plug {{{
call plug#begin('~/.vim/bundle')
" Colorscheme
Plug 'nanotech/jellybeans.vim'
" Highlight matching HTML tags
Plug 'Valloric/MatchTagAlways'
" Commenting plugin, takes <leader>c[.] {{{
"[count]|<Leader>|cc |NERDComComment|
"[count]|<Leader>|cn |NERDComNestedComment|
"[count]|<Leader>|c<space> |NERDComToggleComment|
"[count]|<Leader>|cm |NERDComMinimalComment|
"[count]|<Leader>|ci |NERDComInvertComment|
"[count]|<Leader>|cs |NERDComSexyComment|
"[count]|<Leader>|cy |NERDComYankComment|
"|<Leader>|c$ |NERDComEOLComment|
"|<Leader>|cA |NERDComAppendComment|
"|<Leader>|ca |NERDComAltDelim|
"[count]|<Leader>|cl
"[count]|<Leader>|cb    |NERDComAlignedComment|
"[count]|<Leader>|cu |NERDComUncommentLine|
"}}}
Plug 'scrooloose/nerdcommenter'
" For moving horizontally with f(F), t(T)
Plug 'unblevable/quick-scope'
" Unite.vim, search file/grep, view registers, switch buffers
" Keybinds are below
Plug 'Shougo/unite.vim' | Plug 'Shougo/vimproc.vim', { 'do': 'make' }
" statusline for vim
Plug 'vim-airline/vim-airline'
" 'best Git wrapper of all time' :G...{{{
" :Gdiff
" :Gstatus
" :Gcommit
" :Gremove
" :Git(!)
" :Gread
" }}}
Plug 'tpope/vim-fugitive'
" 'For seeing changes made to git :GitGutter...{{{
" :GitGutterToggle
" :GitGutterNextHunk
" :GitGutterPrevHunk
" :GitGutterStageHunk
" :GitGutterUndoHunk
" :GitGutterPreviewHunk
" }}}
Plug 'airblade/vim-gitgutter'
" Indent guides <leader>ig to toggle
"Plug 'nathanaelkane/vim-indent-guides'
" Beautify Javascript{{{
Plug 'pangloss/vim-javascript'
Plug 'jelera/vim-javascript-syntax'
"}}}
" Incremental serach and replace
" call :OverCommandLine to active, autocommand below
Plug 'osyo-manga/vim-over'
" Sensible vim defaults
Plug 'tpope/vim-sensible'
" Smart buffer options, set indent, etc
Plug 'tpope/vim-sleuth'
" Project drawer{{{
" :NerdTree...
" <leader>f to toggle
" }}}
"Plug 'scrooloose/nerdtree'
Plug 'Shougo/vimfiler.vim'
" Tern for javascript {{{
"if has('nvim')
"function! DoRemote(arg)
"UpdateRemotePlugins
"endfunction
"Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
"Plug 'carlitux/deoplete-ternjs'
"endif

"Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }
"Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
" }}}
" Snippets
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
"Plug 'bundle/vim-lcov'
"Plug 'vimwiki/vimwiki'
"Plug 'jceb/vim-orgmode' |
Plug 'tpope/vim-speeddating'
Plug 'dhruvasagar/vim-dotoo'
Plug 'elzr/vim-json'
Plug 'lervag/vimtex'
Plug 'maxbrunsfeld/vim-yankstack'
" Plug 'vim-scripts/highlight.vim'
call plug#end()
" }}}

"set backup and undo directories {{{
call system('mkdir ' . '$HOME/.vim/.backup')
set backupdir=$HOME/.vim/.backup
set directory=$HOME/.vim/.backup

"Persistant Undo
"http://stackoverflow.com/questions/5700389/using-vims-persistent-undo
" Keep undo history across sessions by storing it in a file
" Put plugins and dictionaries in this dir (also on Windows)
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir
if has('persistent_undo')
  let myUndoDir = expand(vimDir . '/.undodir')
  " Create dirs
  call system('mkdir ' . vimDir)
  call system('mkdir ' . myUndoDir)
  let &undodir = myUndoDir
  set undofile
endif
"}}}

"Misc Settings{{{
"execute pathogen#infect()
filetype plugin indent on

set hidden
set number
set relativenumber
set exrc
set secure
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set background=dark
set t_Co=256
set colorcolumn=80
set incsearch
set ignorecase
set smartcase
set hlsearch
set splitbelow
set splitright
set wildmode=longest,list

function! s:SetTabWidth(...)
  if a:0 ==? 0
        call s:TabParams()
        return
    endif
    if a:0 ==? 1
        let &shiftwidth  = a:1
        let &softtabstop = a:1
        let &tabstop     = a:1
    endif
    if a:0 ==? 2
        let &shiftwidth  = a:1
        let &softtabstop = a:1
        let &tabstop     = a:1
        let &expandtab = a:2
    endif
endfunction

command! -nargs=* TabWidth call s:SetTabWidth(<f-args>)

function! s:TabParams()
    echo "tabstop:     " . &tabstop
    echo "shiftwidth:  " . &shiftwidth
    echo "softtabstop: " . &softtabstop
    echo "expandtab:   " . &expandtab
endfunc

"Clear all autocommands
augroup autocommands
  autocmd!
augroup END

" Override the unreadable SpecialKey color
let g:jellybeans_overrides = {'SpecialKey': { 'guifg': '2C51A5'}}

colorscheme jellybeans

autocmd FileType tex :setlocal spell spelllang=en_us

"}}}

"Key Bindings {{{
inoremap jk <Esc>
inoremap kj <Esc>
noremap <C-c> <Esc>
map <Space> <leader>
set timeout timeoutlen=1500
"nnoremap <leader>f :TagbarToggle<CR>
nnoremap <leader>fm :w<CR>:make<CR>
nnoremap <leader>fs :w<CR>
"nnoremap <leader>p :w<CR>:call LessToCss(":")<CR>
"nnoremap <leader>P :w<CR>:!~/Documents/front-end/less.sh<CR>

" Switch buffers
nnoremap <leader>j :bnext<CR>
nnoremap <leader>k :bprevious<CR>

" Maximize/Minimize Windows
nnoremap <leader>m <C-w>_<C-w>\|
nnoremap <leader>M <C-w>=

" New tab/ move to new tab
nnoremap <leader>t :split<CR><C-w>T

nnoremap <leader>s :split<CR>
nnoremap <leader>v :vsplit<CR>

nnoremap <leader>e :e %<CR>

nnoremap <leader>rr :vsplit<CR>:e $MYVIMRC<CR>
nnoremap <leader>rc :so $MYVIMRC<CR>

nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt

nnoremap <leader><leader> zz

inoremap {; {<CR>}<Esc>O

" :cwd/ gets buffer directory
cabbrev cwd %:p:h

"}}}
"
"Ultisnps{{{
let g:UltiSnipsExpandTrigger="<c-j>"
"}}}

"Indent guides{{{
let g:indent_guides_enable_on_vim_startup = 1
"}}}

"Quick Scope {{{
let g:qs_first_occurrence_highlight_color = 155       " terminal vim
let g:qs_second_occurrence_highlight_color = 81         " terminal vim
"}}}

"Airline{{{
let g:airline#extensions#tabline#enabled = 1
"Show shiftwidth and expandtab (S for spaces, T for tabs) next to the encoding
let g:airline_section_y = airline#section#create(['ffenc', ':%{&shiftwidth}-%{&expandtab?"s":"t"}'])
"}}}

" YouCompleteMe{{{
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_auto_trigger = 0
""}}}

"deoplete {{{
"let g:deoplete#enable_at_startup = 1
"let g:deoplete#sources = {}
"let g:deoplete#sources._ = []
"let g:deoplete#sources.js = []
"inoremap <silent><expr><C-Space> deoplete#mappings#manual_complete()

"let g:tern_request_timeout = 1
"let g:tern_show_signature_in_pum = 0  " This do disable full signature type on autocomplete
"}}}

"Auto Paste mode{{{
if &term =~ "xterm.*"
  let &t_ti = &t_ti . "\e[?2004h"
  let &t_te = "\e[?2004l" . &t_te
  function! XTermPasteBegin(ret)
    set pastetoggle=<Esc>[201~
    set paste
    return a:ret
  endfunction
  map <expr> <Esc>[200~ XTermPasteBegin("i")
  imap <expr> <Esc>[200~ XTermPasteBegin("")
  cmap <Esc>[200~ <nop>
  cmap <Esc>[201~ <nop>
endif
"}}}

"Git Gutter{{{
set updatetime=250
"}}}

" Vimfiler{{{
nnoremap <leader>fd :VimFilerBufferDir -create -force-quit<CR>
nnoremap <leader>ff :VimFilerExplorer<CR>
let g:vimfiler_as_default_explorer = 1
" Custom mappings for the unite buffer

"augroup autocommands
  "autocmd FileType vimfiler call s:vimfiler_settings()
"augroup END
"function! s:vimfiler_settings()
"endfunction
" }}}

"Vim-over{{{
cabbrev %s OverCommandLine<cr>%s
cabbrev '<,'>s OverCommandLine<cr>'<,'>s
cabbrev s OverCommandLine<cr>s
"}}}

"Unite {{{
set shortmess=ac
let g:unite_source_history_yank_enable = 1

function! InsideGit()
  if exists('b:gitdir') && (b:gitdir ==# '' || b:gitdir =~# '/$')
    unlet b:gitdir
  endif

  if !exists('b:gitdir')
    let b:gitdir = finddir('.git', ';')
  endif

  if strlen(b:gitdir)
    return 1
  else
    return 0
  endif
endfunction

function! UniteIsGit(git, norm)
  if InsideGit()
    return a:git
  else
    return a:norm
  endif
endfunction

let g:unite_option_string = " -direction=dynamicbottom -start-insert "

call unite#filters#matcher_default#use(['matcher_fuzzy'])
"call unite#filters#sorter_default#use(['sorter_selecta'])
call unite#filters#sorter_default#use(['sorter_rank'])
"let g:unite_source_rec_max_cache_files = 0
"call unite#custom#source('file_rec,file_rec/async,file_rec/git',
      "\ 'max_candidates', 0)
nnoremap <leader>uv :<c-u>Unite -direction=dynamicbottom -start-insert -buffer-name=files file_rec/async<cr>
nnoremap <leader>up :<c-u>execute UniteIsGit("Unite", "UniteWithBufferDir") .
      \ g:unite_option_string .
      \ "-buffer-name=files " .
      \ UniteIsGit("file_rec/git", "file_rec/async:!")<cr>
nnoremap <leader>ug :<c-u>execute UniteIsGit("Unite", "UniteWithBufferDir") .
      \ " -direction=dynamicbottom -start-insert " .
      \ "-buffer-name=grep " .
      \ UniteIsGit("grep/git", "grep")<cr><cr>
"nnoremap <leader>uf :<c-u>UniteWithBufferDir -direction=dynamicbottom -buffer-name=files -start-insert file<cr>
nnoremap <leader>uf :<c-u>UniteWithBufferDir -direction=dynamicbottom -buffer-name=files -start-insert file<cr>
nnoremap <leader>uy :<c-u>Unite -direction=dynamicbottom -buffer-name=yank register<cr>
nnoremap <leader>ub :<c-u>Unite -direction=dynamicbottom -buffer-name=buffer -start-insert buffer<cr>

" Custom mappings for the unite buffer
augroup autocommands
  autocmd FileType unite call s:unite_settings()
augroup END
function! s:unite_settings()
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  " control-f goes into quick match mode
  imap <buffer> <C-f>	<Plug>(unite_quick_match_default_action)
endfunction

if executable('ag')
  " Use ag (the silver searcher)
  " https://github.com/ggreer/the_silver_searcher
  "let g:unite_source_rec_async_command =
  "    \ ['ag', '--follow', '--nocolor', '--nogroup',
  "    \  '--hidden', '-g', '']
  let g:unite_source_rec_async_command = [ 'ag', '-l', '-g', '', '--nocolor' ]
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts =
        \ '-i --vimgrep --hidden --ignore ' .
        \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
  let g:unite_source_grep_recursive_opt = ''
endif
"}}}

"Folding{{{
augroup autocommands
  autocmd FileType vim setlocal foldmethod=marker
augroup END
"}}}

" Large file protection{{{
" from http://vim.wikia.com/wiki/Faster_loading_of_large_files
" file is large from 10mb
let g:LargeFile = 1024 * 1024 * 10
augroup autocommands
  autocmd BufReadPre * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
augroup END

function! LargeFile()
  " no syntax highlighting etc
  set eventignore+=FileType
  " save memory when other file is viewed
  setlocal bufhidden=unload
  " is read-only (write with :w new_filename)
  setlocal buftype=nowrite
  " no undo possible
  setlocal undolevels=-1
  " display message
  autocmd VimEnter *  echo "The file is larger than " . (g:LargeFile / 1024 / 1024) . " MB, so some options are changed (see .vimrc for details)."
endfunction
"}}}

"vim-dotoo{{{
let g:dotoo#agenda#files = ['~/org/*.dotoo']
let g:dotoo#capture#refile = expand('~/org/refile.dotoo')
let g:dotoo#parser#todo_keywords = [
            \ 'TODO',
            \ 'STARTED',
            \ '|',
            \ 'DONE']

augroup autocommands
    autocmd! BufNewFile,BufRead *.org setf dotoo
augroup END

function! s:DeleteOrgBuffers()
  for agenda_file in g:dotoo#agenda#files
    for orgfile in glob(agenda_file, 1, 1)
      silent execute 'w' orgfile
      silent execute 'bd' orgfile
    endfor
  endfor
endfunction
command! DeleteOrg call s:DeleteOrgBuffers()

nnoremap <leader>ow :<C-U>e ~/org/work.dotoo<CR>
nnoremap <leader>os :<C-U>e ~/org/school.dotoo<CR>
nnoremap <leader>oo :<C-U>e ~/org/other.dotoo<CR>

"}}}

"vimtex{{{
let g:vimtex_latexmk_enabled = 0
let g:tex_comment_nospell=1
"}}}

"yankstack{{{
let g:yankstack_map_keys = 0
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste
"}}}
