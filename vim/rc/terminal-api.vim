func! Tapi_Cd(bufnum, directory)
  cd `=a:directory`
endfunc

func! Tapi_Tab_Edit(bufnum, file)
  tabnew `=a:file`
endfunc

func! Tapi_Tab_New(bufnum, ...)
  tabnew
endfunc
