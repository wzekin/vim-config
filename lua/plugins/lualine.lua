local M = { "hoob3rt/lualine.nvim" }

M.disable = false
M.after = "nvim-navic"

M.requires = { 'arkav/lualine-lsp-progress' }

function M.config()
  local function search_result()
    local search = vim.fn.searchcount({ maxcount = 0 }) -- maxcount = 0 makes the number not be capped at 99
    local searchCurrent = search.current
    local searchTotal = search.total

    if searchCurrent > 0 and vim.v.hlsearch ~= 0 then
      return searchCurrent .. " / " .. searchTotal
    else
      return ""
    end
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
      lualine_y = { search_result, 'progress' },
      lualine_z = { 'location' }
    },
    -- winbar = {
    --   lualine_a = {},
    --   lualine_b = {},
    --   lualine_c = {
    --     get_winbar
    --   },
    --   lualine_x = {},
    --   lualine_y = {},
    --   lualine_z = {}
    -- }
  }
end

return M
