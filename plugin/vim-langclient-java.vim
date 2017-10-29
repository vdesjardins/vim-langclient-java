
let s:is_win = has('win32') || has('win64')

if !exists("g:LanguageClient_serverCommands")
    let g:LanguageClient_serverCommands = {}
endif

let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h')

if s:is_win
  let g:LanguageClient_serverCommands["java"] = [s:path . '/../java-langserver.bat']
else
  let g:LanguageClient_serverCommands["java"] = [s:path . '/../java-langserver.sh']
endif


