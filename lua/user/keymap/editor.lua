local bind = require("keymap.bind")
local map_cr = bind.map_cr

return {
	["n|<leader>x"] = map_cr("BufDelOthers"):with_noremap():with_silent():with_desc("buffer: Close other buffers"),
}
