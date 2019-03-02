" NeoVim config file
"
" The original file path is: ~/.config/nvim/init.vim

imap jk <Esc>
map <C-b> :NERDTreeToggle<CR>
set number
set relativenumber
syntax on

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab


call plug#begin('~/.local/share/nvim/plugged')
Plug 'https://github.com/ludovicchabant/vim-gutentags'
Plug 'scrooloose/nerdtree'
Plug 'bfredl/nvim-miniyank'
Plug 'moll/vim-bbye'
Plug 'itchyny/lightline.vim'

" Rename with variations, I am not going to use by now
" Plug 'tpope/vim-abolish'

" Commentary code with "gcc" or Ctrl+/
Plug 'tpope/vim-commentary'
map <C-_> gcc

call plug#end()

" Autoreload of config file
augroup myvimrchooks
    au!
    autocmd bufwritepost init.vim source ~/.config/nvim/init.vim
augroup END

" Ctags
au BufWritePost *.php silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &

" nvim-miniyank
map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)
map <leader>p <Plug>(miniyank-startput)
map <leader>P <Plug>(miniyank-startPut)
