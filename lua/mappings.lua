require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
vim.keymap.set("n", "<leader>mr", function()
  require("render-markdown").toggle()
end, { desc = "Toggle Markdown Rendering" })
