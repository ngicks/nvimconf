local scan = require("plenary.scandir").scan_dir

local M = {}

M.load_local_dir = function(relative_path, hard_error)
  local files = scan(vim.fn.stdpath "config" .. "/lua/" .. relative_path, { depth = 1, add_dirs = false })
  for _, file in ipairs(files) do
    local module = file:match "([^/]+)%.lua$"
    if module then
      local mod_path = string.gsub(relative_path, "/", ".") .. "." .. module
      if hard_error then
        require(mod_path)
      else
        local ok, err = pcall(require, mod_path)
        if not ok then
          vim.notify("Error loading " .. module .. ": " .. err, vim.log.levels.ERROR)
        end
      end
    end
  end
end

return M
