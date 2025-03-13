-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "chadracula-evondev",
  theme_toggle = { "chadracula-evondev", "rosepine-dawn" },
  hl_add = {
    CUR_BUF_PATH = { -- use color mutation so that it can blend in on any theme.
      fg = "#A9A9A9",
      bg = "#3A3A3A",
    },
  },
}

M.term = {
  float = {
    row = 0.05,
    col = 0.05,
    width = 0.9,
    height = 0.8,
  },
}

M.ui = {
  statusline = {
    theme = "default",
    order = { "mode", "f", "ss", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "cursor" },
    modules = {
      f = "%#CUR_BUF_PATH#" .. "%F", -- filename of current buffer
      ss = " ", -- short space
    },
  },
}

return M
