local bind = require("keymap.bind")
local map_callback = bind.map_callback
local map_cu = bind.map_cu

local last_search = {}
local function resume_do(func_name, f)
	return function(opts)
		opts = opts or {}
		local telescope = require("telescope.builtin")
		if last_search[func_name] == nil then
			if f == nil then
				telescope[func_name](opts)
			else
				f()
			end
		else
			local pickers = require("telescope.pickers")
			local p_window = require("telescope.pickers.window")
			local conf = require("telescope.config").values
			local picker = last_search[func_name]
			if picker.layout_strategy == conf.layout_strategy then
				picker.layout_strategy = nil
			end
			if picker.get_window_options == p_window.get_window_options then
				picker.get_window_options = nil
			end
			picker.previewer = picker.all_previewers
			if picker.hidden_previewer then
				picker.hidden_previewer = nil
				opts.previewer = vim.F.if_nil(opts.previewer, false)
			end
			picker:clear_completion_callbacks()
			opts.resumed_picker = true
			if picker.cache_picker.cached_prompt ~= "" then
				opts.initial_mode = "normal" -- set normal
			else
				opts.initial_mode = "insert" -- set normal
			end
			pickers.new(opts, picker):find()
		end
		local prompt_bufnr = vim.api.nvim_get_current_buf()
		vim.api.nvim_create_augroup("resume_do", {})
		vim.api.nvim_create_autocmd("BufLeave", {
			buffer = prompt_bufnr,
			group = "resume_do",
			once = true,
			callback = function(args)
				local cached_pickers = require("telescope.state").get_global_key("cached_pickers") or {}
				last_search[func_name] = cached_pickers[1]
				vim.api.nvim_clear_autocmds({ group = "resume_do" })
			end,
		})
	end
end

local function grep_string()
	local word
	local visual = vim.fn.mode() == "v"

	if visual == true then
		local saved_reg = vim.fn.getreg("v")
		vim.cmd([[noautocmd sil norm "vy]])
		local sele = vim.fn.getreg("v")
		vim.fn.setreg("v", saved_reg)
		word = sele
	else
		word = vim.fn.expand("<cword>")
	end

	return resume_do("grep_string " .. word:gsub("\n", "\\n"), function(opts)
		require("telescope.builtin").grep_string(opts)
	end)
end

return {
	["n|<leader>fW"] = map_callback(grep_string()):with_noremap():with_silent():with_desc("find: Current word"),
	["n|<leader>fw"] = map_callback(resume_do("live_grep_args", function(opts)
			require("telescope").extensions.live_grep_args.live_grep_args(opts)
		end))
		:with_noremap()
		:with_silent()
		:with_desc("find: Word in project"),
	["n|<leader>fe"] = map_callback(resume_do("oldfiles"))
		:with_noremap()
		:with_silent()
		:with_desc("find: File by history"),
	["n|<leader>ff"] = map_callback(resume_do("find_files"))
		:with_noremap()
		:with_silent()
		:with_desc("find: File in project"),
	["n|<leader>fs"] = nil,
}
