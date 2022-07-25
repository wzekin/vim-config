local M = {}
local plugins = { { [1] = "wbthomason/packer.nvim", opt = true } }

local function scandir(path)
  local uv = vim.loop
  local handle = uv.fs_scandir(path)
  if type(handle) == 'string' then
    vim.api.nvim_err_writeln(handle)
    return
  end

  local res = {}

  while true do
    local name, t = uv.fs_scandir_next(handle)
    if not name then
      break
    end

    if t == "file" then
      table.insert(res, name)
    end
  end

  return res
end

function M.setup()
  -- init packer
  local install_path = tostring(vim.fn.stdpath("data")) ..
      "/site/pack/packer/opt/packer.nvim"
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.cmd("!git clone https://github.com/wbthomason/packer.nvim " ..
      tostring(install_path))
  end
  vim.cmd("packadd packer.nvim")

  local packer = require("packer")

  local _plugins = scandir(vim.fn.stdpath("config") .. "/lua/plugins")
  for ____, p in pairs(_plugins) do
    local name, ext = p:match "([^.]*).(.*)"
    if ext == "lua" and name ~= "init" then
      table.insert(plugins, require("plugins." .. name))
    end
  end

  packer.init({ ensure_dependencies = true })
  packer.use(plugins)
end

return M
