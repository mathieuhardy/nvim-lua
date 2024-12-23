" Wrapping
function! mapping#toggle()
    if !exists('g:mapping_uid')
        return
    endif

    function! s:add(text)
        call g:quickmenu#append(a:text, '')
    endfunction

    call g:quickmenu#current(g:mapping_uid)

    let g:quickmenu_options = 'T'
    let g:quickmenu_max_width = 100

    call g:quickmenu#reset()
    call g:quickmenu#header('Mapping')

    call s:add('? : show this menu')

    call s:add('# Navigation')
    call s:add('Shift-v        : visual block mode')
    call s:add('Ctrl-s         : search symbol under cursor')
    call s:add('Ctrl-backspace : back to previous file after jump')
    call s:add('Ctrl-p         : show previous symbol search')

    if has('macunix')
        call s:add('Ctrl-<arrow> : navigate through buffers')
    else
        call s:add('Alt-<arrow> : navigate through buffers')
        call s:add('Ctrl-j      : jump to file under cursor')
        call s:add('Ctrl-s      : search symbol under cursor')
    endif

    if !has('macunix')
        call s:add('\\                 : open previous buffer')
        call s:add('Ctrl-<PageUp/Down> : navigate through tabs')
    endif

    call s:add('# Text control')
    call s:add('Ctrl-c : copy')
    call s:add('Ctrl-v : paste')
    call s:add('Ctrl-x : cut')
    call s:add('')
    call s:add('Ctrl-k : (un)comment')
    call s:add('Ctrl-o : sort block')
    call s:add('+/-    : (in/de)crement value under cursor')

    call s:add('# F-keys')
    call s:add('F1       : save buffer')
    call s:add('F2       : close buffer')
    call s:add('F3       : horizontal split')
    call s:add('F4       : vertical split')
    call s:add('F5       : N.A.')
    call s:add('F6       : N.A.')
    call s:add('F7       : clear highlight')
    call s:add('F8       : N.A.')
    call s:add('F9       : show/hide symbols list')
    call s:add('F10      : show/hide file explorer')
    call s:add('F11      : show/hide invisible characters')
    call s:add('F12      : enter/leave distraction free mode')
    call s:add('Ctrl-F12 : enter/leave limited view mode')

    call s:add('# Others')
    call s:add('Ctrl-d : delete hidden buffers')
    call s:add('Ctrl-b : git blame')
    call s:add('Ctrl-f : search files')
    call s:add('Ctrl-m : toggle Markdown preview')

    if !has('macunix')
        call s:add('Ctrl-<Space> : open completion menu')
    endif

    :call g:quickmenu#toggle(g:mapping_uid)
endfunction
