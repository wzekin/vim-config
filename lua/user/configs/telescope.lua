return {
	defaults = {
		mappings = {
			i = {
				["<esc>"] = require("telescope.actions").close,
				["<C-j>"] = require("telescope.actions").move_selection_next,
				["<C-k>"] = require("telescope.actions").move_selection_previous,
			},
			n = {
				["q"] = require("telescope.actions").close,
				["s"] = { "Vs", type = "command" },
				["<C-j>"] = require("telescope.actions").move_selection_next,
				["<C-k>"] = require("telescope.actions").move_selection_previous,
			},
		},
	},
}
