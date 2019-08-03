" .vimrc / init.vim
" The following vim/neovim configuration works for both Vim and NeoVim

" ensure vim-plug is installed and then load it
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEntr * PlugInstall --sync | source $MYVIMRC
endif

call functions#PlugLoad()
call plug#begin('~/.config/nvim/plugged')

" General {{{
    set autoread
    set hidden

    set noswapfile
    set nobackup
    set nowritebackup

    set smartindent

    set history=1000
    set textwidth=0 " disable hard wrapping

    set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
    set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

    if (has('nvim'))
        set inccommand=nosplit
    endif

    set backspace=indent,eol,start
    set clipboard=unnamedplus

    if has('mouse')
        set mouse=a
    endif

    " Error bells
    set noerrorbells
    set visualbell

    " Folds
    set nofoldenable " don't fold by default
    set foldlevelstart=99
    set foldmethod=marker

    " Searching
    set ignorecase
    set smartcase
    set hlsearch
    set incsearch

    " Splits
    set splitbelow
    set diffopt+=vertical

    " Tab control
    set expandtab " insert spaces for <Tab>
    set smarttab " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
    set tabstop=4 " the visible width of tabs
    set softtabstop=4 " edit as if the tabs are 2 characters
    set shiftwidth=4 " number of spaces to use for indent
    set shiftround

    " Wrapping
    set nowrap " disable soft wrap
    set linebreak " wrap at a word boundary

    set wildmenu " enhanced command line completion
    set wildmode=list:longest " complete files like a shell

    set magic " Set magic on, for regex

    set nolazyredraw

    set updatetime=300
    set shortmess+=c

    set t_vb=
    set tm=500
" }}}

" Appearance {{{
    set cmdheight=2 " number of screen lines for the command-line
    set cursorline " highlight current line
    set laststatus=2 " show the status line all the time
    set noshowmode " don't show which mode is on the last line
    set number " show line numbers
    set relativenumber " show relative numbers
    set scrolloff=5 " lines to keep above and below cursor
    set showcmd " show incomplete commands
    set showmatch " show matching braces
    set signcolumn=yes " always show the signcolumn

    " toggle invisible characters
    set list
    set listchars=tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
    set showbreak=↪

    set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
    \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
    \,sm:block-blinkwait175-blinkoff150-blinkon175

    " enable 24 bit color support if supported
    if (has("termguicolors"))
        set termguicolors
    endif

    set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors
    set ttyfast " faster redrawing

    " Load colorschemes
    Plug 'kjssad/quantum.vim'

    " LightLine {{{
        Plug 'itchyny/lightline.vim'

        let g:lightline = {
        \   'colorscheme': 'quantum',
        \   'mode_map': {
        \       'n' : 'N',
        \       'i' : 'I',
        \       'R' : 'R',
        \       'v' : 'V',
        \       'V' : 'VL',
        \       "\<C-v>": 'VB',
        \       'c' : 'C',
        \       's' : 'S',
        \       'S' : 'SL',
        \       "\<C-s>": 'SB',
        \       't': 'T',
        \   },
        \   'active': {
        \       'left': [
        \           [ 'mode', 'paste' ],
        \           [ 'gitbranch' ],
        \           [ 'readonly', 'filetype', 'filename' ]
        \       ],
        \       'right': [
        \           [ 'fileformat', 'fileencoding' ],
        \           [ 'percent', 'lineinfo' ],
        \           [ 'diagnostic' ]
        \       ]
        \   },
        \   'component_function': {
        \       'fileencoding': 'LightlineFileEncoding',
        \       'filename': 'LightlineFileName',
        \       'fileformat': 'LightlineFileFormat',
        \       'filetype': 'LightlineFileType',
        \       'shiftwidth':  'LightLineFileShiftWidth',
        \       'gitbranch': 'LightlineGitBranch',
        \       'diagnostic': 'LightlineLanguageDiagnostic'
        \   },
        \   'tabline': {
        \       'left': [ [ 'tabs' ] ],
        \       'right': [ [ 'close' ] ]
        \   },
        \   'tab': {
        \       'active': [ 'filename', 'modified' ],
        \       'inactive': [ 'filename', 'modified' ],
        \   },
        \   'separator': { 'left': '', 'right': '' },
        \   'subseparator': { 'left': '', 'right': '' }
        \ }

        function! LightlineGitBranch()
            return expand('%:t') =~ 'NERD_tree'? '' : get(g:, 'coc_git_status', '')
        endfunction

        function! LightlineLanguageDiagnostic() abort
            if expand('%:t') =~ 'NERD_tree'
                return
            endif

            let info = get(b:, 'coc_diagnostic_info', {})

            let msgs = []

            if get(info, 'error', 0)
                call add(msgs, '✖ ' . info['error'])
            else
                call add(msgs, '✖ ' . 0)
            endif

            if get(info, 'warning', 0)
                call add(msgs, '⚠ ' . info['warning'])
            else
                call add(msgs, '⚠ ' . 0)
            endif

            return get(g:, 'coc_status', '') . '  ' . join(msgs, ' ')
        endfunction

        function! LightlineFileType()
            return expand('%:t') =~ 'NERD_tree'? '' : WebDevIconsGetFileTypeSymbol()
        endfunction

        function! LightlineFileName() abort
            let filename = winwidth(0) > 70? expand('%') : expand('%:t')
            if filename =~ 'NERD_tree'
                return ''
            endif
            let modified = &modified ? ' +' : ''
            return fnamemodify(filename, ":~:.") . modified
        endfunction

        function! LightLineFileShiftWidth()
            return 'Spaces: ' . &shiftwidth
        endfunction

        function! LightlineFileFormat()
            " only show the file format if it's not 'unix'
            let format = &fileformat == 'unix' ? '' : &fileformat . ' '
            return winwidth(0) > 70? format . WebDevIconsGetFileFormatSymbol() : ''
        endfunction

        function! LightlineFileEncoding()
            " only show the file encoding if it's not 'utf-8'
            return &fileencoding == 'utf-8'? '' : &fileencoding
        endfunction
    " }}}
