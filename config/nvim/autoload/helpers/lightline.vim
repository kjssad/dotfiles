function! helpers#lightline#gitBranch()
    return &filetype == 'coc-explorer'? '' : get(g:, 'coc_git_status', '')
endfunction

function! helpers#lightline#cocDiagnostics() abort
    if &filetype == 'coc-explorer' || &diff
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

    return join(msgs, ' ')
endfunction

function! helpers#lightline#cocStatus() abort
    return &filetype == 'coc-explorer' || &diff? '' : get(g:, 'coc_status', '')
endfunction

function! helpers#lightline#fileName() abort
    if &filetype == 'coc-explorer'
        return ''
    endif

    let filename = winwidth(0) > 84? expand('%') : expand('%:t')
    let modified = &modified ? ' +' : ''

    if &diff
        return filename . modified
    end

    return WebDevIconsGetFileTypeSymbol() . ' ' . fnamemodify(filename, ":~:.") . modified
endfunction

function! helpers#lightline#shiftWidth()
    if &filetype == 'coc-explorer' || &diff
        return ''
    endif

    if &expandtab == 1
        return 'Spaces: ' . &shiftwidth
    else
        return 'Tabs: ' . &shiftwidth
    endif
endfunction

function! helpers#lightline#fileFormat()
    " only show the file format if it's not 'unix'
    let format = &fileformat == 'unix' ? '' : &fileformat . ' '
    return winwidth(0) > 70? format . WebDevIconsGetFileFormatSymbol() : ''
endfunction

function! helpers#lightline#fileEncoding()
    " only show the file encoding if it's not 'utf-8'
    return &fileencoding == 'utf-8'? '' : &fileencoding
endfunction
