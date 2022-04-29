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
:set colorcolumn=81,121

let g:clang_format_fallback_style="Google"
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_confirm_extra_conf=0

let mapleader=","

autocmd FileType c,cpp nnoremap <leader><F> :py3f $HOME/clang-format.py<CR>
autocmd FileType c,cpp vnoremap <leader><F> :py3f $HOME/clang-format.py<CR>
" autocmd FileType python nnoremap <leader><F> :0,$!yapf<CR><C-o> 
let g:ale_linters={"python": ["pylint"]}
let g:ale_fixers = ["yapf"]
let g:ale_open_list=1
let g:ale_set_quickfix=1
let g:ale_set_loclist=0
" does not seem to work due to os.fspath called by config_initialization of
" pylint?
" let g:ale_python_pylint_options='--rcfile $HOME/uuv/ros2/.pylintrc'
silent! autocmd FileType python nnoremap <leader>f <Plug>(ale_fix)
