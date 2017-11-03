if exists('g:langclient_java_loaded') || &cp
  finish
endif

let g:langclient_java_loaded = 1

if !exists("g:LanguageClient_serverCommands")
    let g:LanguageClient_serverCommands = {}
endif

if !exists("g:langclient_java_storage_workspace")
  let g:langclient_java_storage_workspace = tempname()
endif

if !exists("g:langclient_java_exec")
  let g:langclient_java_exec = 'java'
endif

let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h')
let s:project_path = getcwd()


if !exists("g:langclient_java_xmx")
  let g:langclient_java_xmx = "1G"
endif

function! s:StartJavaLSP()
  let s:server_cmd = [
        \ g:langclient_java_exec,
        \ "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        \ "-Dosgi.bundles.defaultStartLevel=4",
        \ "-Declipse.product=org.eclipse.jdt.ls.core.product",
        \ "-noverify",
        \ "-Xmx" . g:langclient_java_xmx,
        \ "-XX:+UseG1GC",
        \ "-XX:+UseStringDeduplication",
        \ "-jar", s:path . "/../eclipse/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_1.4.0.v20161219-1356.jar",
        \ "-configuration", s:path . "/../eclipse/org.eclipse.jdt.ls.product/target/repository/config_linux",
        \ "-data", g:langclient_java_storage_workspace
        \ ]

  let g:LanguageClient_serverCommands["java"] = s:server_cmd

  execute 'LanguageClientStart rootPath=' . getcwd()

endfunction

command! StartJavaLSP :call s:StartJavaLSP()

if exists('g:langclient_java_autostart') && g:langclient_java_autostart == 1
  autocmd BufReadPost *.java call s:StartJavaLSP()
endif

