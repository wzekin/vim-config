local M = {}

local function UpdateBulb()
  require('nvim-lightbulb').update_lightbulb {
    ignore = {},
    sign = { enabled = false },
    virtual_text = { enabled = true, text = "💡", hl_mode = "replace" }
  }
end

function M.setup()
  vim.api.nvim_create_autocmd({ "FocusLost", "InsertEnter" }, {
    pattern = "*",
    callback = function()
      vim.o.relativenumber = false
    end
  })

  vim.api.nvim_create_autocmd({ "FocusGained", "InsertLeave" }, {
    pattern = "*",
    callback = function()
      vim.o.relativenumber = true
    end
  })

  vim.api.nvim_create_autocmd({ "CursorHold" }, {
    pattern = "*",
    callback = UpdateBulb
  })

end

return M
