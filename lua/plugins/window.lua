return {
  -- onedark
  {
    [1] = "navarasu/onedark.nvim",
    config = function()
      require('onedark').setup {
        -- Main options --
        style = 'warmer', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
        transparent = true, -- Show/hide background
        term_colors = true, -- Change terminal color as per the selected theme style
        ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
        -- toggle theme style ---
        toggle_style_key = '<leader>ts', -- Default keybinding to toggle
        toggle_style_list = {
          'dark',
          'darker',
          'cool',
          'deep',
          'warm',
          'warmer',
          'light'
        }, -- List of styles to toggle between

        -- Change code style ---
        -- Options are italic, bold, underline, none
        -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
        code_style = {
          comments = 'italic',
          keywords = 'none',
          functions = 'none',
          strings = 'none',
          variables = 'none'
        },

        -- Custom Highlights --
        colors = {}, -- Override default colors
        highlights = {FloatBorder = {fg = "$cyan"}}, -- Override highlight groups

        -- Plugins Config --
        diagnostics = {
          darker = true, -- darker colors for diagnostic
          undercurl = true, -- use undercurl instead of underline for diagnostics
          background = true -- use background color for virtual text
        }
      }
      vim.lsp.handlers['textDocument/hover'] =
          vim.lsp.with(vim.lsp.handlers.hover, {border = 'rounded'})
      vim.lsp.handlers['textDocument/signatureHelp'] =
          vim.lsp.with(vim.lsp.handlers.signature_help, {border = 'rounded'})

      require('onedark').load()
    end
  }, -- lualine
  {
    [1] = "hoob3rt/lualine.nvim",
    requires = {"kyazdani42/nvim-web-devicons", "navarasu/onedark.nvim"},
    config = function()
      require('lualine').setup({options = {theme = 'onedark'}})
    end
  }, -- nvim-bufferline
  {
    [1] = "akinsho/nvim-bufferline.lua",
    requires = {"kyazdani42/nvim-web-devicons"},
    config = function()
      local bufferline = require("bufferline")
      bufferline.setup({
        options = {
          view = "multiwindow",
          numbers = "ordinal",
          buffer_close_icon = "",
          modified_icon = "●",
          close_icon = "",
          left_trunc_marker = "",
          right_trunc_marker = "",
          max_name_length = 18,
          max_prefix_length = 15,
          tab_size = 18,
          show_buffer_close_icons = true,
          persist_buffer_sort = true,
          enforce_regular_tabs = false,
          always_show_bufferline = true,
          sort_by = "extension"
        }
      })
    end
  }, -- nvim-tree
  {
    [1] = "kyazdani42/nvim-tree.lua",
    requires = {"kyazdani42/nvim-web-devicons"},
    config = function()
      local tree_cb = require"nvim-tree.config".nvim_tree_callback
      -- following options are the default
      require"nvim-tree".setup {
        -- disables netrw completely
        disable_netrw = false,
        -- hijack netrw window on startup
        hijack_netrw = false,
        -- open the tree when running this setup function
        open_on_setup = false,
        -- will not open on setup if the filetype is in this list
        ignore_ft_on_setup = {},
        -- closes neovim automatically when the tree is the last **WINDOW** in the view
        auto_close = false,
        -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
        open_on_tab = false,
        -- hijacks new directory buffers when they are opened.
        update_to_buf_dir = {
          -- enable the feature
          enable = true,
          -- allow to open the tree if it was previously closed
          auto_open = true
        },
        -- hijack the cursor in the tree to put it at the start of the filename
        hijack_cursor = false,
        -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
        update_cwd = true,
        -- show lsp diagnostics in the signcolumn
        diagnostics = {
          enable = true,
          icons = {hint = "", info = "", warning = "", error = ""}
        },
        -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
        update_focused_file = {
          -- enables the feature
          enable = true,
          -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
          -- only relevant when `update_focused_file.enable` is true
          update_cwd = true,
          -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
          -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
          ignore_list = {}
        },
        -- configuration options for the system open command (`s` in the tree by default)
        system_open = {
          -- the command to run this, leaving nil should work in most cases
          cmd = nil,
          -- the command arguments as a list
          args = {}
        },
        view = {
          -- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
          width = 30,
          -- height of the window, can be either a number (columns) or a string in `%`, for top or bottom side placement
          height = 30,
          -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
          side = "right",
          -- if true the tree will resize itself after opening a file
          auto_resize = false,
          mappings = {
            -- custom only false will merge the list with the default mappings
            -- if true, it will only use your list to set the mappings
            custom_only = true,
            -- list of mappings to set on the tree manually
            list = {
              {key = {"<CR>", "o", "<2-LeftMouse>"}, cb = tree_cb("edit")},
              {key = {"<2-RightMouse>", "<C-]>"}, cb = tree_cb("cd")},
              {key = "<C-v>", cb = tree_cb("vsplit")},
              {key = "<C-x>", cb = tree_cb("split")},
              {key = "<C-t>", cb = tree_cb("tabnew")},
              {key = "<", cb = tree_cb("prev_sibling")},
              {key = ">", cb = tree_cb("next_sibling")},
              {key = "P", cb = tree_cb("parent_node")},
              {key = "<BS>", cb = tree_cb("close_node")},
              {key = "<S-CR>", cb = tree_cb("close_node")},
              {key = "K", cb = tree_cb("first_sibling")},
              {key = "J", cb = tree_cb("last_sibling")},
              {key = "I", cb = tree_cb("toggle_ignored")},
              {key = "H", cb = tree_cb("toggle_dotfiles")},
              {key = "R", cb = tree_cb("refresh")},
              {key = "a", cb = tree_cb("create")},
              {key = "d", cb = tree_cb("remove")},
              {key = "r", cb = tree_cb("rename")},
              {key = "<C-r>", cb = tree_cb("full_rename")},
              {key = "x", cb = tree_cb("cut")},
              {key = "c", cb = tree_cb("copy")},
              {key = "p", cb = tree_cb("paste")},
              {key = "y", cb = tree_cb("copy_name")},
              {key = "Y", cb = tree_cb("copy_path")},
              {key = "gy", cb = tree_cb("copy_absolute_path")},
              {key = "[c", cb = tree_cb("prev_git_item")},
              {key = "]c", cb = tree_cb("next_git_item")},
              {key = "-", cb = tree_cb("dir_up")},
              {key = "s", cb = tree_cb("system_open")},
              {key = "q", cb = tree_cb("close")},
              {key = "g?", cb = tree_cb("toggle_help")}
            }
          }
        }
      }
    end
  }
}
