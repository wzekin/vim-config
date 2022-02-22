local M = {"neovim/nvim-lspconfig"}

function M.config()
  local servers = {}
  local coq = require("coq")
  local nvim_lsp = require("lspconfig")
  for ____, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup(coq.lsp_ensure_capabilities({}))
  end
end

return M
