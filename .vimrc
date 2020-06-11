imap jk <Esc>
nmap <C-L> A;<esc>
imap <C-L> <esc>A;
nnoremap <NL> i<CR><ESC>
set number
set relativenumber
colorscheme ron
syntax on

"Autoreload of config file
augroup myvimrchooks
    au!
    autocmd bufwritepost .vimrc source ~/.vimrc
augroup END

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

"Set tab label to show tab number, filename and if modified
set guitablabel=%N/\ %t\ %M
