" NeoVim config file
"
" The original file path is: ~/.config/nvim/init.vim

"My personalizations
    imap jk <Esc>
    map <C-b> :NERDTreeToggle<CR>
    map <C-A-s> :Startify<CR>
    nmap <C-L> A;<esc>
    imap <C-L> <esc>A;
    set number
    set relativenumber
    colorscheme ron
    syntax on


"Autoreload of config file
augroup myvimrchooks
    au!
    autocmd bufwritepost init.vim source ~/.config/nvim/init.vim
    autocmd bufwritepost nvim.vim source ~/.config/nvim/init.vim
augroup END


"IDENT - To ident with 4 spaces on tab
    filetype plugin indent on
    " show existing tab with 4 spaces width
    set tabstop=4
    " when indenting with '>', use 4 spaces width
    set shiftwidth=4
    " On pressing tab, insert 4 spaces
    set expandtab

"Plug - Install plugins easily with just a :PlugInstall command
    call plug#begin('~/.local/share/nvim/plugged')

    Plug 'https://github.com/ludovicchabant/vim-gutentags'
    Plug 'scrooloose/nerdtree'
    Plug 'bfredl/nvim-miniyank'
    Plug 'moll/vim-bbye'
    Plug 'itchyny/lightline.vim'
    Plug 'amiorin/vim-project'
    Plug 'mhinz/vim-startify'
    Plug 'StanAngeloff/php.vim', {'for': 'php'}
    Plug 'stephpy/vim-php-cs-fixer'
    Plug 'adoy/vim-php-refactoring-toolbox'

    "GIT inside VIM
    Plug 'tpope/vim-fugitive'
    Plug 'mhinz/vim-signify'

    "NCM2 Autocomplete
        Plug 'ncm2/ncm2'
        Plug 'roxma/nvim-yarp'
        Plug 'roxma/vim-hub-neovim-rpc'

        Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'}
        Plug 'phpactor/ncm2-phpactor'
        Plug 'ncm2/ncm2-bufword'
        Plug 'ncm2/ncm2-path'
    
    "Autocomplete even more

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

    "Snippets
        " Track the engine.
        Plug 'SirVer/ultisnips'
        " Snippets are separated from the engine. Add this if you want them:
        Plug 'honza/vim-snippets'
        " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
        let g:UltiSnipsExpandTrigger="<C-e>"
        let g:UltiSnipsJumpForwardTrigger="<c-b>"
        let g:UltiSnipsJumpBackwardTrigger="<c-z>"
        " If you want :UltiSnipsEdit to split your window.
        let g:UltiSnipsEditSplit="vertical"

    "Outline
        Plug 'majutsushi/tagbar'
        nmap <F8> :TagbarToggle<CR>

    "Documentation
        Plug 'tobyS/vmustache'
        Plug 'https://github.com/tobyS/pdv'
        " let g:pdv_template_dir= $HOME ."/.vim/
        nnoremap <buffer> <C-p> :call pdv#DocumentWithSnip()<CR>

    call plug#end()


"NCM2
    let g:python3_host_prog='/usr/bin/python3'
    autocmd BufEnter * call ncm2#enable_for_buffer()
    set completeopt=noinsert,menuone,noselect
    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    set shortmess+=c
    inoremap <c-c> <ESC>
    noremap <silent> <expr> <CR> (pumvisible() ? ncm2_ultisnips#expand_or("\<CR>", 'n') : "\<CR>")


"Ctags
    au BufWritePost *.php silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &


"nvim-miniyank
    map p <Plug>(miniyank-autoput)
    map P <Plug>(miniyank-autoPut)
    map <leader>p <Plug>(miniyank-startput)
    map <leader>P <Plug>(miniyank-startPut)

"vim-project
    call project#rc("~/development")
    Project "Bruno\ Fontes/DicionarioCC\ -\ Site/", 'Dicionarios.cc'

"php-cs-fixer
    " MUST HAVE Composer and php_cs_fixer installed GLOBALLY 
    " before installing the plugin
    let g:php_cs_fixer_php_path = "/usr/bin/php"
    let g:php_cs_fixer_rules = "@PSR2"
    autocmd BufWritePost *.php silent! call php_cs_fixer#fix(@%, 0)

"Neomake
	" When writing a buffer (no delay), and on normal mode changes (after 750ms).
	call neomake#configure#automake('nw', 750)

"PhpActor
    let g:phpactor_executable = '/usr/local/bin/phpactor'
    let g:phpactorOmniError = v:true
    " context-aware menu with all functions (ALT-m)
    nnoremap <m-m> :call phpactor#ContextMenu()<cr>
    nnoremap gd :call phpactor#GotoDefinition()<CR>
    nnoremap gr :call phpactor#FindReferences()<CR>
