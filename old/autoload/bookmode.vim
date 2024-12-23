" Toggle book mode
:function! bookmode#toggle(...)
    let l:disabled = 0
    let l:enabled = 1

    " Init
    if !exists("g:bm_toggle")
        let g:bm_toggle=l:disabled
    endif

    if !exists("g:max_width")
        let g:max_width=80
    endif

    if a:0 == 1 && (a:1 == l:enabled || a:1 == l:disabled)
        " Set value
        let g:bm_toggle=a:1
    else
        " Toggle value
        let g:bm_toggle=!g:bm_toggle
    endif

    " Apply configuration
    if g:bm_toggle == l:enabled
        " Wrapping
        :silent! let textwidth=g:max_width
        :silent! set linebreak
        :silent! set wrapmargin=1
        :silent! set spell
        :silent! setlocal spell spelllang=fr_fr
        :silent! set formatoptions+=t
        :silent! set formatoptions-=l
        :silent! set formatoptions+=m
        :silent! set formatoptions+=n
        :let &formatlistpat='^\s*\[[a-zA-Zа-яА-Я0-9_]\+\]:\s*'
        :let &formatlistpat.='\|'
        :let &formatlistpat.='^\s*[-–+oо*•]\s\+'

        " Auto-format
        :augroup BookAutoWrite
            :autocmd BufWrite * call FormatInternal()
        :augroup END

        " Abbreviations
        :silent! iabbrev -- —
        :silent! iabbrev oe œ
        :silent! iabbrev << «
        :silent! iabbrev >> »

        " Distraction-free mode
        :silent! let b:cursorword=0
        :silent! ScrollViewDisable
        :silent! Goyo
        :silent! Limelight
    else
        " Wrapping
        :silent! set textwidth=0
        :silent! set wrapmargin=0
        :silent! set nospell
        :silent! set formatoptions-=t
        :silent! set formatoptions+=l
        :silent! set formatoptions-=m

        " Auto-format
        :silent! autocmd! BookAutoWrite BufWrite *

        " Abbreviations
        :silent! unabbreviate --
        :silent! unabbreviate oe
        :silent! unabbreviate <<
        :silent! unabbreviate >>

        " Distraction-free mode
        :silent! Goyo!
        :silent! Limelight!
        :silent! ScrollViewEnable
        :silent! let b:cursorword=1
    endif
:endfunction

function! FormatInternal()
    let w:v = winsaveview()
    silent normal ggvGgq
    call winrestview(w:v)
endfunction
