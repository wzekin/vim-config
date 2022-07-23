local M = { "https://git.sr.ht/~whynothugo/lsp_lines.nvim" }

function M.config()
  require("lsp_lines").setup()
  vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = true
  })
end

return M
