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
  local _, ret = Job:new({
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

  local toggle_diection = function()
    local toggleterm = require("toggleterm")
    local terms = require("toggleterm.terminal")
    local _, term = terms.identify()
    toggleterm.toggle(term.id)

    if term.direction == 'float' then
      toggleterm.toggle(term.id, nil, nil, 'horizontal')
    else
      toggleterm.toggle(term.id, nil, nil, 'float')
    end

    -- vim.cmd [[startinsert]]
    -- vim.cmd [[startinsert]]
  end

  vim.api.nvim_buf_set_keymap(0, 'n', '<C-t>', "", {
    noremap = true,
    callback = toggle_diection
  })
  -- vim.api.nvim_buf_set_keymap(0, 't', '<C-t>', "", {
  --   noremap = true,
  --   callback = toggle_diection
  -- })
end
