return {
	defaults = {
		mappings = {
			i = {
				["<esc>"] = require("telescope.actions").close,
				["<A-i>"] = require("telescope.actions").move_selection_next,
				["<A-o>"] = require("telescope.actions").move_selection_previous,
			},
			n = {
				["<esc>"] = require("telescope.actions").close,
				["<A-i>"] = require("telescope.actions").move_selection_next,
				["<A-o>"] = require("telescope.actions").move_selection_previous,
			},
		},
	},
}
