require "nvchad.options"

local config_dir = "custom"
local scan = require("plenary.scandir").scan_dir -- Requires `nvim-lua/plenary.nvim`

local files = scan(vim.fn.stdpath "config" .. "/lua/" .. config_dir, { depth = 1, add_dirs = false })
for _, file in ipairs(files) do
  local module = file:match "([^/]+)%.lua$"
  if module then
    local ok, err = pcall(require, config_dir .. "." .. module)
    if not ok then
      vim.notify("Error loading " .. module .. ": " .. err, vim.log.levels.ERROR)
    end
  end
end
