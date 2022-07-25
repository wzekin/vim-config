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

  vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = "*",
    callback = function()
      if vim.api.nvim_buf_line_count(0) < 1000 then
        vim.api.nvim_set_option('incsearch', true)
      else
        require('cmp').setup.buffer { enabled = false }
        vim.api.nvim_buf_set_option(0, 'ro', true)
        vim.api.nvim_set_option('incsearch', false)
      end
    end
  })

end

return M
