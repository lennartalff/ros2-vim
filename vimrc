set nocompatible
" required for vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'preservim/nerdtree'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'dense-analysis/ale'
Plugin 'tmsvg/pear-tree'

call vundle#end()
filetype plugin indent on
syntax on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

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
let mapleader=","

" always show mode status line
set laststatus=2
" always show mode
set showmode


inoremap jj <ESC>

noremap <leader>t :NERDTreeToggle<CR>

set t_Co=256
set background=dark
silent! colorscheme PaperColor
:set colorcolumn=81,121

let g:clang_format_fallback_style="Google"
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_confirm_extra_conf=0

autocmd FileType c,cpp nnoremap <leader>f :py3f $HOME/clang-format.py<CR>
autocmd FileType c,cpp vnoremap <leader>f :py3f $HOME/clang-format.py<CR>
" autocmd FileType python nnoremap <leader><F> :0,$!yapf<CR><C-o> 
let g:ale_linters={"python": ["pylint"]}
let g:ale_fixers = ["yapf"]
let g:ale_open_list=1
let g:ale_set_quickfix=0
let g:ale_set_loclist=1
" does not seem to work due to os.fspath called by config_initialization of
" pylint?
" let g:ale_python_pylint_options='--rcfile $HOME/uuv/ros2/.pylintrc'
silent! autocmd FileType python nnoremap <leader>f :0,$!yapf<CR><C-o>
