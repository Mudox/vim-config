" go filetype setting.
function! s:GoRun( args )
    " save & lcd to current python script file path.
    w
    lcd %:p:h

    if has('win32') || has('win64')
            let l:go_path = 'go'
            let l:exeString = l:go_path . ' run ' . escape(expand('%'), ' \') . ' ' . a:args
    elseif has('unix')
            let l:go_path = 'go'
            let l:exeString = l:go_path . ' run ' . escape(expand('%'), ' \') . ' ' . a:args
    elseif has('mac') || has('macunix')
            echoerr 'go run on Mac OS not implemented!'
    else
        echohl ErrorMsg | echo "Oops! Unknown sysinfo" | echohl NONE
    endif

    echohl Underlined | echo l:exeString | echohl NONE

    echo vimproc#system2(l:exeString)
endfunction

command! -buffer -nargs=* GoRunWithArgs call s:GoRun(<q-args>)

nnoremap <buffer> <Enter>r :GoRunWithArgs<Space>
