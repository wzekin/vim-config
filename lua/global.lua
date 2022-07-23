_G.EditNeovim = function()
  local builtin = require("telescope.builtin")
  builtin.git_files {
    cwd = "~/.config/nvim",
    prompt = "~ dotfiles ~",
    color_devicons = true,
    sorting_strategy = "ascending"
  }
end

_G.IsGitDir = function()
  local Job = require "plenary.job"
  local __, ret = Job:new({
    command = 'git',
    args = { 'rev-parser', '--show-toplevel' },
    cwd = vim.fn.getcwd(),
  }):sync()

  return ret == 0
end


function _G.set_terminal_keymaps()
  local opts = { noremap = true }
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
  vim.api.nvim_buf_set_keymap(0, 'n', '<C-f>', "", {
    noremap = true,
    callback = function()
      local id, term = require('toggleterm.terminal').identify()

      term:close()
      if term.direction == 'float' then
        term:open(12, 'horizontal')
      else
        term:open(12, 'float')
      end
    end
  })
  vim.api.nvim_buf_set_keymap(0, 't', '<C-f>', "", {
    noremap = true,
    callback = function()
      local id, term = require('toggleterm.terminal').identify()

      term:close()
      if term.direction == 'float' then
        term:open(12, 'horizontal')
      else
        term:open(12, 'float')
      end
    end
  })
end
