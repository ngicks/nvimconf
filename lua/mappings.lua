require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>mr", function()
  require("render-markdown").toggle()
end, { desc = "Toggle Markdown Rendering" })
map(
  "n",
  "<leader>gg",
  "<cmd>lua LazygitToggle()<CR>",
  { noremap = true, silent = true, desc = "Toggle lazygit floating window" }
)