" }}}

" Mappings {{{
    let mapleader = ','

    " remap esc
    inoremap jk <esc>

    " shortcut to save
    nmap <leader>, :w<cr>

    " set paste toggle
    set pastetoggle=<leader>v

    " edit ~/.config/nvim/init.vim
    map <leader>ev :e! ~/.config/nvim/init.vim<cr>

    " disable highlighting of current search until next search
    noremap <space> :nohlsearch<cr>

    " nnoremap <leader>c :set cursorline!<cr>
    " nnoremap <leader>l :set list!<cr>
    " nnoremap <leader>rn :set relativenumber!<cr>

    " activate spell-checking alternatives
    nmap ;s :set invspell spelllang=en<cr>

    " remove extra whitespace
    nmap <leader><space> :%s/\s\+$<cr>
    nmap <leader><space><space> :%s/\n\{2,}/\r\r/g<cr>

    " switch between current and last buffer
    nmap <leader>. <c-^>

    " enable . command in visual mode
    vnoremap . :normal .<cr>

    map <silent> <C-h> :call functions#WinMove('h')<cr>
    map <silent> <C-j> :call functions#WinMove('j')<cr>
    map <silent> <C-k> :call functions#WinMove('k')<cr>
    map <silent> <C-l> :call functions#WinMove('l')<cr>

    " scroll the viewport faster
    nnoremap <C-e> 3<C-e>
    nnoremap <C-y> 3<C-y>

    " don't exit visual mode after pressing > and <
    vnoremap > >gv
    vnoremap < <gv

    " helpers for dealing with other people's code
    nmap \t :set ts=4 sts=4 sw=4 noet<cr>
    nmap \s :set ts=4 sts=4 sw=4 et<cr>
    nmap \2t :set ts=2 sts=2 sw=2 noet<cr>
    nmap \2s :set ts=2 sts=2 sw=2 et<cr>

    " ripgrep
    nnoremap <leader>rg :Rg 

    " check the highlight group used for words under cursor
    nmap <F2> :call functions#SynStack()<cr>
