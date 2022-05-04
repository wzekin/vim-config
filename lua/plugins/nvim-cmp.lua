local M = {"hrsh7th/nvim-cmp"}

M.requires = {
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  "f3fora/cmp-spell",
  'hrsh7th/cmp-vsnip',
  'hrsh7th/vim-vsnip',
  'williamboman/nvim-lsp-installer',
  'onsails/lspkind-nvim',
  "neovim/nvim-lspconfig"
}

function M.config()
  -- Setup nvim-cmp.
  local cmp = require 'cmp'
  local lspkind = require('lspkind')

  cmp.setup({
    formatting = {
      format = lspkind.cmp_format({
        mode = 'symbol_text', -- show only symbol annotations
        maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

        -- The function below will be called before any actual modifications from lspkind
        -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
        before = function(entry, vim_item)
          return vim_item
        end
      })
    },
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end
    },
    mapping = {
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
      ['<CR>'] = cmp.mapping.confirm({select = true}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ['<C-e>'] = cmp.mapping.close(),
      ["<S-Tab>"] = cmp.mapping.select_prev_item(),
      ["<Tab>"] = cmp.mapping.select_next_item({
        behavior = cmp.SelectBehavior.Replace
      })
    },

    sources = {
      {name = 'nvim_lsp'},
      {name = 'treesitter'},
      {name = 'vsnip'},
      {name = 'path'},
      {name = 'spell'},
      {
        name = 'buffer',
        option = {
          get_bufnrs = function()
            return vim.api.nvim_list_bufs()
          end
        }
      }
    }
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      {name = 'cmp_git'} -- You can specify the `cmp_git` source if you were installed it.
    }, {{name = 'buffer'}})
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {sources = {{name = 'buffer'}}})

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp
                                                                       .protocol
                                                                       .make_client_capabilities())

  local lsp_installer = require("nvim-lsp-installer")
  lsp_installer.on_server_ready(function(server)
    local opts = {
      capabilities = capabilities,
      on_attach = require("aerial").on_attach
    }
    if server.name == "rust_analyzer" then
      opts.settings = {
        ["rust-analyzer"] = {
          checkOnSave = {
            allTargets = false
          }
        }
      }
    end
    if server.name == "sumneko_lua" then
      local runtime_path = vim.split(package.path, ';')
      table.insert(runtime_path, "lua/?.lua")
      table.insert(runtime_path, "lua/?/init.lua")
      opts.settings = {
          ["sumneko_lua"] = {
              runtime = {
                  -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                  version = "LuaJIT",
                  -- Setup your lua path
                  path = runtime_path
              },
              diagnostics = {
                  -- Get the language server to recognize the `vim` global
                  globals = {"vim"}
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
    end
    server:setup(opts)
  end)

  local servers = {}
  local nvim_lsp = require("lspconfig")
  for ____, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup({
      capabilities = capabilities,
      on_attach = require("aerial").on_attach
    })
  end
end

return M

