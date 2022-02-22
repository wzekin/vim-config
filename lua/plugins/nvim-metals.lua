local M = {'scalameta/nvim-metals', requires = {"nvim-lua/plenary.nvim"}}

function M.config()

    local metals_config = require("metals").bare_config()
    metals_config.init_options.statusBarProvider = "on"
    metals_config.settings = {showImplicitArguments = true}

    vim.cmd [[
    augroup lsp
      au!
      au FileType java,scala,sbt lua require("metals").initialize_or_attach(require("coq").lsp_ensure_capabilities({}))
    augroup end
  ]]
end

return M
