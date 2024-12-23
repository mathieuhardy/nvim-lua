function! folding#toggle(...)
    if a:0 >= 1
        return s:Folding(a:1)
    else
        return s:Folding()
    endif
endfunction

" Simple fold text method
function! s:SimpleFoldText()
    return getline(v:foldstart).' '
endfunction

" Folding toggler
function! s:Folding(...)
    let l:disabled = 0
    let l:enabled = 1

    " Init
    if !exists("g:fo_toggle")
        let g:fo_toggle=l:disabled
    endif

    if a:0 == 1 && (a:1 == l:enabled || a:1 == l:disabled)
        " Set value
        let g:fo_toggle=a:1
    else
        " Toggle value
        let g:fo_toggle=!g:fo_toggle
    endif

    " Apply configuration
    if g:fo_toggle == l:enabled
        set foldenable                                     " turn on folding
        set foldmarker={,}                                 " fold C style code (only use this as default if you use a high foldlevel)
        set foldmethod=marker                              " fold on the marker
        set foldlevel=100                                  " don't autofold anything (but I can still fold manually)
        set foldopen=block,hor,mark,percent,quickfix,tag   " what movements open folds
        set foldtext=s:SimpleFoldText()                    " Custom fold text function (cleaner than default)

        " Map the <Space> key to toggle a selected fold opened/closed.
        "nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
        "vnoremap <Space> zf

        " Automatically save and load folds
        "autocmd BufWinLeave *.* mkview
        "autocmd BufWinEnter *.* silent loadview"
    else
        set nofoldenable
    endif
endfunction
