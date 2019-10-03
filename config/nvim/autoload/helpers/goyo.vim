function! helpers#goyo#enter()
    silent !tmux set status off
    let g:goyo_entered = 1
    set norelativenumber
    set noshowmode
    set noshowcmd
    set scrolloff=999
    set wrap
    setlocal conceallevel=2
endfunction

function! helpers#goyo#leave()
    silent !tmux set status on
    let g:goyo_entered = 0
    set relativenumber
    set showmode
    set showcmd
    set scrolloff=5
    set nowrap
    setlocal conceallevel=0
endfunction
