if exists('g:langclient_java_loaded') || &cp
  finish
endif

let g:langclient_java_loaded = 1

if !exists("g:LanguageClient_serverCommands")
    let g:LanguageClient_serverCommands = {}
endif

if !exists("g:langclient_java_docker_image")
  let g:langclient_java_docker_image = 'vdesjardins/langclient-java:v0.8.0'
endif

if !exists("g:langclient_java_maven_home")
  let g:langclient_java_maven_home = resolve(expand("~/.m2"))
endif

function! s:StartJavaLSP()
  let l:uid = system("id -u")
  let l:gid = system("id -g")

  let s:server_cmd = [ 'docker', 'run', '-i', '--rm',
      \ '-e', 'EUID=' . l:uid, '-e', 'EGID=' . l:gid,
      \ '-v', '/etc/localtime:/etc/localtime',
      \ '-v', getcwd() . ':' . getcwd() .':rw',
      \ '-v', g:langclient_java_maven_home . ':/home/dev/.m2:rw',
      \ g:langclient_java_docker_image ]

  let g:LanguageClient_serverCommands["java"] = s:server_cmd

  execute 'LanguageClientStart rootPath=' . getcwd()
endfunction

command! StartJavaLSP :call s:StartJavaLSP()

function! s:StopJavaLSP()
  execute 'LanguageClientStop'
  sleep 100m
endfunction

command! StopJavaLSP :call s:StopJavaLSP()

augroup langclient_java
  autocmd!

  " need this because name pipes aren't closed and docker
  " does not pick up that the parent process is not at the other end.
  autocmd VimLeavePre * call s:StopJavaLSP()

  if exists('g:langclient_java_autostart') && g:langclient_java_autostart == 1
    autocmd BufReadPost *.java call s:StartJavaLSP()
  endif
augroup END
