local M = { "ethanholz/nvim-lastplace" }

M.disable = false

function M.config()
  require 'nvim-lastplace'.setup {
    lastplace_ignore_buftype = { "quickfix", "nofile", "help", "terminal" },
    lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit", "toggleterm" },
    lastplace_open_folds = true
  }
end

return M
