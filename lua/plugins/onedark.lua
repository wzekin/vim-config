local M = {"navarasu/onedark.nvim"}

M.requires = {"hoob3rt/lualine.nvim"}

function M.config()

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

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
                                                       vim.lsp.handlers
                                                           .signature_help,
                                                       {border = 'rounded'})

  require('onedark').load()
  require('lualine').setup({options = {theme = 'onedark'}})
end

return M
