local M = {}

local options = {
    termguicolors = true,
    expandtab = true,
    tabstop = 2,
    shiftwidth = 2,
    softtabstop = 2,
    nocompatible = true,
    wildmenu = true,
    hidden = true,
    background = "dark",
    t_Co = 256,
    laststatus = 2,
    number = true,
    cursorline = true,
    cursorcolumn = true,
    hlsearch = true,
    foldmethod = "expr",
    foldexpr = "nvim_treesitter#foldexpr()",
    nofoldenable = true,
    history = 2000,
    undolevels = 1000,
    undoreload = 10000,
    undofile = true,
    incsearch = true,
    relativenumber = "number",
    completeopt = "menuone,noselect"
}

function M.init_options()
    for key, value in pairs(options) do
        if type(key) == "string" then
            pcall(vim.api.nvim_set_option, key, value)
            pcall(vim.api.nvim_win_set_option, 0, key, value)
            pcall(vim.api.nvim_buf_set_option, 0, key, value)
        end
    end
end

return M
