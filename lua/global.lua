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

_G.UpdateBulb = function()
  require'nvim-lightbulb'.update_lightbulb {
      -- LSP client names to ignore
      -- Example: {"sumneko_lua", "null-ls"}
      ignore = {},
      sign = {
          enabled = true,
          -- Priority of the gutter sign
          priority = 10,
      },
      float = {
          enabled = false,
          -- Text to show in the popup float
          text = "💡",
          -- Available keys for window options:
          -- - height     of floating window
          -- - width      of floating window
          -- - wrap_at    character to wrap at for computing height
          -- - max_width  maximal width of floating window
          -- - max_height maximal height of floating window
          -- - pad_left   number of columns to pad contents at left
          -- - pad_right  number of columns to pad contents at right
          -- - pad_top    number of lines to pad contents at top
          -- - pad_bottom number of lines to pad contents at bottom
          -- - offset_x   x-axis offset of the floating window
          -- - offset_y   y-axis offset of the floating window
          -- - anchor     corner of float to place at the cursor (NW, NE, SW, SE)
          -- - winblend   transparency of the window (0-100)
          win_opts = {},
      },
      virtual_text = {
          enabled = false,
          -- Text to show at virtual text
          text = "💡",
          -- highlight mode to use for virtual text (replace, combine, blend), see :help nvim_buf_set_extmark() for reference
          hl_mode = "replace",
      },
      status_text = {
          enabled = false,
          -- Text to provide when code actions are available
          text = "💡",
          -- Text to provide when no actions are available
          text_unavailable = ""
      }
  }
end
