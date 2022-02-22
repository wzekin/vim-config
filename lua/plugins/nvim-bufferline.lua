local M = {"akinsho/nvim-bufferline.lua"}

M.requires = {"kyazdani42/nvim-web-devicons"}

function M.config()
  local bufferline = require("bufferline")
  bufferline.setup({
    options = {
      view = "multiwindow",
      numbers = "ordinal",
      buffer_close_icon = "",
      modified_icon = "●",
      close_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",
      max_name_length = 18,
      max_prefix_length = 15,
      tab_size = 18,
      show_buffer_close_icons = true,
      persist_buffer_sort = true,
      enforce_regular_tabs = false,
      always_show_bufferline = true,
      sort_by = "extension"
    }
  })
end

return M
