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
    set wildmode=full " complete files like a shell

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
    set fillchars=fold:\ ,diff:
    set showbreak=↪

    set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
    \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
    \,sm:block-blinkwait175-blinkoff150-blinkon175

    " enable 24 bit color support if supported
    if (has("termguicolors"))
        set termguicolors
    endif

    function! Fold()
      return getline(v:foldstart) . ''
    endfunction
    set foldtext=Fold()

    set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors
    set ttyfast " faster redrawing

    " Load colorschemes
    Plug 'kjssad/quantum.vim'

    " LightLine {{{
        Plug 'itchyny/lightline.vim'

        let g:lightline = {
            \ 'colorscheme': 'quantum',
            \ 'mode_map': {
                \ 'n' : 'N',
                \ 'i' : 'I',
                \ 'R' : 'R',
                \ 'v' : 'V',
                \ 'V' : 'VL',
                \ "\<C-v>": 'VB',
                \ 'c' : 'C',
                \ 's' : 'S',
                \ 'S' : 'SL',
                \ "\<C-s>": 'SB',
                \ 't': 'T',
            \ },
            \ 'active': {
                \ 'left': [
                    \ [ 'mode', 'paste' ],
                    \ [ 'gitbranch' ],
                    \ [ 'readonly', 'filename' ]
                \ ],
                \ 'right': [
                    \ [ 'fileformat', 'fileencoding' ],
                    \ [ 'percent', 'lineinfo' ],
                    \ [ 'diagnostic', 'shiftwidth' ]
                \ ]
            \   },
            \ 'component_function': {
                \ 'fileencoding': 'helpers#lightline#fileEncoding',
                \ 'filename': 'helpers#lightline#fileName',
                \ 'fileformat': 'helpers#lightline#fileFormat',
                \ 'shiftwidth':  'helpers#lightline#shiftWidth',
                \ 'gitbranch': 'helpers#lightline#gitBranch',
                \ 'diagnostic': 'helpers#lightline#languageDiagnostic'
            \ },
            \ 'tabline': {
                \ 'left': [ [ 'tabs' ] ],
                \ 'right': [ [ 'close' ] ]
            \ },
            \ 'tab': {
                \ 'active': [ 'filename', 'modified' ],
                \ 'inactive': [ 'filename', 'modified' ],
            \ },
            \ 'tab_component_function': {
                \ 'filename': 'helpers#lightline#fileName'
            \ },
            \ 'separator': { 'left': '', 'right': '' },
            \ 'subseparator': { 'left': '', 'right': '' }
        \ }
    " }}}
" }}}

" Mappings {{{
    let mapleader = ','

    " remap esc
    inoremap jk <esc>

    " shortcut to save
    nmap <leader>, :w<CR>

    " shortcut to quit
    nmap <leader>` :q<CR>

    " set paste toggle
    set pastetoggle=<leader>v

    " edit ~/.config/nvim/init.vim
    map <leader>ev :e! ~/.config/nvim/init.vim<CR>

    " disable highlighting of current search until next search
    noremap <space> :nohlsearch<CR>

    " activate spell-checking alternatives
    nmap ;s :set invspell spelllang=en<CR>

    " remove extra whitespace
    nmap <leader><space> :%s/\s\+$<CR>
    nmap <leader><space><space> :%s/\n\{2,}/\r\r/g<CR>

    " switch between current and last buffer
    nmap <leader>. <c-^>

    " enable . command in visual mode
    vnoremap . :normal .<CR>

    map <silent> <C-h> <Plug>WinMoveLeft
    map <silent> <C-j> <Plug>WinMoveDown
    map <silent> <C-k> <Plug>WinMoveUp
    map <silent> <C-l> <Plug>WinMoveRight

    nmap <leader>z <Plug>Zoom

    " scroll the viewport faster
    nnoremap <C-e> 3<C-e>
    nnoremap <C-y> 3<C-y>

    " don't exit visual mode after pressing > and <
    vnoremap > >gv
    vnoremap < <gv

    " helpers for dealing with other people's code
    nmap \t :set ts=4 sts=4 sw=4 noet<CR>
    nmap \s :set ts=4 sts=4 sw=4 et<CR>
    nmap \2t :set ts=2 sts=2 sw=2 noet<CR>
    nmap \2s :set ts=2 sts=2 sw=2 et<CR>

    " check the highlight group used for words under cursor
    nmap <F2> :call functions#SynStack()<CR>
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
        autocmd FileType qf nmap <buffer> q :q<CR>

        " Go to the last cursor location when a file is opened, unless this is a git commit
        au BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") && &filetype != "gitcommit" |
                \ execute("normal `\"") |
            \ endif
    augroup END

    augroup focusedwindow
        autocmd!
        autocmd BufEnter,FocusGained,InsertLeave * if &filetype != "defx" && &filetype != "help" && &filetype != "qf" | set relativenumber | endif
        autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
    augroup END
" }}}

