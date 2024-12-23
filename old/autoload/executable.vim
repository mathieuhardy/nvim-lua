" Detect executable files
function! executable#detect()
    if getline(1) =~ "^#!"
        if getline(1) =~ "/bin/"
            silent !chmod a+x <afile>
        endif

        if getline(1) =~ "usr/bin/env"
            silent !chmod a+x <afile>
        endif
    endif
endfunction
