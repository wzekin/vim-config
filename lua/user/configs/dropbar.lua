local M = {}

function M.setup() 
	require("dropbar").setup({
		general = {
			update_interval = 10,
		},
	})
	vim.ui.select = require("dropbar.utils.menu").select
end

return M
