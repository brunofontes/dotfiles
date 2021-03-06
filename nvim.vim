" NeoVim config file
"
" The original file path is: ~/.config/nvim/init.vim
"

"set termguicolors


" Enable use of local nvim configuration files
" Just save a file in a folder named .nvimrc with
" my custom configuration
set exrc
set secure

"My personalizations
    imap jk <Esc>

    "Hide search highlight with enter key
    nnoremap <CR> :noh<CR><CR>
    map <C-b> :NERDTreeToggle<CR>
    map <C-g> :Gstatus<CR>
    map <C-t> :tabnew<CR>:FZF<CR>
    let g:startify_change_to_vcs_root = 1
    "nmap <A-'> <C-w><C-w>
    nmap <A-'> :bn<CR>
    nmap <Tab> :b 
    nmap <C-L> A;<esc>
    imap <C-L> <esc>A;
    tnoremap jk <C-\><C-n>
    nnoremap <NL> i<CR><ESC>

    set number
    set relativenumber

    colorscheme ron
    syntax on
    " Set search highlight colors
    hi Search		ctermbg=darkblue ctermfg=yellow cterm=none 


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

" =====================================================================================
                " Conquer of Completions - alternative to IntelliJ
                
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " Use tab for trigger completion with characters ahead and navigate.
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
    " position. Coc only does snippet and additional edit on confirm.
    " <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
    if exists('*complete_info')
      inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
    else
      inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    endif
" =====================================================================================

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
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

    "GIT inside VIM
    Plug 'tpope/vim-fugitive'
    Plug 'mhinz/vim-signify'

    
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


    "FZF - Opening any file under the current dir with <C-p>
        nmap <C-p> :FZF<CR>
        nmap <C-h> :History<CR>
        let $FZF_DEFAULT_COMMAND='find . -path "./.git" -prune -o -path "./.vagrant" -prune -o -path "./node_modules" -prune -o -print'



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
        " nnoremap <buffer> <C-p> :call pdv#DocumentWithSnip()<CR>

    call plug#end()


"Ctags
    au BufWritePost *.php silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &
    set tags=./.git/tags;/


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


