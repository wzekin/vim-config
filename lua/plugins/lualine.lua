local M = { "hoob3rt/lualine.nvim" }

M.disable = false
M.after = "nvim-navic"

M.requires = { 'arkav/lualine-lsp-progress' }

function M.config()
  local function get_winbar()
    local navic = require("nvim-navic")
    local status_web_devicons_ok, web_devicons = pcall(require, 'nvim-web-devicons')

    local hl_winbar_path = 'WinBarPath'
    local hl_winbar_file = 'WinBarFile'
    local hl_winbar_file_icon = 'WinBarFileIcon'

    local function isempty(s)
      return s == nil or s == ''
    end

    local file_path = vim.fn.expand('%:~:.:h')
    local filename = vim.fn.expand('%:t')
    local file_type = vim.fn.expand('%:e')
    local value = ''
    local file_icon = ''

    file_path = file_path:gsub('^%.', '')
    file_path = file_path:gsub('^%/', '')

    if not isempty(filename) then
      local default = false

      if isempty(file_type) then
        file_type = ''
        default = true
      end

      if status_web_devicons_ok then
        file_icon = web_devicons.get_icon(filename, file_type, { default = default })
        hl_winbar_file_icon = "DevIcon" .. file_type
      end

      if not file_icon then
        file_icon = ''
      end

      file_icon = '%#' .. hl_winbar_file_icon .. '#' .. file_icon .. ' %*'

      value = ' '
      local file_path_list = {}
      local _ = string.gsub(file_path, '[^/]+', function(w)
        table.insert(file_path_list, w)
      end)

      for i = 1, #file_path_list do
        value = value .. '%#' .. hl_winbar_path .. '#' .. file_path_list[i] .. ' > %*'
      end
      value = value .. file_icon
      value = value .. '%#' .. hl_winbar_file .. '#' .. filename .. '%*'
    end

    if not isempty(value) and navic.is_available() then
      local navic_data = navic.get_location()
      if not isempty(navic_data) then
        value = value .. ' > ' .. navic.get_location()
      end
    end
    return value
  end

  require('lualine').setup {
    options = {
      theme = 'onedark',
      globalstatus = true,
      refresh = {
        statusline = 500,
        tabline = 500,
        winbar = 500,
      },
      disabled_filetypes = {
        statusline = {},
        winbar = {
          'help',
          'startify',
          'dashboard',
          'packer',
          'neogitstatus',
          'NvimTree',
          'Trouble',
          'alpha',
          'lir',
          'Outline',
          'spectre_panel',
          'toggleterm',
          'qf',
        },
      },
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { 'lsp_progress' },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' }
    },
    winbar = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        get_winbar
      },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {}
    }
  }
end

return M
