function! helpers#defx#setup() abort
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

function! helpers#defx#open(...) abort
    let opts = get(a:, 1, {})
    let path = getcwd()

    let args = " -direction=topleft -winwidth=37 -split=vertical -show-ignored-files -listed -resume"

    if has_key(opts, 'find_current_file')
        if &filetype == 'defx'
            return
        endif

        let g:defx_opened = 1

        call execute(printf('Defx %s -search=%s %s', args, expand('%:p'), path))

        return
    endif

    if @% != "" && @% !~ "Startify" && &filetype != 'defx' && !g:defx_opened
        let g:defx_opened = 1

        call execute(printf('Defx %s -search=%s %s', args, expand('%:p'), path))
    else
        let g:defx_opened = !g:defx_opened

        call execute(printf('Defx -toggle %s %s', args, path))
    endif
endfunction

function! helpers#defx#mappings() abort
    nnoremap <silent><buffer>m :call <SID>menu()<CR>
    nnoremap <silent><buffer><expr> o <SID>toggle()
    nnoremap <silent><buffer><expr> O defx#do_action('open_tree_recursive')
    nnoremap <silent><buffer><expr> <CR> <SID>toggle()
    nnoremap <silent><buffer><expr> C defx#is_directory() ? defx#do_action('multi', ['open', 'change_vim_cwd']) : 'C'
    nnoremap <silent><buffer><expr> s defx#do_action('open', 'botright vsplit')
    nnoremap <silent><buffer><expr> R defx#do_action('redraw')
    nnoremap <silent><buffer><expr> U defx#do_action('multi', [['cd', '..'], 'change_vim_cwd'])
    nnoremap <silent><buffer><expr> H defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> yy defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> q defx#do_action('quit')
endfunction

function! Root(path) abort
    return fnamemodify(a:path, ':t')
endfunction

function! s:menu() abort
    let actions = ['new_multiple_files', 'move', 'remove', 'rename', 'copy', 'paste', 'redraw']
    let selection = confirm('Action?', "&New file/directory\nMove\n&Delete\n&Rename\n&Copy\n&Paste")

    silent exe 'redraw'

    return feedkeys(defx#do_action(actions[selection - 1]))
endfunction

function s:toggle() abort
    if defx#is_directory()
        return defx#do_action('open_or_close_tree')
    endif

    return defx#do_action('drop')
endfunction

