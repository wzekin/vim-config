local bind = require("keymap.bind")
local map_cr = bind.map_cr
return {
	["n|<leader>bb"] = map_cr("BufferLinePick"):with_noremap():with_desc("buffer: PickBffer"),
}
