" Open session
function! sessions#load(name)
    if !exists('g:sessions_dir') || empty(g:sessions_dir)
        return
    endif

    if empty(a:name)
        return
    endif

    let l:file = g:sessions_dir . '/' . a:name . '.vim'

    if filereadable(l:file)
        execute 'source ' . l:file

        call sessions#root()

        if exists('*cscope#init')
            call cscope#init()
        endif
    endif
endfunction

" Set root directory
function! sessions#root()
    if !exists('g:session_root') || empty(g:session_root)
        return
    endif

    "let l:file = bufname("%")

    "if empty(l:file)
        execute 'cd ' . g:session_root
    "endif
endfunction
