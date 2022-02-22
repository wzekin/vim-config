local M = {"folke/which-key.nvim"}

function M.config()
  local wk = require("which-key")
  wk.register({
    ["<leader>b"] = {
      name = "Buffer",
      l = {"<cmd>Telescope buffers<cr>", "List Buffers"},
      n = {":BufferLineCycleNext<CR>", "Next Buffer"},
      p = {":BufferLineCyclePrev<CR>", "Prev Buffer"},
      d = {":bd<CR>", "Delete Buffer"},
      c = {":lua CloseAllSavedBuffer()<CR>", "Clear Buffer"},
      b = {":BufferLinePick<CR>", "Pick Buffer"}
    },
    ["<leader>f"] = {
      name = "+File",
      f = {"<cmd>Telescope find_files<cr>", "Find File"},
      r = {"<cmd>Telescope oldfiles<cr>", "Open Recent File"},
      g = {"<cmd>Telescope live_grep<cr>", "Search File"}
    },

    ["<leader>c"] = {
      name = "+Lsp",
      a = {'<cmd>Telescope lsp_code_action<CR>', 'Code action'},
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
