vim.api.nvim_set_keymap("n", "q:", "", {})

vim.api.nvim_create_user_command("CloseAllFloatingWindows", function()
	local closed_windows = {}
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local config = vim.api.nvim_win_get_config(win)
		if config.relative ~= "" then -- is_floating_window?
			vim.api.nvim_win_close(win, false) -- do not force
			table.insert(closed_windows, win)
		end
	end
	vim.notify(string.format("Closed %d windows: %s", #closed_windows, vim.inspect(closed_windows)))
end, {})

return vim.tbl_extend(
	"force",
	require("user.keymap.core"),
	require("user.keymap.completion").plug_map,
	require("user.keymap.editor"),
	require("user.keymap.lang"),
	require("user.keymap.tool"),
	require("user.keymap.ui")
)
