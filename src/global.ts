_G.CloseAllSavedBuffer = () => {
  function is_valid(buf_num: number): boolean {
    if (!buf_num || buf_num < 1 || !vim.api.nvim_buf_is_valid(buf_num)) {
      return false;
    }
    const listed = vim.api.nvim_buf_get_option(buf_num, "buflisted") == true;
    const not_modified =
      vim.api.nvim_buf_get_option(buf_num, "modified") == false;
    return listed && not_modified;
  }

  const buffers = vim.api.nvim_list_bufs();
  const current = vim.api.nvim_get_current_buf();

  // 创建一个新buffer，防止file brower自动退出
  if (!is_valid(current)) {
    vim.cmd("wincmd w");
    vim.cmd("ene!");
  }

  for (const buf of buffers) {
    if (is_valid(buf) && current !== buf) {
      vim.api.nvim_buf_delete(buf, { force: true });
    }
  }
};

_G.SaveAndPause = () => {
  const current = vim.api.nvim_get_current_buf();
  if (vim.api.nvim_buf_get_option(current, "modified")) {
    vim.cmd("w");
  }
  vim.cmd("sus");
};
