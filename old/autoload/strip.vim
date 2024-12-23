" Delete trailing whitespaces
function! strip#run()
    " Save last search and cursor position
    let _s = @/
    let _l = line(".")
    let _c = col(".")

    " Strip
    %s/\s\+$//ge

    " Restore context
    let @/ = _s
    call cursor(_l, _c)
endfunction
