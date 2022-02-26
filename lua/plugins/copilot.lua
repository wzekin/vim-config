local M = {"github/copilot.vim"}

function M.setup()
  vim.api.nvim_set_keymap("i", '<C-f>', 'copilot#Accept("<CR>")',
                          {silent = true, expr = true, script = true})
  vim.g.copilot_no_tab_map = true
end

return M

