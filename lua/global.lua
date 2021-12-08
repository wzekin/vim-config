_G.CloseAllSavedBuffer = function()
  local function is_valid(buf_num)
    if ((not buf_num) or (buf_num < 1)) or (not vim.api.nvim_buf_is_valid(buf_num)) then
      return false
    end
    local listed = vim.api.nvim_buf_get_option(buf_num, "buflisted") == true
    local not_modified = vim.api.nvim_buf_get_option(buf_num, "modified") == false
    return listed and not_modified
  end
  local buffers = vim.api.nvim_list_bufs()
  local current = vim.api.nvim_get_current_buf()
  if not is_valid(current) then
    vim.cmd("wincmd w")
    vim.cmd("ene!")
  end
  for ____, buf in ipairs(buffers) do
    if is_valid(buf) and (current ~= buf) then
      vim.api.nvim_buf_delete(buf, {force = true})
    end
  end
end

_G.SaveAndPause = function()
  local current = vim.api.nvim_get_current_buf()
  if vim.api.nvim_buf_get_option(current, "modified") then
    vim.cmd("w")
  end
  vim.cmd("sus")
end
