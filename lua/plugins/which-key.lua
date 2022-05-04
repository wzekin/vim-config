-- local M = {"folke/which-key.nvim"}
local M = { "max397574/which-key.nvim" }

function M.config()
  local wk = require("which-key")
  wk.register({
    ["<leader><leader>"] = {
      "<Cmd>Telescope commands<CR>",
      "commands"
    },
    ["<leader>b"] = {
      name = "Buffer",
      l = { "<cmd>Telescope buffers theme=dropdown<cr>", "List Buffers" },
      n = { ":BufferNext<CR>", "Next Buffer" },
      p = { ":BufferPrevious<CR>", "Prev Buffer" },
      d = { ":BufferClose<CR>", "Delete Buffer" },
      c = { ":BufferCloseAllButCurrent<CR>", "Clear Buffer" },
      b = { ":BufferPick<CR>", "Pick Buffer" }
    },
    ["<leader>f"] = {
      name = "+Find",
      f = { function()
        if IsGitDir() then
          require("telescope.builtin").git_files()
        else
          require("telescope.builtin").find_files()
        end
      end, "Find File" },
      r = { function() require("telescope.builtin").oldfiles() end, "Open Recent File" },
      g = { function() require("telescope.builtin").live_grep() end, "Search File" },
      G = { function() require("telescope.builtin").grep_string() end, "Search File" },
      t = { function() require("telescope.builtin").lsp_workspace_symbols() end, "Find symbols" },
    },

    ["<leader>c"] = {
      name = "+Lsp",
      a = { function() vim.lsp.buf.code_action() end, 'Code action' },
      d = { function() require("telescope.builtin").diagnostics { bufnr = 1 } end, 'Local Diagnostics' },
      D = { function() require("telescope.builtin").diagnostics() end, 'Workspace Diagnostics' },
      f = { function() vim.lsp.buf.format { async = true } end, 'format' },
      l = {
        function() vim.diagnostic.open_float(0, { scope = "line", border = "single" }) end,
        'line diagnostics'
      },
      r = { function() vim.lsp.buf.rename() end, 'rename' },
    },

    ["<leader>t"] = {
      name = "+Toggle",
      d = { "<cmd>NvimTreeToggle<CR>", "Toggle File Tree" },
      t = { "<cmd>AerialToggle!<CR>", "Toggle Aerial" },
      s = { "Toggle Style" }
    },

    ["<leader>j"] = {
      name = "+Search",
      c = { function() require("telescope.builtin").colorscheme() end, 'color schemes' },
      d = { function() EditNeovim() end, 'dotfiles' },
      h = { function() require("telescope.builtin").oldfiles() end, 'file history' },
      H = { function() require("telescope.builtin").command_history() end, 'command history' },
      s = { function() require("telescope.builtin").search_history() end, 'search history' }
    },

    ["<leader>r"] = {
      name = "+Run",
      e = { '<cmd>AsyncTaskEdit<CR>', 'Edit Task' },
      t = { function() require('telescope').extensions.asynctasks.all() end, 'Tasks' },
      f = {
        name = "+File",
        r = { '<cmd>AsyncTask file-run<CR>', 'Run File' },
        b = { '<cmd>AsyncTask file-build<CR>', 'Build File' },
      },
    },

    K = { function() vim.lsp.buf.hover() end, "Lsp Hover" },
    L = { function() vim.lsp.buf.signature_help() end, "Lsp Signature Help" },

    ["[d"] = {
      function() vim.diagnostic.goto_prev({ float = { border = "single" } }) end,
      "Prev Diagnostics"
    },
    ["]d"] = {
      function() vim.diagnostic.goto_next({ float = { border = "single" } }) end,
      "Next Diagnostics"
    },
    ["gd"] = {
      function() require("telescope.builtin").lsp_definitions() end, "Find Declaration"
    },
    ["gr"] = {
      function() require("telescope.builtin").lsp_references() end, "Find References"
    },
    ["gi"] = {
      function() require("telescope.builtin").lsp_implementations() end, "Find Implementations"
    }

  })
end

return M
