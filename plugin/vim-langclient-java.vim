
if !exists("g:LanguageClient_serverCommands")
    let g:LanguageClient_serverCommands = {}
endif

let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h')

let s:storage_workspace = tempname()

let s:server_cmd = [
                     \ "java",
                     \ "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                     \ "-Dosgi.bundles.defaultStartLevel=4",
                     \ "-Declipse.product=org.eclipse.jdt.ls.core.product",
                     \ "-noverify",
                     \ "-Xmx1G", "-XX:+UseG1GC",
                     \ "-XX:+UseStringDeduplication",
                     \ "-jar", s:path . "/../eclipse/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_1.4.0.v20161219-1356.jar",
                     \ "-configuration", s:path . "/../eclipse/org.eclipse.jdt.ls.product/target/repository/config_linux",
                     \ "-data", s:storage_workspace
                 \ ]

let g:LanguageClient_serverCommands["java"] = s:server_cmd

