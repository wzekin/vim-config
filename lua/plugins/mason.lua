local M = { "williamboman/mason.nvim" }

M.requires = {
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  "simrat39/rust-tools.nvim"
}


function M.config()
  require("mason").setup()
  require("mason-lspconfig").setup()

  -- Setup lspconfig.
  local navic = require("nvim-navic")
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp
    .protocol
    .make_client_capabilities())

  require("mason-lspconfig").setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
      require("lspconfig")[server_name].setup {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          navic.attach(client, bufnr)
        end
      }
    end,
    -- Next, you can provide targeted overrides for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    ["rust_analyzer"] = function()
      require('rust-tools').setup({})
      require("lspconfig")["rust_analyzer"].setup {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          navic.attach(client, bufnr)
        end,
        settings = {
          ["rust_analyzer"] = {
            checkOnSave = {
              allTargets = false
            }
          }
        }
      }
    end,
    ["sumneko_lua"] = function()
      local runtime_path = vim.split(package.path, ';')
      table.insert(runtime_path, "lua/?.lua")
      table.insert(runtime_path, "lua/?/init.lua")
      require("lspconfig")["sumneko_lua"].setup {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          navic.attach(client, bufnr)
        end,
        settings = {
          ["sumneko_lua"] = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = "LuaJIT",
              -- Setup your lua path
              path = runtime_path
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { "vim" }
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true)
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
              enable = false
            }
          }
        }
      }
    end
  }

end

return M
