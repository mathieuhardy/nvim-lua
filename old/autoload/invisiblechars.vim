" Toggle invisible characters
:function! invisiblechars#toggle(...)
    let l:disabled = 0
    let l:enabled = 1

    " Init
    if !exists("g:ic_toggle")
        let g:ic_toggle=l:disabled
    endif

    if !exists("g:max_width")
        let g:max_width=80
    endif

    if a:0 == 1 && (a:1 == l:enabled || a:1 == l:disabled)
        " Set value
        let g:ic_toggle=a:1
    else
        " Toggle value
        let g:ic_toggle=!g:ic_toggle
    endif

    " Apply configuration
    if g:ic_toggle == l:enabled
        set list
        let &colorcolumn=g:max_width+1
    else
        set nolist
        set colorcolumn=
    endif
:endfunction
