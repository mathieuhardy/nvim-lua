" Wrapping
function! wrapping#toggle(...)
    let l:disabled = 0
    let l:enabled = 1

    " Init
    if !exists("g:wr_toggle")
        let g:wr_toggle=l:disabled
    endif

    if a:0 == 1 && (a:1 == 2 || a:1 == l:enabled || a:1 == l:disabled)
        " Set value
        let g:wr_toggle=a:1
    else
        " Toggle value
        let g:wr_toggle=!g:wr_toggle
    endif

    " Apply configuration
    if g:wr_toggle == 2
        set wrap
        set linebreak
        let &textwidth=g:max_width
        let &colorcolumn=g:max_width
    elseif g:wr_toggle == l:enabled
        set wrap
        set linebreak
        set showbreak=>
    else
        set nowrap
    endif
endfunction
