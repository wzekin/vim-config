export function CloseAllSavedBuffer(): void {
  function is_valid(buf_num: number): boolean {
    if (!buf_num || buf_num < 1) {
      return false;
    }
    const listed = vim.api.nvim_buf_get_option(buf_num, "buflisted") == true;
    const exists = vim.api.nvim_buf_is_valid(buf_num);
    const not_modified =
      vim.api.nvim_buf_get_option(buf_num, "modified") == false;
    return listed && exists && not_modified;
  }
  const buffers = vim.api.nvim_list_bufs();
  const current = vim.api.nvim_get_current_buf();

  for (const buf of buffers) {
    if (is_valid(buf) && current !== buf) {
      vim.cmd(`bdelete! ${buf}`);
    }
  }
}

export function SaveAndPause(): void {
  if (vim.api.nvim_buf_get_option(0, "modified") === 1) {
    vim.cmd("w");
  }
  vim.cmd("sus");
}
