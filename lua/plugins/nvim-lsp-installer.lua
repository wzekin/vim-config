local M = {"williamboman/nvim-lsp-installer"}

function M.config()
  local lsp_installer = require("nvim-lsp-installer")
  lsp_installer.on_server_ready(function(server)
    local opts = {}
    local coq = require "coq"
    server:setup(coq.lsp_ensure_capabilities(opts))
  end)
end

return M
