vim.api.nvim_set_keymap("n", "q:", "", {})

local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cr
local map_cmd = bind.map_cmd

return {
	["n|<leader>x"] = map_cr("BufDelOthers"):with_noremap():with_silent():with_desc("buffer: Close other buffers"),
	["n|<leader>bb"] = map_cr("BufferLinePick"):with_noremap():with_silent():with_desc("buffer: Pick Buffer"),
}
