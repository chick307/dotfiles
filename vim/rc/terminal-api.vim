func! Tapi_Cd(bufnum, arglist)
  cd a:arglist[0]
endfunc

func! Tapi_Tab_Edit(bufnum, arglist)
  tabnew a:arglist[0]
endfunc

func! Tapi_Tab_New(bufnum, ...)
  tabnew
endfunc
