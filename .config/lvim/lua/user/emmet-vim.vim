lua << EOF
let g:user_emmet_mode='a'    "enable all function in all mode.
let g:user_emmet_leader_key=','
" Enable just for html/css/js
let g:user_emmet_install_global = 0
autocmd FileType html,css,javascript EmmetInstall
let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\}
EOF
