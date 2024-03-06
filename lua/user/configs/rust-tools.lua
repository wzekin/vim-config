return {
	tools = {
		inlay_hints = {
			auto = false,
		},
		server = {
			-- standalone file support
			-- setting it to false may improve startup time
			standalone = false,
			settings = {
				["rust-analyzer"] = {
					checkOnSave = {
						command = "clippy",
					},
					cargo = {
						buildScripts = {
							enable = true,
						},
					},
					procMacro = { enable = true },
				},
			},
		}, -- rust-analyer options
	},
}
