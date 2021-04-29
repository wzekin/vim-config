interface MapConfig {
  from: string;
  to: string;
  options?: vim.api.KeymapOptions;
}

/** @luaTable */
type MapConfigs = MapConfig[];

const normalConfig: MapConfigs = [
  // 快速关闭
  { from: "<leader>qq", to: ":wqa<CR>" },
  // 切换BUFFER
  { from: "<leader>bp", to: ':call VSCodeNotify("workbench.action.previousEditor")<CR>' },
  { from: "<leader>bn", to: ':call VSCodeNotify("workbench.action.nextEditor")<CR>' },
  // 快速切换窗口
  { from: "<Tab>", to: "<C-w>w" },
  { from: "<leader><Tab>", to: ':call VSCodeNotify("workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup")<CR>' },

  { from: "=G", to: ':call VSCodeNotify("editor.action.formatDocument")<CR>' },
  // 文件查找
  { from: "<leader>f", to: ':call VSCodeNotify("workbench.action.quickOpen")<CR>' },
  { from: "<leader>g", to: ':call VSCodeNotify("workbench.view.search.focus")<CR>' },

  { from: "<leader>de", to: ':call VSCodeNotify("workbench.view.explorer")<CR>' },
  { from: "<leader>dd", to: ':call VSCodeNotify("workbench.action.toggleSidebarVisibility")<CR>' },
  // 字符查找
  { from: "f", to: "<Plug>(easymotion-f)" },
  { from: "F", to: "<Plug>(easymotion-F)" },
  { from: "t", to: "<Plug>(easymotion-t)" },
  { from: "T", to: "<Plug>(easymotion-T)" },
  { from: "<leader>j", to: "<Plug>(easymotion-j)" },
  { from: "<leader>k", to: "<Plug>(easymotion-k)" },
];

export function init_maps(): void {
  for (const n of normalConfig) {
    const options = n.options || { silent: true };
    vim.api.nvim_set_keymap("n", n.from, n.to, options);
  }
}
