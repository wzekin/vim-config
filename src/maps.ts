interface MapConfig {
  from: string;
  to: string;
  options?: vim.api.KeymapOptions;
}

/** @luaTable */
type MapConfigs = MapConfig[];

const insertConfig: MapConfigs = [
  { from: "jk", to: "<Esc>" },
  { from: "kj", to: "<C-o>" },
  // 自动补全
  { from: "<c-p>", to: "<Plug>(completion_trigger)" },
  { from: "<tab>", to: "<Plug>(completion_smart_tab)" },
  { from: "<s-tab>", to: "<Plug>(completion_smart_s_tab)" },
];

const normalConfig: MapConfigs = [
  // 快速关闭
  { from: "<leader>qq", to: ":wqa<CR>" },
  // 切换BUFFER
  { from: "<leader>bl", to: ":ls<CR>" },
  { from: "<leader>bl", to: ":ls<CR>" },
  { from: "<leader>bn", to: ":BufferLineCycleNext<CR>" },
  { from: "<leader>bp", to: ":BufferLineCyclePrev<CR>" },
  { from: "<leader>bd", to: ":bd<CR>" },
  { from: "<leader>bc", to: ":lua CloseAllSavedBuffer()<CR>" },
  { from: "<leader>bb", to: ":BufferLinePick<CR>" },
  // 快速切换窗口
  { from: "<Tab>", to: "<C-w>w" },
  { from: "<leader><Tab>", to: "<C-^>" },
  // 窗口
  { from: "<leader>d", to: ":NvimTreeToggle<CR>" },
  // 快速暂停窗口并保存
  { from: "<leader>s", to: ":lua SaveAndPause()<CR>" },
  // 文件查找
  { from: "<leader>f", to: ":Files<CR>" },
  { from: "<leader>g", to: ":Rg<CR>" },
  { from: "<leader>t", to: ":Tags<CR>" },
  // 字符查找
  { from: "f", to: "<Plug>(easymotion-f)" },
  { from: "F", to: "<Plug>(easymotion-F)" },
  { from: "t", to: "<Plug>(easymotion-t)" },
  { from: "T", to: "<Plug>(easymotion-T)" },
  { from: "<leader>j", to: "<Plug>(easymotion-j)" },
  { from: "<leader>k", to: "<Plug>(easymotion-k)" },
];

export function init_maps(): void {
  for (const i of insertConfig) {
    const options = i.options || { silent: true };
    vim.api.nvim_set_keymap("i", i.from, i.to, options);
  }

  for (const n of normalConfig) {
    const options = n.options || { silent: true };
    vim.api.nvim_set_keymap("n", n.from, n.to, options);
  }
}
