if exists('g:langclient_java_loaded') || &cp
  finish
endif

let g:langclient_java_loaded = 1

if !exists("g:LanguageClient_serverCommands")
    let g:LanguageClient_serverCommands = {}
endif

if !exists("g:langclient_java_docker_image")
  let g:langclient_java_docker_image = 'vdesjardins/langclient-java'
endif

function! s:StartJavaLSP()
  let s:server_cmd = [ 'docker', 'run', '-i', '--rm', '-v', '/etc/localtime:/etc/localtime', '-v', getcwd() . ':' . getcwd() .':rw', g:langclient_java_docker_image ]

  let g:LanguageClient_serverCommands["java"] = s:server_cmd

  execute 'LanguageClientStart rootPath=' . getcwd()
endfunction

command! StartJavaLSP :call s:StartJavaLSP()

if exists('g:langclient_java_autostart') && g:langclient_java_autostart == 1
  autocmd BufReadPost *.java call s:StartJavaLSP()
endif

