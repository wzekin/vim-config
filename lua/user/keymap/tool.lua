local bind = require("keymap.bind")
local map_callback = bind.map_callback

return {
	["n|<leader>fp"] = nil,
	["n|<leader>fw"] = map_callback(function()
			require("search").open({ collection = "pattern" })
		end)
		:with_noremap()
		:with_silent()
		:with_desc("tool: Find patterns"),
}
