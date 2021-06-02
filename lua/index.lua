--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("global")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("maps").init_maps()
require("options").init_options()
require("plugins").init_plugins()

if os.getenv("IS_WSL") == "1" then
    vim.g.clipboard = {
        name = "myClipboard",
        copy = {
            ["+"] = "win32yank.exe -i",
            ["*"] = "win32yank.exe -i"
        },
        paste = {
            ["+"] = "win32yank.exe -o --lf",
            ["*"] = "win32yank.exe -o --lf"
        },
        cache_enabled = 1
    }
end
