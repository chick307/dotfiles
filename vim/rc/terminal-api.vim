func! Tapi_Tab_Edit(bufnum, file)
  tabnew `=a:file`
endfunc

func! Tapi_Tab_New(bufnum, ...)
  tabnew
endfunc
