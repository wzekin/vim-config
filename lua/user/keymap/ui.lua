local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cmd = bind.map_cmd
return {
	["n|<leader><leader>"] = map_cmd(":"):with_noremap():with_desc("Command!!"),
	["i|jk"] = map_cmd("<Esc>"):with_noremap():with_silent():with_desc("Command!!"),
	["c|<C-i>"] = map_cmd("<Up>"):with_noremap():with_desc("up"),
	["c|<C-o>"] = map_cmd("<Down>"):with_noremap():with_desc("down"),
}
