" 关闭默认的映射
let g:codeverse_no_map_tab = v:true

" 将 Accept 映射到 ctrl-z 上
inoremap <script><silent><nowait><expr> <C-f> codeverse#Accept()

lua require("core")
