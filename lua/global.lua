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
