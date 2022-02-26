local M = {'scalameta/nvim-metals', requires = {"nvim-lua/plenary.nvim"}}

function M.config()
  local metals_config = require("metals").bare_config()
  metals_config.init_options.statusBarProvider = "on"
  metals_config.settings = {showImplicitArguments = true}
  metals_config.capabilities = require('cmp_nvim_lsp').update_capabilities(
                                   vim.lsp.protocol.make_client_capabilities())

  vim.cmd [[
    augroup lsp
      au!
      au FileType java,scala,sbt lua require("metals").initialize_or_attach({})
    augroup end
  ]]
end

return M
