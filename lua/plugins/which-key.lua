-- local M = {"folke/which-key.nvim"}
local M = { "max397574/which-key.nvim" }

M.disable = false

function M.config()
  local wk = require("which-key")
  wk.register({
    ["<leader><leader>"] = {
      function() require("telescope.builtin").oldfiles() end, "Open Recent File",
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
      g = { function() require("telescope.builtin").live_grep() end, "Search File" },
      G = { function() require("telescope.builtin").grep_string() end, "Search File" },
      ds = { function() require("telescope.builtin").lsp_document_symbols() end, "Find Document symbols" },
      ws = { function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end, "Find WorkSpace symbols" },
    },

    ["<leader>c"] = {
      name = "+Lsp",
      a = { function() vim.lsp.buf.code_action() end, 'Code action' },
      d = { function() require("telescope.builtin").diagnostics { bufnr = 1 } end, 'Local Diagnostics' },
      D = { function() require("telescope.builtin").diagnostics() end, 'Workspace Diagnostics' },
      f = { function() vim.lsp.buf.formatting {} end, 'format' },
      l = {
        function() vim.diagnostic.open_float(0, { scope = "line", border = "single" }) end,
        'line diagnostics'
      },
      r = { function() vim.lsp.buf.rename() end, 'rename' },
    },

    ["<leader>t"] = {
      name = "+Toggle",
      d = { "<cmd>NvimTreeToggle<CR>", "Toggle File Tree" },
      l = { function() require("lsp_lines").toggle() end, "Toggle lsp_lines" },
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
