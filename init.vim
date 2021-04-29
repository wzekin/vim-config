lua require("index")

" 开启语法高亮
syntax on
" 根据侦测到的不同类型加载对应的插件
filetype plugin on
" 自适应不同语言的智能缩进
filetype indent on

"au FocusLost * :set norelativenumber number
"au FocusGained * :set relativenumber
"" 插入模式下用绝对行号, 普通模式下用相对
"autocmd InsertEnter * :set norelativenumber number
"autocmd InsertLeave * :set relativenumber

"" 设置可以高亮的关键字
"if has("autocmd")
  "" Highlight TODO, FIXME, NOTE, etc.
  "if v:version > 701
    "autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|DONE\|XXX\|BUG\|HACK\)')
    "autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\|NOTICE\)')
  "endif
"endif