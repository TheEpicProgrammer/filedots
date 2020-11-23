" Specify a directory for plugins For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Themes
Plug 'ale-cci/aqua-vim' " Aqua
Plug 'joshdick/onedark.vim' " One Dark
Plug 'dracula/vim' " Dracula
Plug 'mhartington/oceanic-next' " Oceanic Next
Plug 'vim-airline/vim-airline' " Status bar
Plug 'vim-airline/vim-airline-themes' " Status bar themes

" Syntax support
Plug 'dense-analysis/ale' " Syntax check
Plug 'jiangmiao/auto-pairs' " Auto pairs brackets
Plug 'scrooloose/nerdcommenter' " Comments plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'} " CoC

" Side bar
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Navigation
Plug 'terryma/vim-multiple-cursors'
Plug 'christoomey/vim-tmux-navigator'

" Cool details
Plug 'ryanoasis/vim-devicons' " Side bar icons

" Initialize plugin system
call plug#end()

" Ale
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_changed = 1
let g:ale_disable_lsp = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
highlight clear ALEErrorSign
highlight clear ALEWarningSign


" Fixing
let g:ale_fixers = {
    \ 'python': ['prettier'],
    \ 'javascript': ['prettier'],
    \ 'typescript': ['prettier'],
    \ 'golang': ['prettier'],
    \ 'c': ['prettier'],
    \ 'cpp': ['prettier']
\}

" Linting
let g:ale_linters = {
    \ 'python': ['pylint'],
    \ 'vim': ['vint'],
    \ 'cpp': ['clang'],
    \ 'c': ['clang'],
    \ 'javascript': ['eslint'],
    \ 'typescript': ['eslint'],
    \ 'golang': ['golint']
\}

nmap <silent> <C-e> <Plug>(ale_next_wrap)

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? 'OK' : printf(
        \   '%d⨉ %d⚠ ',
        \   all_non_errors,
        \   all_errors
        \)
endfunction
set statusline+=%=
set statusline+=\ %{LinterStatus()}


" Airline
let g:airline_theme='minimalist'
let g:airline_powerline_fonts = 1

" NerdTree
let g:NERDTreeShowHidden = 1
let g:NERDTreesMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatuslines = ''
" Automaticaly close nvim if NERDTRee is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nmap <F6> :NERDTreeToggle<CR>

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" Numbered lines
set number

" Theme
syntax enable
colorscheme aqua-vim 

" Tabgang
set tabstop=4
set shiftwidth=4
set expandtab

" Ctrl + C to copy
vmap <C-c> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>
