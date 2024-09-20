" Base Configuration
syntax on
set ai tabstop=4 softtabstop=4 expandtab smarttab shiftwidth=4

set ruler scrolloff=10 wrap
set mouse=a nopaste number norelativenumber

" Remap the leader-key
let mapleader = ","
let maplocalleader = ";"

" Copy-Pasta-Mode(r)(tm)(c)
function! ToggleCopyMode()
  " check if mouse is enabled
  if &mouse == 'a'
    set mouse= paste nonumber norelativenumber
  else
    set mouse=a nopaste number
  endif
endfunc

nmap <leader>c :call ToggleCopyMode()<CR>
nmap <leader>v :set relativenumber!<CR>

" Search Pattern Highlighting
set hlsearch
nohls
nnoremap <esc><esc> :silent! nohls<cr>

" Systemwide Clipboard
vmap <leader>y :w! /tmp/vitmp<CR>
nmap <leader>p :r! cat /tmp/vitmp<CR>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup redhat
  autocmd!
  " In text files, always limit the width of text to 78 characters
  autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif
