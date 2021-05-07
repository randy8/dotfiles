" ~/.vimrc

" UI
colorscheme torte
set noerrorbells number ruler title visualbell t_vb=

" Jump to last edited line when re-opening a file instead of BOF
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Indentation
set autoindent expandtab shiftwidth=4 smarttab tabstop=4

" Search
set ignorecase smartcase incsearch hlsearch showmatch wrapscan

" Text rendering
set encoding=utf-8 nowrap
syntax on
filetype indent plugin on

" Ansible/yaml
au FileType yaml setl ai cuc et nu ts=2 sta sw=2
