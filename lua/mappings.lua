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

map("n", "<leader>gg", function()
  require("lazyconf.toggleterm_cmd.lazygit_floating"):toggle()
end, { noremap = true, silent = true, desc = "Toggle lazygit floating window" })
-- luadev
map("n", "<leader>ld", function()
  require("luadev").start()
end, { desc = ":Luadev" })

map("n", "<leader>ll", function()
  require("luadev").exec(vim.api.nvim_get_current_line())
end, { desc = "run current line of lua script" })

local buffer_to_string = function()
  local content = vim.api.nvim_buf_get_lines(0, 0, vim.api.nvim_buf_line_count(0), false)
  return table.concat(content, "\n")
end

map("n", "<leader>lf", function()
  require("luadev").exec(buffer_to_string())
end, { desc = "eval whole current buffer as lua script" })
