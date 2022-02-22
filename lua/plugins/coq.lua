local M = {"ms-jpq/coq_nvim"}

M.branch = "coq"

M.requires = {
  {[1] = "ms-jpq/coq.artifacts", branch = "artifacts"},
  {[1] = "ms-jpq/coq.thirdparty", branch = "3p"}
}

function M.setup()
  vim.g.coq_settings = {auto_start = "shut-up"}
end

function M.config()
  -- local coq = require("coq")
  require("coq_3p") {
    {src = "nvimlua", short_name = "nLUA", conf_only = true},
    {src = "copilot", short_name = "COP", accept_key = "<c-f>"}
  }
end

return M