" Plugins {{{
    Plug 'AndrewRadev/splitjoin.vim' " single/multi line code handler: gS - split one line into multiple, gJ - combine multiple lines into one
    Plug 'sickill/vim-pasta' " context-aware paste
    Plug 'tpope/vim-abolish' " substitute, search, and abbreviate multiple variants of a word
    Plug 'tpope/vim-commentary' " easy commenting motions
    Plug 'tpope/vim-eunuch' " eunuch.vim: Helpers for UNIX 
    Plug 'tpope/vim-ragtag' " endings for html, xml, etc. - ehances surround
    Plug 'tpope/vim-repeat' " enables repeating other supported plugins with the . command
    Plug 'tpope/vim-sleuth' " detect indent style (tabs vs. spaces)
    Plug 'tpope/vim-surround' " mappings to easily delete, change and add such surroundings in pairs, such as quotes, parens, etc.
    Plug 'tpope/vim-unimpaired' " mappings which are simply short normal mode aliases for commonly used ex commands
    Plug 'vim-scripts/matchit.zip' " extended % matching
    Plug 'wincent/ferret' " multi-file search

    " coc {{{
        Plug 'neoclide/coc.nvim', {'branch': 'release'}

        let g:coc_global_extensions = [
            \ 'coc-pairs',
            \ 'coc-elixir',
            \ 'coc-git',
            \ 'coc-highlight',
            \ 'coc-snippets',
            \ 'coc-emmet',
            \ 'coc-json'
            \ ]

        augroup coc
            autocmd CursorHold * silent call CocActionAsync('highlight')
            autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
        augroup END

        " trigger completion
        inoremap <silent><expr> <c-space> coc#refresh()

        " coc-git keymappings
        nmap [g <Plug>(coc-git-prevchunk)
        nmap ]g <Plug>(coc-git-nextchunk)
        nmap gb <Plug>(coc-git-chunkinfo)
        nmap gs :CocCommand git.chunkStage<CR>
        nmap gu :CocCommand git.chunkUndo<CR>

        " Use `[c` and `]c` to navigate diagnostics
        nmap <silent> [c <Plug>(coc-diagnostic-prev)
        nmap <silent> ]c <Plug>(coc-diagnostic-next)

        " Remap keys for gotos
        nmap <silent> gf <Plug>(coc-definition)
        nmap <silent> gl <Plug>(coc-declaration)
        nmap <silent> gt <Plug>(coc-type-definition)
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

        nnoremap <expr><C-n> coc#util#has_float() ? coc#util#float_scroll(1) : "\<C-n>"
        nnoremap <expr><C-p> coc#util#has_float() ? coc#util#float_scroll(0) : "\<C-p>"

        inoremap <silent><expr> <TAB>
            \ pumvisible() ? coc#_select_confirm() :
            \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

        inoremap <silent><expr> <CR> "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

        function! s:check_back_space() abort
            let col = col('.') - 1
            return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        let g:coc_snippet_next = '<tab>'
    " }}}

    " FZF {{{
        Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all --no-bash --no-fish' }
        Plug 'junegunn/fzf.vim'

        let g:fzf_layout = { 'down': '~25%' }

        if isdirectory(".git")
            " if in a git project, use :GFiles
            nmap <silent> <leader>t :GitFiles --cached --others --exclude-standard<CR>
        else
            " otherwise, use :FZF
            nmap <silent> <leader>t :FZF<CR>
        endif

        nmap <silent> <leader>s :GFiles?<CR>
        nmap <silent> <leader>r :Buffers<CR>
        nmap <silent> <leader>e :FZF<CR>

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

        augroup fzf
            autocmd!
            autocmd  FileType fzf set laststatus=0 noruler
            \| autocmd BufLeave <buffer> set laststatus=2 ruler
        augroup END

        command! FZFMru call fzf#run({
            \ 'source':  v:oldfiles,
            \ 'sink':    'e',
            \ 'options': '-m -x +s', \  'down':    '40%'})

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
        let g:indentLine_char = '│'
        let g:indentLine_fileTypeExclude = ['markdown', 'json', 'defx']
        let g:indentLine_first_char = '│'
        let g:indentLine_setColors = 0
        let g:indentLine_showFirstIndentLevel=1
    " }}}

    " Defx {{{
        Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
        Plug 'kristijanhusak/defx-icons'
        Plug 'kristijanhusak/defx-git'
        Plug 'ryanoasis/vim-devicons'

        let s:defxIsOpen = 0

        augroup defx.nvim
            autocmd!
            autocmd BufEnter,FocusGained * if &filetype == "defx" | match Defx_indent /│/ | endif
            autocmd FileType defx match Defx_indent /│/
            autocmd FileType defx call s:defx_mappings()
            autocmd VimEnter * call s:setup_defx()
        augroup END

        " toggle defx
        nnoremap <silent><Leader>k :call <sid>defx_open()<CR>
        " find the current file in defx
        nnoremap <silent><Leader>y :call <sid>defx_open({ 'find_current_file': v:true })<CR>

        function! Root(path) abort
          return fnamemodify(a:path, ':t')
        endfunction

        function! s:setup_defx() abort
            call defx#custom#source('file', {
                \ 'root': 'Root',
                \})

            call defx#custom#option('_', {
                \ 'columns': 'mark:indent:icons:filename:git',
                \ 'root_marker': ' ',
                \ })

            call defx#custom#column('git', 'indicators', {
                \ 'Modified'  : 'M',
                \ 'Staged'    : 'S',
                \ 'Untracked' : 'U',
                \ 'Renamed'   : 'R',
                \ 'Unmerged'  : 'G',
                \ 'Deleted'   : 'D',
                \ 'Ignored'   : 'I',
                \ 'Unknown'   : '?',
                \ 'Dirty'     : '●'
                \ })

            call defx#custom#column('indent', {
                \ 'indent': '│',
                \ })

            call defx#custom#column('filename', {
                \ 'min_width': 33,
                \ 'max_width': 33,
                \ 'root_marker_highlight': 'Ignore',
                \ })

            call defx#custom#column('mark', {
                \ 'readonly_icon': '',
                \ })
        endfunction

        function! s:defx_open(...) abort
            let l:opts = get(a:, 1, {})
            let l:path = getcwd()

            let l:args = " -direction=topleft -winwidth=37 -split=vertical -show-ignored-files -listed -resume"

            if has_key(l:opts, 'find_current_file')
                if &filetype ==? 'defx'
                    return
                endif

                let s:defxIsOpen = 1

                call execute(printf('Defx %s -search=%s %s', l:args, expand('%:p'), l:path))

                return
            endif

            if @% != "" && @% !~ "Startify" && &filetype != 'defx' && s:defxIsOpen != 1
                let s:defxIsOpen = 1

                call execute(printf('Defx %s -search=%s %s', l:args, expand('%:p'), l:path))
            else
                let s:defxIsOpen = s:defxIsOpen ==# 0? 1 : 0

                call execute(printf('Defx -toggle %s %s', l:args, l:path))
            endif
        endfunction

        function! s:DefxMenu() abort
            let l:actions = ['new_multiple_files', 'move', 'remove', 'rename', 'copy', 'paste', 'redraw']
            let l:selection = confirm('Action?', "&New file/directory\nMove\n&Delete\n&Rename\n&Copy\n&Paste")
            silent exe 'redraw'

            return feedkeys(defx#do_action(l:actions[l:selection - 1]))
        endfunction

        function s:ToggleDefx() abort
            if defx#is_directory()
                return defx#do_action('open_or_close_tree')
            endif
            return defx#do_action('drop')
        endfunction

        function! s:defx_mappings() abort
            nnoremap <silent><buffer>m :call <sid>DefxMenu()<CR>
            nnoremap <silent><buffer><expr> o <sid>ToggleDefx()
            nnoremap <silent><buffer><expr> O defx#do_action('open_tree_recursive')
            nnoremap <silent><buffer><expr> <CR> <sid>ToggleDefx()
            nnoremap <silent><buffer><expr> C defx#is_directory() ? defx#do_action('multi', ['open', 'change_vim_cwd']) : 'C'
            nnoremap <silent><buffer><expr> s defx#do_action('open', 'botright vsplit')
            nnoremap <silent><buffer><expr> R defx#do_action('redraw')
            nnoremap <silent><buffer><expr> U defx#do_action('multi', [['cd', '..'], 'change_vim_cwd'])
            nnoremap <silent><buffer><expr> H defx#do_action('toggle_ignored_files')
            nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select') . 'j'
            nnoremap <silent><buffer><expr> yy defx#do_action('yank_path')
            nnoremap <silent><buffer><expr> q defx#do_action('quit')
        endfunction
    " }}}"

    " Snippets {{{
        Plug 'honza/vim-snippets'
    " }}}

    " vim-bbye {{{
        Plug 'moll/vim-bbye'

        nmap <leader>b :Bdelete<CR>
    " }}}

    " vim-fugitive {{{
        Plug 'tpope/vim-fugitive'
        " Plug 'junegunn/gv.vim'
        " Plug 'sodapopcan/vim-twiggy'
        " Plug 'christoomey/vim-conflicted'

        nmap <silent> <leader>gs :Gstatus<CR>
        nmap <leader>ge :Gedit<CR>
        nmap <silent><leader>gr :Gread<CR>
        nmap <silent><leader>gb :Gblame<CR>
    " }}}

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

    hi def link Defx_filename_3_root Structure
    hi def link Defx_filename_3_parent_directory Constant
    hi def link Defx_git_4_Dirty Comment
    hi link DefxIconsOpenedTreeIcon Structure
    hi link DefxIconsNestedTreeIcon Structure
    hi link DefxIconsClosedTreeIcon Structure
    hi link DefxIconsParentDirectory Keyword
    hi link Defx_indent Conceal
    hi Defx_git_4_Untracked guifg=#87DE74 gui=bold
    hi Defx_git_4_Renamed guifg=#FFD866 gui=bold
    hi Defx_git_4_Modified guifg=#FFD866 gui=bold
    hi Defx_git_4_Unmerged guifg=#EB5368 gui=bold
    hi Defx_git_4_Deleted guifg=#EB5368 gui=bold
    hi Defx_git_4_Staged guifg=#75BFFF gui=bold
" }}}
