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

_G.NvimTreeToggle = function()
  local view = require 'nvim-tree.view'
  if view.is_visible() then
    require'bufferline.state'.set_offset(0)
  else
    require'bufferline.state'.set_offset(31, 'FileTree')
  end
  require'nvim-tree'.toggle(false)
end

_G.EditNeovim = function()
  local builtin = require("telescope.builtin")
  builtin.git_files {
    cwd = "~/.config/nvim",
    prompt = "~ dotfiles ~",
    color_devicons = true,
    sorting_strategy = "ascending"
  }
end
