_G.CloseAllSavedBuffer = function()
  local function is_valid(buf_num)
    if ((not buf_num) or (buf_num < 1)) or
        (not vim.api.nvim_buf_is_valid(buf_num)) then
      return false
    end
    return vim.api.nvim_buf_get_option(buf_num, "buflisted") == true
  end

  local function not_modified(buf_num)
    return vim.api.nvim_buf_get_option(buf_num, "modified") == false
  end

  local buffers = vim.api.nvim_list_bufs()
  local current = vim.api.nvim_get_current_buf()
  if not is_valid(current) then
    vim.cmd("wincmd w")
    vim.cmd("ene!")
  end
  for ____, buf in ipairs(buffers) do
    if (current ~= buf) and is_valid(buf) and not_modified(buf) then
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

_G.UpdateBulb = function()
  require('nvim-lightbulb').update_lightbulb {
    ignore = {},
    sign = {enabled = false},
    virtual_text = {enabled = true, text = "💡", hl_mode = "replace"}
  }
end

_G.EditNeovim = function()
  local builtin = require("telescope.builtin")
  builtin.git_files {
    cwd = "~/.config/nvim",
    prompt = "~ dotfiles ~",
    color_devicons = true,
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {mirror = false},
      vertical = {mirror = false},
      prompt_position = "top"
    }
  }
end
