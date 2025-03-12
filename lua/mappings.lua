require "nvchad.mappings"

local map = vim.keymap.set
local unmap = vim.keymap.del

map("n", ";", ":", { desc = "CMD enter command mode" })

-- remove nvchad's nvtree config and tie them nearly
unmap("n", "<C-n>")
unmap("n", "<leader>e")
map("n", "<leader>et", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<leader>ef", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

if vim.lsp.inlay_hint then
  map("n", "<leader>uh", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end, { desc = "Toggle Inlay Hints" })
end

map("n", "<leader>mr", function()
  require("render-markdown").toggle()
end, { desc = "Toggle Markdown Rendering" })

map("n", "<leader>mn", ":MemoNew<CR>", { desc = "create a new memo" })
map("n", "<leader>ml", ":Telescope memo list<CR>", { desc = "telescope memo list" })
map("n", "<leader>mg", ":Telescope memo live_grep<CR>", { desc = "telescope memo live grep" })

map(
  "n",
  "<leader>gg",
  "<cmd>lua LazygitToggle()<CR>",
  { noremap = true, silent = true, desc = "Toggle lazygit floating window" }
)
