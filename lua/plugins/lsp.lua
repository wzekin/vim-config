return {
  -- copilot
  {[1] = "github/copilot.vim"},
  -- coq
  {
    [1] = "ms-jpq/coq_nvim",
    branch = "coq",
    setup = function() vim.g.coq_settings = {auto_start = "shut-up"} end,
    config = function()
      -- local coq = require("coq")
      require("coq_3p") {
        {src = "nvimlua", short_name = "nLUA", conf_only = true},
        {src = "copilot", short_name = "COP", accept_key = "<c-f>"}
      }
    end
  },
  {[1] = "ms-jpq/coq.artifacts", branch = "artifacts"},
  {[1] = "ms-jpq/coq.thirdparty", branch = "3p"},
  -- lsp local config
  {
    [1] = "neovim/nvim-lspconfig",
    config = function()
      local servers = {}
      local coq = require("coq")
      local nvim_lsp = require("lspconfig")
      for ____, lsp in ipairs(servers) do
        nvim_lsp[lsp].setup(coq.lsp_ensure_capabilities({}))
      end
    end
  },
  -- lsp install config
  {
    "williamboman/nvim-lsp-installer",
    config = function()
      local lsp_installer = require("nvim-lsp-installer")
      lsp_installer.on_server_ready(function(server)
        local opts = {}
        local coq = require "coq"
        server:setup(coq.lsp_ensure_capabilities(opts))
      end)
    end
  },
  {"kosayoda/nvim-lightbulb", config = function() vim.cmd [[]] end},
  {
    "antoinemadec/FixCursorHold.nvim",
    setup = function() vim.g.cursorhold_updatetime = 500 end
  }
}
