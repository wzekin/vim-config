local M = {}
local plugins = {
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {}
      require("telescope").load_extension("projects")
    end
  },
  {
    [1] = "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup(
        {
          disable_filetype = {"TelescopePrompt", "vim"}
        }
      )
    end
  },
  {
    [1] = "mhartington/formatter.nvim",
    config = function()
      require("formatter").setup(
        {
          logging = false,
          filetype = {
            c = {
              -- clang-format
              function()
                return {
                  exe = "clang-format",
                  args = {"--assume-filename", vim.api.nvim_buf_get_name(0)},
                  stdin = true,
                  cwd = vim.fn.expand("%:p:h") -- Run clang-format in cwd of the file.
                }
              end
            },
            cpp = {
              -- clang-format
              function()
                return {
                  exe = "clang-format",
                  args = {"--assume-filename", vim.api.nvim_buf_get_name(0)},
                  stdin = true,
                  cwd = vim.fn.expand("%:p:h") -- Run clang-format in cwd of the file.
                }
              end
            },
            javascript = {
              -- prettier
              function()
                return {
                  exe = "prettier",
                  args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote"},
                  stdin = true
                }
              end
            },
            rust = {
              -- Rustfmt
              function()
                return {
                  exe = "rustfmt",
                  args = {"--emit=stdout"},
                  stdin = true
                }
              end
            },
            lua = {
              -- luafmt
              function()
                return {
                  exe = "luafmt",
                  args = {"--indent-count", 2, "--stdin"},
                  stdin = true
                }
              end
            },
            cpp = {
              -- clang-format
              function()
                return {
                  exe = "clang-format",
                  args = {},
                  stdin = true,
                  cwd = vim.fn.expand("%:p:h") -- Run clang-format in cwd of the file.
                }
              end
            },
            haskell = {
              -- clang-format
              function()
                return {
                  exe = "hindent",
                  args = {"--indent-size", 2},
                  stdin = true
                }
              end
            },
            scala = {
              -- scalafmt
              function()
                return {
                  exe = "scalafmt",
                  args = {"--stdin"},
                  stdin = true
                }
              end
            }
          }
        }
      )
      vim.api.nvim_exec(
        [[
      augroup FormatAutogroup
      autocmd!
      autocmd BufWritePost *.js,*.rs,*.lua,*.hs,*.scala,*.c FormatWrite
      augroup END
        ]],
        true
      )
    end
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end
  },
  {[1] = "wbthomason/packer.nvim", opt = true},
  {
    [1] = "p00f/nvim-ts-rainbow",
    config = function()
      vim.g.rainbow_active = 1
    end
  },
  {
    [1] = "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    requires = {"nvim-treesitter/nvim-treesitter-textobjects", "RRethy/nvim-treesitter-textsubjects"},
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup(
        {
          ensure_installed = "all",
          highlight = {enable = true},
          indent = {enable = true},
          autopairs = {enable = true},
          rainbow = {enable = true, extended_mode = true, max_file_lines = 1000},
          textobjects = {
            select = {
              enable = true,
              keymaps = {
                af = "@function.outer",
                ["if"] = "@function.inner",
                ac = "@class.outer",
                ic = "@class.inner"
              }
            }
          },
          textsubjects = {
            enable = true,
            keymaps = {
              ["."] = "textsubjects-smart",
              [";"] = "textsubjects-container-outer"
            }
          }
        }
      )
    end
  },
  {[1] = "nvim-telescope/telescope.nvim", requires = {"nvim-lua/plenary.nvim"}},
  {
    [1] = "blackCauldron7/surround.nvim",
    branch = "master",
    config = function()
      require("surround").setup({})
    end
  }
}
function M.init_plugins()
  local install_path = tostring(vim.fn.stdpath("data")) .. "/site/pack/packer/opt/packer.nvim"
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.cmd("!git clone https://github.com/wbthomason/packer.nvim " .. tostring(install_path))
  end
  vim.cmd("packadd packer.nvim")
  local packer = require("packer")

  local lsp_plugins = require("plugins.lsp")
  local window_plugins = require("plugins.window")
  for I = 1, #lsp_plugins do
    plugins[#plugins + 1] = lsp_plugins[I]
  end
  for I = 1, #window_plugins do
    plugins[#plugins + 1] = window_plugins[I]
  end

  packer.init({ensure_dependencies = true})
  packer.use(plugins)
end
return M