" }}}

" AutoGroups {{{
    " file type specific settings
    augroup configgroup
        autocmd!
        " save all files on focus lost, ignoring warnings about untitled buffers
        autocmd FocusLost * silent! wa

        " make quickfix windows take all the lower section of the screen
        " when there are multiple windows open
        autocmd FileType qf wincmd J
        autocmd FileType qf nmap <buffer> q :q<cr>

        " Go to the last cursor location when a file is opened, unless this is a git commit
        au BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") && &filetype != "gitcommit" |
                \ execute("normal `\"") |
            \ endif
    augroup END

    augroup focusedwindow
        autocmd!
        autocmd BufEnter,FocusGained,InsertLeave * if expand('%:t') !~ 'NERD_tree' | set relativenumber | endif
        autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
    augroup END
" }}}

" Plugins {{{
    Plug 'AndrewRadev/splitjoin.vim' " single/multi line code handler: gS - split one line into multiple, gJ - combine multiple lines into one
    Plug 'sickill/vim-pasta' " context-aware paste
    Plug 'tpope/vim-abolish' " substitute, search, and abbreviate multiple variants of a word
    Plug 'tpope/vim-commentary' " easy commenting motions
    Plug 'tpope/vim-ragtag' " endings for html, xml, etc. - ehances surround
    Plug 'tpope/vim-repeat' " enables repeating other supported plugins with the . command
    Plug 'tpope/vim-sleuth' " detect indent style (tabs vs. spaces)
    Plug 'tpope/vim-surround' " mappings to easily delete, change and add such surroundings in pairs, such as quotes, parens, etc.
    Plug 'tpope/vim-unimpaired' " mappings which are simply short normal mode aliases for commonly used ex commands
    Plug 'tpope/vim-vinegar' " netrw helper
    Plug 'vim-scripts/matchit.zip' " extended % matching
    Plug 'wincent/ferret' " multi-file search

    " coc {{{
        Plug 'neoclide/coc.nvim', {'branch': 'release'}

        let g:coc_global_extensions = [
        \   'coc-pairs',
        \   'coc-elixir',
        \   'coc-git',
        \   'coc-highlight',
        \   'coc-snippets',
        \   'coc-emmet'
        \ ]

        autocmd CursorHold * silent call CocActionAsync('highlight')

        " trigger completion
        inoremap <silent><expr> <c-space> coc#refresh()

        " coc-git keymappings
        nmap [g <Plug>(coc-git-prevchunk)
        nmap ]g <Plug>(coc-git-nextchunk)
        nmap gs <Plug>(coc-git-chunkinfo)
        nmap gu :CocCommand git.chunkUndo<cr>

        " Use `[c` and `]c` to navigate diagnostics
        nmap <silent> [c <Plug>(coc-diagnostic-prev)
        nmap <silent> ]c <Plug>(coc-diagnostic-next)

        " Remap keys for gotos
        nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gy <Plug>(coc-type-definition)
        nmap <silent> gi <Plug>(coc-implementation)
        nmap <silent> gr <Plug>(coc-references)

        " rename
        nmap <silent> <leader>rn <Plug>(coc-rename)

        " Remap for format selected region
        xmap <leader>f  <Plug>(coc-format-selected)
        nmap <leader>f  <Plug>(coc-format-selected)
        xmap <leader>fb  <Plug>(coc-format)
        nmap <leader>fb  <Plug>(coc-format)

        " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
        xmap <leader>a  <Plug>(coc-codeaction-selected)
        nmap <leader>a  <Plug>(coc-codeaction-selected)

        " Remap for do codeAction of current line
        nmap <leader>ac  <Plug>(coc-codeaction)
        " Fix autofix problem of current line
        nmap <leader>qf  <Plug>(coc-fix-current)

        " Use K to show documentation in preview window
        nnoremap <silent> K :call <SID>show_documentation()<CR>

        function! s:show_documentation()
            if (index(['vim','help'], &filetype) >= 0)
                execute 'h '.expand('<cword>')
            else
                call CocAction('doHover')
            endif
        endfunction

        inoremap <silent><expr> <TAB>
            \ pumvisible() ? coc#_select_confirm() :
            \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

        inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

        function! s:check_back_space() abort
            let col = col('.') - 1
            return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        let g:coc_snippet_next = '<tab>'

        autocmd FileType nerdtree let b:coc_suggest_disable = 1
    " }}}

    " FZF {{{
        Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all --no-bash --no-fish' }
        Plug 'junegunn/fzf.vim'

        let g:fzf_layout = { 'down': '~25%' }

        if isdirectory(".git")
            " if in a git project, use :GFiles
            nmap <silent> <leader>t :GitFiles --cached --others --exclude-standard<cr>
        else
            " otherwise, use :FZF
            nmap <silent> <leader>t :FZF<cr>
        endif

        nmap <silent> <leader>s :GFiles?<cr>
        nmap <silent> <leader>r :Buffers<cr>
        nmap <silent> <leader>e :FZF<cr>

        nmap <leader><tab> <plug>(fzf-maps-n)
        xmap <leader><tab> <plug>(fzf-maps-x)
        omap <leader><tab> <plug>(fzf-maps-o)

        " Insert mode completion
        imap <c-x><c-k> <plug>(fzf-complete-word)
        imap <c-x><c-f> <plug>(fzf-complete-path)
        imap <c-x><c-j> <plug>(fzf-complete-file-ag)
        imap <c-x><c-l> <plug>(fzf-complete-line)

        nnoremap <silent> <Leader>C :call fzf#run({
        \   'source':
        \     map(split(globpath(&rtp, "colors/*.vim"), "\n"),
        \         "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"),
        \   'sink':    'colo',
        \   'options': '+m',
        \   'left':    30
        \ })<CR>

        command! FZFMru call fzf#run({
        \  'source':  v:oldfiles,
        \  'sink':    'e',
        \  'options': '-m -x +s', \  'down':    '40%'})

        command! -bang -nargs=* Find call fzf#vim#grep(
            \ 'rg --column --line-number --no-heading --follow --color=always '.<q-args>, 1,
            \ <bang>0 ? fzf#vim#with_preview('up:60%') : fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)
        command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('right:50%', '?'), <bang>0)
        command! -bang -nargs=? -complete=dir GitFiles
            \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview('right:50%', '?'), <bang>0)
    " }}}

    " IndentLine {{{
        Plug 'Yggdroot/indentLine'

        let g:indentLine_bufNameExclude = ['_.*', 'NERD_tree.*']
        let g:indentLine_bufTypeExclude = ['help', 'terminal']
        let g:indentLine_fileTypeExclude = ['markdown', 'json']
        let g:indentLine_char = '│'
        let g:indentLine_first_char = '│'
        let g:indentLine_showFirstIndentLevel=1

        let g:indentLine_setColors = 0
    " }}}

    " NERDTree {{{
        Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
        Plug 'Xuyuanp/nerdtree-git-plugin'
        Plug 'ryanoasis/vim-devicons'
        " Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

        let g:WebDevIconsOS = 'Linux'
        let g:WebDevIconsUnicodeDecorateFolderNodes = 1
        let g:DevIconsEnableFoldersOpenClose = 1
        let g:DevIconsEnableFolderExtensionPatternMatching = 1
        let NERDTreeMinimalUI=1
        let NERDTreeDirArrowExpandable = "\u00a0" " make arrows invisible
        let NERDTreeDirArrowCollapsible = "\u00a0" " make arrows invisible
        let NERDTreeNodeDelimiter = "\u263a" " smiley face

        " let s:elixir = "ab9df2"
        " let g:NERDTreeExtensionHighlightColor = {}
        " let g:NERDTreeExtensionHighlightColor['ex'] = s:elixir
        " let g:NERDTreeExtensionHighlightColor['exs'] = s:elixir

        " let g:NERDTreeSyntaxDisableDefaultExtensions = 1
        " let g:NERDTreeDisableExactMatchHighlight = 1
        " let g:NERDTreeDisablePatternMatchHighlight = 1
        " let g:NERDTreeSyntaxEnabledExtensions = ['html', 'js', 'css', 'md', 'exs', 'ex', 'cpp']

        augroup nerdtree
            autocmd!
            autocmd FileType nerdtree setlocal nolist " turn off whitespace characters
            " autocmd FileType nerdtree setlocal nocursorline " turn off line highlighting for performance
        augroup END

        " Toggle NERDTree
        function! ToggleNerdTree()
            if @% != "" && @% !~ "Startify" && (!exists("g:NERDTree") || (g:NERDTree.ExistsForTab() && !g:NERDTree.IsOpen()))
                :NERDTreeFind
            else
                :NERDTreeToggle
            endif
        endfunction

        " toggle nerd tree
        nmap <silent> <leader>k :call ToggleNerdTree()<cr>
        " find the current file in nerdtree without needing to reload the drawer
        nmap <silent> <leader>y :NERDTreeFind<cr>

        let NERDTreeShowHidden=1
        let g:NERDTreeIndicatorMapCustom = {
        \ "Modified"  : "!",
        \ "Staged"    : "+",
        \ "Untracked" : "?",
        \ "Renamed"   : "»",
        \ "Unmerged"  : "=",
        \ "Deleted"   : "_",
        \ "Dirty"     : "∗",
        \ "Clean"     : "`",
        \ 'Ignored'   : '~',
        \ "Unknown"   : "."
        \ }
    " }}}

    " Snippets {{{
        Plug 'honza/vim-snippets'
    " }}}

    " vim-bbye {{{
        Plug 'moll/vim-bbye'

        nmap <leader>b :Bdelete<cr>
    " }}}

    " vim-fugitive {{{
        Plug 'tpope/vim-fugitive'
        " Plug 'junegunn/gv.vim'
        " Plug 'sodapopcan/vim-twiggy'
        " Plug 'christoomey/vim-conflicted'

        nmap <silent> <leader>gs :Gstatus<cr>
        nmap <leader>ge :Gedit<cr>
        nmap <silent><leader>gr :Gread<cr>
        nmap <silent><leader>gb :Gblame<cr>
    " }}}

    " " vim-illuminate {{{
    "     "  automatically highlight the word under the cursor
    "     Plug 'RRethy/vim-illuminate'

    "     let g:Illuminate_ftblacklist = ['nerdtree']
    "     let g:Illuminate_delay = 500
    "     " let g:Illuminate_highlightUnderCursor = 0

    "     function! DisableIlluminate()
    "         set updatetime=0

    "         call illuminate#disable_illumination()

    "         return ''
    "     endfunction

    "     function! EnableIlluminate()
    "         set updatetime=300

    "         call illuminate#enable_illumination()
    "     endfunction

    "     vnoremap <silent> <expr> <SID>DisableIlluminate DisableIlluminate()
    "     nnoremap <silent> <script> v v<SID>DisableIlluminate
    "     nnoremap <silent> <script> V V<SID>DisableIlluminate
    "     nnoremap <silent> <script> <C-v> <C-v><SID>DisableIlluminate

    "     augroup illuminate_toggle
    "         autocmd CursorHold * call EnableIlluminate()
    "     augroup END
    " " }}}

    " Language-specific plugins {{{
        Plug 'sheerun/vim-polyglot'

        " Elixir {{{
            " Plug 'elixir-editors/vim-elixir'
        " }}}

        " Markdown support {{{
            " Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
        " }}}
    " }}}
" }}}

call plug#end()

" Colorscheme and final setup {{{
    set background=dark

    syntax on
    filetype plugin indent on

    colorscheme quantum
" }}}
