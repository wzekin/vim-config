local M = {}
local plugins = {
    {
        [1] = "windwp/nvim-autopairs",
        config = function()
            local npairs = require("nvim-autopairs")
            npairs:setup({check_ts = true})
        end
    },
    {
        [1] = "hoob3rt/lualine.nvim",
        requires = {"kyazdani42/nvim-web-devicons"},
        config = function()
            local lualine = require("lualine")
            local colors = require("gruvbox.colors")

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
                        normal = {c = {fg = colors.light0, bg = colors.dark0}},
                        inactive = {c = {fg = colors.light0, bg = colors.dark0}}
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
                color = {fg = colors.bright_blue}, -- Sets highlighting of component
                left_padding = 0 -- We don't need space before this
            }

            ins_left {
                -- mode component
                function()
                    -- auto change color according to neovims mode
                    local mode_color = {
                        n = colors.bright_red,
                        i = colors.bright_green,
                        v = colors.bright_blue,
                        [""] = colors.bright_blue,
                        V = colors.bright_blue,
                        c = colors.bright_purple,
                        no = colors.bright_red,
                        s = colors.bright_orange,
                        S = colors.bright_orange,
                        [""] = colors.bright_orange,
                        ic = colors.bright_yellow,
                        R = colors.bright_purple,
                        Rv = colors.bright_purple,
                        cv = colors.bright_red,
                        ce = colors.bright_red,
                        r = colors.bright_aqua,
                        rm = colors.bright_aqua,
                        ["r?"] = colors.bright_aqua,
                        ["!"] = colors.bright_red,
                        t = colors.bright_red
                    }
                    local color = mode_color[vim.fn.mode()]
                    if color == nil then
                        color = colors.bright_red
                    end
                    vim.api.nvim_command("hi! LualineMode guifg=" .. color .. " guibg=" .. colors.dark0)
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
                color = {fg = colors.bright_purple, gui = "bold"}
            }

            ins_left {"location"}

            ins_left {"progress", color = {fg = colors.light0, gui = "bold"}}

            ins_left {
                "diagnostics",
                sources = {"nvim_lsp"},
                symbols = {error = " ", warn = " ", info = " "},
                color_error = colors.bright_red,
                color_warn = colors.bright_yellow,
                color_info = colors.bright_aqua
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
                color = {fg = colors.bright_green, gui = "bold"}
            }

            ins_right {
                "fileformat",
                upper = true,
                icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
                color = {fg = colors.bright_green, gui = "bold"}
            }

            ins_right {
                "branch",
                icon = "",
                condition = conditions.check_git_workspace,
                color = {fg = colors.bright_purple, gui = "bold"}
            }

            ins_right {
                "diff",
                -- Is it me or the symbol for modified us really weird
                symbols = {added = " ", modified = "柳 ", removed = " "},
                color_added = colors.bright_green,
                color_modified = colors.bright_orange,
                color_removed = colors.bright_red,
                condition = conditions.hide_in_width
            }

            ins_right {
                function()
                    return "▊"
                end,
                color = {fg = colors.bright_blue},
                right_padding = 0
            }

            -- Now don't forget to initialize lualine
            lualine.setup(config)
        end
    },
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
                        mappings = true,
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
    {
        [1] = "hrsh7th/nvim-compe",
        requires = {
            "neovim/nvim-lspconfig",
            "hrsh7th/vim-vsnip",
            "rafamadriz/friendly-snippets"
        },
        config = function()
            local servers = {
                "rust_analyzer",
                "clangd",
                "gopls",
                "jsonls",
                "vimls",
                "pyright",
                "tsserver"
            }
            local nvim_lsp = require("lspconfig")
            for ____, lsp in ipairs(servers) do
                if type(lsp) == "string" then
                    nvim_lsp[lsp].setup({})
                else
                    nvim_lsp[lsp[1]].setup(lsp.setup)
                end
            end
            local compe = require("compe")
            compe.setup(
                {
                    enabled = true,
                    autocomplete = true,
                    debug = true,
                    min_length = 1,
                    preselect = "enable",
                    throttle_time = 80,
                    source_timeout = 200,
                    incomplete_delay = 400,
                    max_abbr_width = 100,
                    max_kind_width = 100,
                    max_menu_width = 100,
                    documentation = true,
                    source = {
                        path = true,
                        buffer = true,
                        calc = true,
                        nvim_lsp = true,
                        nvim_lua = true,
                        vsnip = true,
                        ["nvim-treesitter"] = true
                    }
                }
            )
        end
    },
    {[1] = "npxbr/glow.nvim", run = ":GlowInstall"},
    {
        [1] = "sbdchd/neoformat",
        config = function()
            vim.g.neoformat_enabled_python = {"isort", "black"}
            vim.g.neoformat_enabled_typescript = {"prettier"}
            vim.g.neoformat_enabled_typescriptreact = {"prettier"}
            vim.g.neoformat_run_all_formatters = 1
        end
    },
    {
        [1] = "b3nj5m1n/kommentary",
        setup = function()
            vim.g.kommentary_create_default_mappings = true
        end,
        config = function()
        end
    },
    {
        [1] = "kyazdani42/nvim-tree.lua",
        requires = {"kyazdani42/nvim-web-devicons"},
        config = function()
            vim.g.nvim_tree_side = "right"
            vim.g.nvim_tree_width = 30
            vim.g.nvim_tree_ignore = {".git", "node_modules", ".cache"}
            vim.g.nvim_tree_auto_open = 0
            vim.g.nvim_tree_auto_close = 1
            vim.g.nvim_tree_quit_on_open = 1
            vim.g.nvim_tree_follow = 1
            vim.g.nvim_tree_indent_markers = 1
            vim.g.nvim_tree_hide_dotfiles = 1
            vim.g.nvim_tree_git_hl = 1
            vim.g.nvim_tree_root_folder_modifier = ":~"
            vim.g.nvim_tree_tab_open = 1
            vim.g.nvim_tree_width_allow_resize = 1
            vim.g.nvim_tree_show_icons = {git = 1, folders = 1, files = 1}
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
        requires = {"nvim-treesitter/nvim-treesitter-textobjects"},
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
                    }
                }
            )
        end
    },
    {
        [1] = "easymotion/vim-easymotion",
        config = function()
            vim.g.EasyMotion_do_mapping = 0
            vim.g.EasyMotion_smartcase = 1
        end
    },
    {
        [1] = "npxbr/gruvbox.nvim",
        requires = {"rktjmp/lush.nvim"}
    },
    {[1] = "nvim-telescope/telescope.nvim", requires = {"nvim-lua/popup.nvim", "nvim-lua/plenary.nvim"}},
    {
        [1] = "blackCauldron7/surround.nvim",
        config = function()
            require("surround"):setup()
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
    packer.init({ensure_dependencies = true})
    packer.use(plugins)
end
return M
