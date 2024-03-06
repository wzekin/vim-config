local custom = {}
custom["Bekaboo/dropbar.nvim"] = {
	lazy = false,
	config = require("configs.dropbar"),
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
custom["kylechui/nvim-surround"] = {
	lazy = true,
	event = { "CursorMoved", "InsertEnter" },
	config = require("configs.surround"),
}

custom["ray-x/go.nvim"] = {
	lazy = true,
	dependencies = { -- optional packages
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	ft = { "go", "gomod" },
	event = { "CmdlineEnter" },
	build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	config = require("lang.vim-go"),
}

custom["LhKipp/nvim-nu"] = {
	lazy = true,
	ft = "nu",
	build = ":TSInstall nu",
	config = require("configs.nu"),
}

custom["scalameta/nvim-metals"] = {
	lazy = true,
	ft = "scala",
	config = require("configs.metals"),
	dependencies = { "nvim-lua/plenary.nvim" },
}

custom["nvim-pack/nvim-spectre"] = {
	lazy = true,
	event = "VeryLazy",
	config = function()
		require("spectre").setup({})
	end,
	dependencies = { "nvim-lua/plenary.nvim" },
}

custom["folke/tokyonight.nvim"] = {
	lazy = true,
	config = require("configs.tokyonight"),
}

custom["jackMort/ChatGPT.nvim"] = {
	lazy = true,
	event = "VeryLazy",
	config = function()
		local home = vim.fn.expand("$HOME")
		require("chatgpt").setup({
			api_key_cmd = "cat " .. home .. "/.config/chatgpt/key.txt",
		})
	end,
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
}
custom["codeverse.vim"] = {
	dir = "~/.config/nvim/pack/byted/start/codeverse.vim",
	lazy = false,
}
custom["vim.ai"] = {
	dir = "~/.config/nvim/pack/byted/start/vim-ai",
	lazy = false,
}

return custom
