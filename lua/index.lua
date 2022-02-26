require("global")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("maps").init_maps()
require("options").init_options()
require("plugins").init_plugins()

vim.api.nvim_add_user_command("WQ", "wq", {})
vim.api.nvim_add_user_command("Wq", "wq", {})
vim.api.nvim_add_user_command("W", "w", {})
vim.api.nvim_add_user_command("Q", "q", {})
vim.api.nvim_add_user_command("Refresh",
                              ":write | edit | TSBufEnable highlight", {})
