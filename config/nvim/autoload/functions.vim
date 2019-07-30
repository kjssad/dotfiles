" load vim-plug if it does not exist in the dotfiles
let s:plugpath = expand('<sfile>:p:h') . '/plug.vim' " this is relative to this file, which is in autoload
function! functions#PlugLoad()
    if !filereadable(s:plugpath)
        if executable('curl')
            echom "Installing vim-plug at " . s:plugpath
            let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
            call system('curl -fLo ' . shellescape(s:plugpath) . ' --create-dirs ' . plugurl)
            if v:shell_error
                echom "Error downloading vim-plug. Please install it manually.\n"
                exit
            endif
        else
            echom "vim-plug not installed. Please install it manually or install curl.\n"
            exit
        endif
    endif
endfunction

" Window movement shortcuts
" move to the window in the direction shown, or create a new window
function! functions#WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction


" Check the highlight group used for words under cursor
" https://stackoverflow.com/questions/7893445
function! functions#SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction
