
 "example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2011 Apr 15
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

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

" My Changes

set backupdir=~/.backup
set directory=~/.backup

inoremap jk <Esc>
inoremap kj <Esc>

set number
set relativenumber
execute pathogen#infect()
filetype plugin indent on
filetype plugin on

set exrc
set secure
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set background=dark
set t_Co=256
colorscheme distinguished
set colorcolumn=80

"Key Bindings

set timeout timeoutlen=1500
nmap <leader>f :TagbarToggle<CR>
nmap <leader>r :w<CR>:!colormake<CR>
map <Space> <leader>
nnoremap <leader>fs :w<CR>
nmap <leader>p <C-p>
"nmap <leader>p :w<CR>:call LessToCss(":")<CR>
"nmap <leader>P :w<CR>:!~/Documents/front-end/less.sh<CR>

nmap <leader>j <C-w>j
nmap <leader>k <C-w>k
nmap <leader>h <C-w>h
nmap <leader>l <C-w>l

nmap <leader>m <C-w>_<C-w>\|
nmap <leader>M <C-w>=

nmap <leader>n :split<CR><C-w>T
nmap <leader>t <C-w>T

nmap <leader>s :split<CR><C-w>j
nmap <leader>v :vsplit<CR><C-w>l
nmap <leader>u :wa<CR>:!sudo ./upload.sh<CR>

nmap <leader>1 1gt
nmap <leader>2 2gt
nmap <leader>3 3gt
nmap <leader>4 4gt
nmap <leader>5 5gt
nmap <leader>6 6gt
nmap <leader>7 7gt
nmap <leader>8 8gt
nmap <leader>9 9gt

set shortmess=a

"vim-easytags
:autocmd FileType lua let b:easytags_auto_highlight = 0
:autocmd FileType lua let b:easytags_auto_update = 0

"Ultisnps
let g:UltiSnipsExpandTrigger="<tab>"

"Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_check_on_wq = 0
let g:syntastic_html_checkers = ['w3']
let g:syntastic_mode_map = {
    \ "mode": "passive",
    \ "active_filetypes": [],
    \ "passive_filetypes": [] }

"Less compiler
function LessToCss(type)
  let current_file = shellescape(expand('%:p'))
  let filename = shellescape(expand('%:r'))
  let command = a:type . " !lessc " . current_file . " " . filename . ".css"
  execute command
endfunction
"autocmd BufWritePost,FileWritePost *.less call LessToCss("silent")

"Quick Scope
let g:qs_first_occurrence_highlight_color = 155       " terminal vim
let g:qs_second_occurrence_highlight_color = 81         " terminal vim

" Setup some default ignores
 let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
    \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}

"Auto Paste mode
if &term =~ "xterm.*"
    let &t_ti = &t_ti . "\e[?2004h"
    let &t_te = "\e[?2004l" . &t_te
    function XTermPasteBegin(ret)
        set pastetoggle=<Esc>[201~
        set paste
        return a:ret
    endfunction
    map <expr> <Esc>[200~ XTermPasteBegin("i")
    imap <expr> <Esc>[200~ XTermPasteBegin("")
    cmap <Esc>[200~ <nop>
    cmap <Esc>[201~ <nop>
endif

"Automatically comiple latex
function CompileLatex()
    let current_file = shellescape(expand('%:p'))
    let command = "!pdflatex " . current_file
    execute command
endfunction
"autocmd FileType tex setlocal makeprg=pdflatex\ --shell-escape\ '%'
"autocmd FileType tex noremap <buffer> <F5> :w<CR> :!pdflatex -shell-escape "%" && evince %:p:r.pdf<CR>
"autocmd BufWritePost,FileWritePost *.tex :!pdflatex -shell-escape "%" && evince %:p:r.pdf<CR>
autocmd BufWritePost,FileWritePost *.tex call CompileLatex()
let g:list_of_normal_keys = ["h", "j", "k", "l", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_visual_keys = ["h", "j", "k", "l", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_insert_keys = ["<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:hardtime_default_on = 1
let g:hardtime_showmsg = 1
let g:hardtime_allow_different_key = 1
let g:hardtime_maxcount = 3

autocmd BufRead,BufNewFile *.tex setlocal spell
