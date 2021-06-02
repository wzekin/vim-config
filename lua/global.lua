local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col(".") - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<c-n>"
    elseif vim.fn.call("vsnip#available", {1}) == 1 then
        return t "<plug>(vsnip-expand-or-jump)"
    elseif check_back_space() then
        return t "<tab>"
    else
        return vim.fn["compe#complete"]()
    end
end
_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
        return t "<Plug>(vsnip-jump-prev)"
    else
        -- If <S-Tab> is not working in your terminal, change it to <C-h>
        return t "<S-Tab>"
    end
end

_G.CloseAllSavedBuffer = function()
    local function is_valid(buf_num)
        if ((not buf_num) or (buf_num < 1)) or (not vim.api.nvim_buf_is_valid(buf_num)) then
            return false
        end
        local listed = vim.api.nvim_buf_get_option(buf_num, "buflisted") == true
        local not_modified = vim.api.nvim_buf_get_option(buf_num, "modified") == false
        return listed and not_modified
    end
    local buffers = vim.api.nvim_list_bufs()
    local current = vim.api.nvim_get_current_buf()
    if not is_valid(current) then
        vim.cmd("wincmd w")
        vim.cmd("ene!")
    end
    for ____, buf in ipairs(buffers) do
        if is_valid(buf) and (current ~= buf) then
            vim.api.nvim_buf_delete(buf, {force = true})
        end
    end
end

_G.SaveAndPause = function()
    local current = vim.api.nvim_get_current_buf()
    if vim.api.nvim_buf_get_option(current, "modified") then
        vim.cmd("w")
    end
    vim.cmd("sus")
end
