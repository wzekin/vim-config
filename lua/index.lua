require("global")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("maps").init_maps()
require("options").init_options()
require("plugins").init_plugins()

