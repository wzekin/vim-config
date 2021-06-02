/** @luaTable */
type OptionConfigs = {
  [key: string]: any;
};

const options: OptionConfigs = {
  termguicolors: true,
  // 将制表符扩展为空格
  expandtab: true,
  // 设置编辑时制表符占用空格数
  tabstop: 2,
  // 设置格式化时制表符占用空格数
  shiftwidth: 2,
  // 让 vim 把连续数量的空格视为一个制表符
  softtabstop: 2,
  // 关闭兼容模式
  nocompatible: true,
  // vim 自身命令行模式智能补全
  wildmenu: true,
  hidden: true,
  // 主题相关
  background: "dark",
  t_Co: 256,
  // 总是显示状态栏
  laststatus: 2,
  // 开启行号显示
  number: true,
  // 高亮显示当前行/列
  cursorline: true,
  cursorcolumn: true,
  // 高亮显示搜索结果
  hlsearch: true,
  //折叠相关
  foldmethod: "expr",
  foldexpr: "nvim_treesitter#foldexpr()",
  // 启动 vim 时关闭折叠代码
  nofoldenable: true,
  // 设置历史容量
  history: 2000,
  // create undo file
  undolevels: 1000,
  undoreload: 10000,
  undofile: true,
  // 打开增量搜索模式,随着键入即时搜索
  incsearch: true,
  relativenumber: "number",
  completeopt: "menuone,noselect",
};

//for key, value in pairs(options) do
//end
export function init_options(): void {
  for (const [key, value] of pairs(options)) {
    if (typeof key == "string") {
      pcall(vim.api.nvim_set_option, key, value);
      pcall(vim.api.nvim_win_set_option, 0, key, value);
      pcall(vim.api.nvim_buf_set_option, 0, key, value);
    }
  }
}
