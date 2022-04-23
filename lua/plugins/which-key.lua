local M = {"folke/which-key.nvim"}

function M.config()
  local wk = require("which-key")
  wk.register({
    ["<leader><leader>"] = {
      "<Cmd>Telescope commands<CR>",
      "commands"
    },
    ["<leader>b"] = {
      name = "Buffer",
      l = {"<cmd>Telescope buffers theme=dropdown<cr>", "List Buffers"},
      n = {":BufferNext<CR>", "Next Buffer"},
      p = {":BufferPrevious<CR>", "Prev Buffer"},
      d = {":BufferClose<CR>", "Delete Buffer"},
      c = {":BufferCloseAllButCurrent<CR>", "Clear Buffer"},
      b = {":BufferPick<CR>", "Pick Buffer"}
    },
    ["<leader>f"] = {
      name = "+Find",
      f = {"<CMD>Telescope git_files<CR>", "Find File"},
      F = {"yiw<CMD>Telescope git_files<CR><C-r>\"<ESC>", "Find File"},
      r = {"<cmd>Telescope oldfiles<cr>", "Open Recent File"},
      g = {"<cmd>Telescope live_grep<cr>", "Search File"},
      G = {"<CMD>Telescope grep_string<CR><ESC>", "Search File"},
      t = {"<cmd>Telescope aerial<cr>", "Find symbols"},
      p = {
        "<cmd>lua require'telescope'.extensions.repo.list{file_ignore_patterns={'/%.cache/', '/%.cargo/', '/%.local/', '/%timeshift/', '/usr/', '/srv/', '/%.oh%-my%-zsh'}}<CR>",
        "Find Project"
      }
    },

    ["<leader>c"] = {
      name = "+Lsp",
      a = {'<cmd>Telescope lsp_code_actions theme=cursor<CR>', 'Code action'},
      d = {'<cmd>Telescope diagnostics bufnr=0<CR>', 'Local Diagnostics'},
      D = {'<cmd>Telescope diagnostics<CR>', 'Workspace Diagnostics'},
      f = {'<cmd>lua vim.lsp.buf.formatting()<CR>', 'format'},
      l = {
        '<cmd>lua vim.diagnostic.open_float(0, { scope = \"line\", border = \"single\" })<CR>',
        'line diagnostics'
      },
      r = {'<cmd>lua vim.lsp.buf.rename()<CR>', 'rename'},
      s = {'<cmd>Telescope symbols<CR>', 'symbols'}
    },

    ["<leader>t"] = {
      name = "+Toggle",
      d = {"<cmd>NvimTreeToggle<CR>", "Toggle File Tree"},
      t = {"<cmd>AerialToggle!<CR>", "Toggle Aerial"},
      s = {"Toggle Style"}
    },

    ["<leader>s"] = {"<cmd>lua SaveAndPause()<CR>", "Save And Pause"},

    ["<leader>j"] = {
      name = "+Search",
      c = {'<cmd>Telescope colorscheme<CR>', 'color schemes'},
      d = {'<cmd>lua EditNeovim()<CR>', 'dotfiles'},
      h = {'<cmd>Telescope oldfiles<CR>', 'file history'},
      H = {'<cmd>Telescope command_history<CR>', 'command history'},
      s = {'<cmd>Telescope search_history<CR>', 'search history'}
    },

    ["<leader>r"] = {
      name = "+Run",
      e = {'<cmd>AsyncTaskEdit<CR>', 'Edit Task'},
      t = {'<cmd>lua require(\'telescope\').extensions.asynctasks.all()<CR>', 'Tasks'},
      f = {
        name = "+File",
        r = {'<cmd>AsyncTask file-run<CR>', 'Run File'},
        b = {'<cmd>AsyncTask file-build<CR>', 'Build File'},
      },
    },

    K = {"<Cmd>lua vim.lsp.buf.hover()<CR>", "Lsp Hover"},
    L = {"<cmd>lua vim.lsp.buf.signature_help()<CR>", "Lsp Signature Help"},

    ["[d"] = {
      "<cmd>lua vim.diagnostic.goto_prev({ float = {border = \"single\"}})<CR>",
      "Prev Diagnostics"
    },
    ["]d"] = {
      "<cmd>lua vim.diagnostic.goto_next({ float = {border = \"single\"}})<CR>",
      "Next Diagnostics"
    }

  })
end

return M
