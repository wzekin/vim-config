require("global")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("maps").setup()
require("options").setup()
require("plugins").setup()
require("autocmd").setup()

vim.api.nvim_create_user_command("WQ", "wq", {})
vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Q", "q", {})
vim.api.nvim_create_user_command("Refresh", ":write | edit | TSBufEnable highlight", {})
vim.api.nvim_create_user_command("Compile", ":source init.lua | PackerCompile", {})
