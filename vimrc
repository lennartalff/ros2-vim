set nocompatible
" required for vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'preservim/nerdtree'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'NLKNguyen/papercolor-theme'

call vundle#end()
filetype plugin indent on
syntax on

"disable soft wraps
set nowrap
augroup WrapLine
	autocmd!
	autocmd FileType txt setlocal wrap
	autocmd FileType rst setlocal wrap
augroup End
" enable line numbers
set number relativenumber
set nu rnu
set ruler
set visualbell
set encoding=utf-8
set ttyfast

" always show mode status line
set laststatus=2
" always show mode
set showmode


inoremap jj <ESC>

set t_Co=256
set background=dark
silent! colorscheme PaperColor

let g:clang_format_fallback_style="Google"
map <C-I> :py3f $HOME/clang-format.py<CR>
imap <C-I> :py3f $HOME/clang-format.py<CR>
