" NeoVim config file
"
" The original file path is: ~/.config/nvim/init.vim

"BEGIN My personalizations
    imap jk <Esc>
    map <C-b> :NERDTreeToggle<CR>
    map <C-A-s> :Startify<CR>
    nmap <C-L> A;<esc>
    imap <C-L> <esc>A;
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

    " Searching / Replacing on all files
    " Needs to install fzf on filesystem first
    Plug 'junegunn/fzf', {'dir': '~/.fzf'}
    Plug 'junegunn/fzf.vim'
    nnoremap <leader>s :Rg<space>
    map <A-O> :Tags<CR>

    " Search occurrences into multiple files (combined with fzf)
    " Needs to install ripgrep on filesystem first
    Plug 'BurntSushi/ripgrep'
    nnoremap <C-F> :Rg<space>
    nnoremap <leader>A :exec "Rg ".expand("<cword>")<cr>
    autocmd VimEnter * command! -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)


    "Replace on multiple files
    "<leader>a  = Search
    "<leader>r  = Replace into the searched results
    Plug 'wincent/ferret' 


    "Neomake - finds errors on your code
    Plug 'neomake/neomake'


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

"BEGIN Neomake
	" When writing a buffer (no delay), and on normal mode changes (after 750ms).
	call neomake#configure#automake('nw', 750)
