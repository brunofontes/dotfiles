" NeoVim config file
"
" The original file path is: ~/.config/nvim/init.vim

"BEGIN My personalizations
    imap jk <Esc>
    map <C-b> :NERDTreeToggle<CR>
    map <C-A-s> :Startify<CR>
    set number
    set relativenumber
    colorscheme ron
    syntax on


"BEGIN Autoreload of config file
augroup myvimrchooks
    au!
    autocmd bufwritepost init.vim source ~/.config/nvim/init.vim
augroup END


"BEGIN IDENT - To ident with 4 spaces on tab
    filetype plugin indent on
    " show existing tab with 4 spaces width
    set tabstop=4
    " when indenting with '>', use 4 spaces width
    set shiftwidth=4
    " On pressing tab, insert 4 spaces
    set expandtab


"BEGIN Plug - Install plugins easily with just a :PlugInstall command
    call plug#begin('~/.local/share/nvim/plugged')

    Plug 'https://github.com/ludovicchabant/vim-gutentags'
    Plug 'scrooloose/nerdtree'
    Plug 'bfredl/nvim-miniyank'
    Plug 'moll/vim-bbye'
    Plug 'itchyny/lightline.vim'
    Plug 'amiorin/vim-project'
    Plug 'mhinz/vim-startify'
    Plug 'StanAngeloff/php.vim'
    Plug 'stephpy/vim-php-cs-fixer'

    "BEGIN NCM2 Autocomplete
        Plug 'ncm2/ncm2'
        Plug 'roxma/nvim-yarp'
        let g:python3_host_prog='/usr/bin/python3'
        autocmd BufEnter * call ncm2#enable_for_buffer()
        set completeopt=noinsert,menuone,noselect
        Plug 'ncm2/ncm2-bufword'
        Plug 'ncm2/ncm2-path'
        inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
        inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
        set shortmess+=c
        inoremap <c-c> <ESC>
        inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
    "END NCM2
    
    "Autocomplete even more
        Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'}
        Plug 'phpactor/ncm2-phpactor'

    " Rename with variations, I am not going to use by now
    " Plug 'tpope/vim-abolish'

    " Commentary code with "gcc" or Ctrl+/
    Plug 'tpope/vim-commentary'
    " <C-_> works as <C-/>. I am not sure why Vim identifies it like this
    vmap <C-_> gc
    nmap <C-_> gcc

    call plug#end()


"BEGIN Ctags
    au BufWritePost *.php silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &


"BEGIN nvim-miniyank
    map p <Plug>(miniyank-autoput)
    map P <Plug>(miniyank-autoPut)
    map <leader>p <Plug>(miniyank-startput)
    map <leader>P <Plug>(miniyank-startPut)

"BEGIN vim-project
    call project#rc("~/development")
    Project 'Bruno\ Fontes/DicionarioCC\ -\ Site/', 'Dicionarios.cc'

" BEGIN php-cs-fixer
    " MUST HAVE Composer and php_cs_fixer installed GLOBALLY 
    " before installing the plugin
    let g:php_cs_fixer_php_path = "/usr/bin/php"
    autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()
