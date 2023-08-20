function! utils#SplitExistsForFile(filename) abort
  let l:buf_num = bufnr(a:filename)
  return l:buf_num != -1 && bufwinnr(l:buf_num) != -1
endfunction

function! utils#ChangeToSplitWithFile(filename) abort
  let l:buf_num = bufnr(a:filename)
  let l:win_num = bufwinnr(l:buf_num)

  if l:buf_num != -1 && l:win_num != -1
    execute l:win_num . "wincmd w"
  else
    echoerr "Split with file not found."
  endif
endfunction
