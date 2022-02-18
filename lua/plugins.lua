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
    [1] = "machakann/vim-sandwich",
    config = function()
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
  for I = 1, #lsp_plugins do
    plugins[#plugins + 1] = lsp_plugins[I]
  end

  local window_plugins = require("plugins.window")
  for I = 1, #window_plugins do
    plugins[#plugins + 1] = window_plugins[I]
  end

  packer.init({ensure_dependencies = true})
  packer.use(plugins)
end
return M
