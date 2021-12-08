return {
  -- onedark
  {
    [1] = "navarasu/onedark.nvim"
  },
  -- lualine
  {
    [1] = "hoob3rt/lualine.nvim",
    requires = {"kyazdani42/nvim-web-devicons", "navarasu/onedark.nvim"},
    config = function()
      local lualine = require("lualine")
      local colors = require("onedark.colors")

      local conditions = {
        buffer_not_empty = function()
          return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
        end,
        hide_in_width = function()
          return vim.fn.winwidth(0) > 80
        end,
        check_git_workspace = function()
          local filepath = vim.fn.expand("%:p:h")
          local gitdir = vim.fn.finddir(".git", filepath .. ";")
          return gitdir and #gitdir > 0 and #gitdir < #filepath
        end
      }
      local config = {
        options = {
          -- Disable sections and component separators
          component_separators = "",
          section_separators = "",
          theme = {
            -- We are going to use lualine_c an lualine_x as left and
            -- right section. Both are highlighted by c theme .  So we
            -- are just setting default looks o statusline
            normal = {c = {fg = colors.fg, bg = colors.bg0}},
            inactive = {c = {fg = colors.fg, bg = colors.bg0}}
          }
        },
        sections = {
          -- these are to remove the defaults
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          -- These will be filled later
          lualine_c = {},
          lualine_x = {}
        },
        inactive_sections = {
          -- these are to remove the defaults
          lualine_a = {},
          lualine_v = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {},
          lualine_x = {}
        }
      }
      -- Inserts a component in lualine_c at left section
      local function ins_left(component)
        table.insert(config.sections.lualine_c, component)
      end

      -- Inserts a component in lualine_x ot right section
      local function ins_right(component)
        table.insert(config.sections.lualine_x, component)
      end

      ins_left {
        function()
          return "▊"
        end,
        color = {fg = colors.blue}, -- Sets highlighting of component
        left_padding = 0 -- We don't need space before this
      }

      ins_left {
        -- mode component
        function()
          -- auto change color according to neovims mode
          local mode_color = {
            n = colors.red,
            i = colors.green,
            v = colors.blue,
            [""] = colors.blue,
            V = colors.blue,
            c = colors.purple,
            no = colors.red,
            s = colors.yellow,
            S = colors.yellow,
            [""] = colors.yellow,
            ic = colors.yellow,
            R = colors.purple,
            Rv = colors.purple,
            cv = colors.red,
            ce = colors.red,
            r = colors.cyan,
            rm = colors.cyan,
            ["r?"] = colors.cyan,
            ["!"] = colors.red,
            t = colors.red
          }
          local color = mode_color[vim.fn.mode()]
          if color == nil then
            color = colors.red
          end
          vim.api.nvim_command("hi! LualineMode guifg=" .. color .. " guibg=" .. colors.bg0)
          return ""
        end,
        color = "LualineMode",
        left_padding = 0
      }

      ins_left {
        -- filesize component
        function()
          local function format_file_size(file)
            local size = vim.fn.getfsize(file)
            if size <= 0 then
              return ""
            end
            local sufixes = {"b", "k", "m", "g"}
            local i = 1
            while size > 1024 do
              size = size / 1024
              i = i + 1
            end
            return string.format("%.1f%s", size, sufixes[i])
          end
          local file = vim.fn.expand("%:p")
          if string.len(file) == 0 then
            return ""
          end
          return format_file_size(file)
        end,
        condition = conditions.buffer_not_empty
      }

      ins_left {
        "filename",
        condition = conditions.buffer_not_empty,
        color = {fg = colors.purple, gui = "bold"}
      }

      ins_left {"location"}

      ins_left {"progress", color = {fg = colors.fg, gui = "bold"}}

      ins_left {
        "diagnostics",
        sources = {"nvim_lsp"},
        symbols = {error = " ", warn = " ", info = " "},
        color_error = colors.red,
        color_warn = colors.yellow,
        color_info = colors.cyan
      }

      -- Insert mid section. You can make any number of sections in neovim :)
      -- for lualine it's any number greater then 2
      ins_left {
        function()
          return "%="
        end
      }

      ins_left {
        -- Lsp server name .
        function()
          local msg = "No Active Lsp"
          local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
          local clients = vim.lsp.get_active_clients()
          if next(clients) == nil then
            return msg
          end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return client.name
            end
          end
          return msg
        end,
        icon = " LSP:",
        color = {fg = "#ffffff", gui = "bold"}
      }

      -- Add components to right sections
      ins_right {
        "o:encoding", -- option component same as &encoding in viml
        upper = true, -- I'm not sure why it's upper case either ;)
        condition = conditions.hide_in_width,
        color = {fg = colors.green, gui = "bold"}
      }

      ins_right {
        "fileformat",
        upper = true,
        icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
        color = {fg = colors.green, gui = "bold"}
      }

      ins_right {
        "branch",
        icon = "",
        condition = conditions.check_git_workspace,
        color = {fg = colors.purple, gui = "bold"}
      }

      ins_right {
        "diff",
        -- Is it me or the symbol for modified us really weird
        symbols = {added = " ", modified = "柳 ", removed = " "},
        color_added = colors.green,
        color_modified = colors.yellow,
        color_removed = colors.red,
        condition = conditions.hide_in_width
      }

      ins_right {
        function()
          return "▊"
        end,
        color = {fg = colors.blue},
        right_padding = 0
      }

      -- Now don't forget to initialize lualine
      lualine.setup(config)
    end
  },
  -- nvim-bufferline
  {
    [1] = "akinsho/nvim-bufferline.lua",
    requires = {"kyazdani42/nvim-web-devicons"},
    config = function()
      local bufferline = require("bufferline")
      bufferline.setup(
        {
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
        }
      )
    end
  },
  -- nvim-tree
  {
    [1] = "kyazdani42/nvim-tree.lua",
    requires = {"kyazdani42/nvim-web-devicons"},
    config = function()
      local tree_cb = require "nvim-tree.config".nvim_tree_callback
      -- following options are the default
      require "nvim-tree".setup {
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
          icons = {
            hint = "",
            info = "",
            warning = "",
            error = ""
          }
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
