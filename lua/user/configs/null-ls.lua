local function typos()
	local null_ls = require("null-ls")

	local typo = {
		name = "typos-cli",
		method = null_ls.methods.DIAGNOSTICS,
		filetypes = { "go" },
		-- null_ls.generator creates an async source
		-- that spawns the command with the given arguments and options
		generator = null_ls.generator({
			command = "typos",
			args = { "--format", "json", "-" },
			to_stdin = true,
			from_stderr = true,
			-- choose an output format (raw, json, or line)
			format = "line",
			-- use helpers to parse the output from string matchers,
			-- or parse it manually with a function
			on_output = function(params)
				local data = vim.json.decode(params)
				return {
					row = data.line_num,
					end_row = data.line_num,
					col = data.byte_offset + 1,
					end_col = data.byte_offset + string.len(data.typo) + 1,
					message = "`" .. data.typo .. "` should be `" .. data.corrections[1] .. "`",
				}
			end,
		}),
	}

	return typo
end

return {
	sources = {
		typos(),
	},
}
