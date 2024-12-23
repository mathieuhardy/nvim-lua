" Delete all hidden buffers
function! buffers#clean()
    let list=[]

    call map(range(1, tabpagenr('$')), 'extend(list, tabpagebuflist(v:val))')

    let l:list = filter(
        \ range(1, bufnr('$')),
        \ 'bufexists(v:val) && index(list, v:val)==-1')

    for buf in l:list
        silent execute 'bwipeout' buf
    endfor

    echom bufnr('$') . ' buffer(s) wiped out'
endfunction
