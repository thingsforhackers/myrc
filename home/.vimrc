" njohn's personal .vimrc file

set nocompatible                        " vim defaults, not vi!

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" My pluggins from here
Plugin 'xolox/vim-misc'
Plugin 'easymotion/vim-easymotion'
Plugin 'Lokaltog/vim-powerline'
Plugin 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'
Plugin 'tpope/vim-fugitive'
Plugin 'tmhedberg/SimpylFold'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'jnurmine/Zenburn'
Plugin 'scrooloose/syntastic'
" Plugin 'xolox/vim-easytags'
Plugin 'majutsushi/tagbar'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'brookhong/cscope.vim'
Plugin 'fatih/vim-go'
Plugin 'valloric/youcompleteme'
Plugin 'cespare/vim-toml'

call vundle#end()
filetype plugin indent on

set nocscopeverbose
set laststatus=2                        " Always show the status line
set encoding=utf-8                      " Needed for Unicode glyphs
set expandtab                           " expand tabs to spaces
set tabstop=4                           " tabstops of 4
set shiftwidth=4                        " indents of 4
set nu                                  " numbers
set rnu                                  " numbers
set foldmethod=indent                   " Enable folding
set foldlevel=99                        "
set scrolloff=30                        " keep cursor in middle of screen
" Configure NERDTree
let NERDTreeIgnore = ['\.pyc$']

" Cfg easy-tags
augroup grp_easy_tag
    autocmd!
    autocmd FileType python let b:easytags_auto_highlight = 0
augroup END
let g:easytags_async=1
let g:easytags_file = join([getcwd(), 'vimtag'], '/')

" Cfg PowerLine
"  let g:Powerline_symbols = 'fancy'
let g:buffergator_suppress_keymaps = 1

" colour scheme
set t_Co=256
let python_highlight_all=1
syntax on
color zenburn

" Override any cusor stuff that color might have set
set cursorline                          " cursor line

" Syntastic related settings
set statusline+=%#warnings#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" rebind map leader key
let mapleader = "-"

nnoremap  <leader>o :NERDTreeToggle<CR>  " Toggle NERDTree
nnoremap  <leader>q :quit<CR>            " Quick quit
nnoremap  <leader>re :call NumberToggle()<CR>     " Toggle rel line mode
nnoremap  <leader>t :TagbarOpen fj<CR>            " Tagbar open and stay open
nnoremap  <leader>T :TagbarClose<CR>            " Tagbar close
nnoremap  <leader>w :write<CR>            " Write buffer

nnoremap  <leader>-- :qa<CR>  " Quit all

vnoremap <leader>s :sort<CR> " Sort selected text

" Save reaching for ESC
inoremap jk <esc>
" If I do, do nothing
" inoremap <esc> <nop>
nnoremap <Up> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <right> <nop>
noremap <space> za

vnoremap < <gv	" better indent
vnoremap > >gv	" better indent

" Golang specific key maps
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>ds <Plug>(go-def-split)

" Automatic reload of .vimrc ------------------------- {{{
augroup grp_gen
    autocmd!
    autocmd! bufwritepost $MYVIMRC source %
    autocmd InsertEnter * :set norelativenumber
    autocmd InsertLeave * :set relativenumber
augroup END
" }}}

" Build tags function
function! BuildTags()
    let l:tag_file = join([getcwd(), 'vimtag'], '/')
    let g:easytags_file = l:tag_file
    let l:cmd_line = join(['!ctags -R -f', l:tag_file, getcwd()], ' ')
    execute l:cmd_line
    echom 'Set tag file to ' . g:easytags_file
endfunction

function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
   else
        set relativenumber
   endif
endfunc

" Look for project specific vimrc file
function! LoadProjectVIM()
    let l:pfile = '.project.vimrc'
    let l:pfile_path = findfile(l:pfile, '.;')
    if filereadable(l:pfile_path)
        echo 'Sourcing project vimrc file @ ' . l:pfile_path
        exec 'source '.fnameescape(l:pfile_path)
    endif
endfunction
call LoadProjectVIM()
