return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },
  {
    "nvim-lua/plenary.nvim",
  },
  -- lsp
  {
    "neovim/nvim-lspconfig",
    opts = require "configs.lspconfig",
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = require "configs.mason-lspconfig",
  },
  -- telescope
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension "fzf"
    end,
    keys = "<leader>",
  },
  -- visual helper
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    opts = require "configs.treesitter",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPre", "BufNewFile" },
    opts = require "configs.treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    event = "BufReadPost *.md",
    opts = require "configs.render-md",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "kevinhwang91/nvim-bqf", -- preview for quick list items
    event = "QuickFixCmdPre",
    opts = require "configs.bqf",
  },
  -- util / command
  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    version = "*",
    config = true,
  },
  -- memo
  {
    "glidenote/memolist.vim",
    config = function()
      require "configs.memolist"
    end,
    cmd = { "MemoNew" },
  },
  {
    "delphinus/telescope-memo.nvim",
    config = function()
      require "configs.telescope-memo"
    end,
    dependencies = { "glidenote/memolist.vim", "nvim-telescope/telescope.nvim" },
    cmd = { "Telescope memo list", "Telescope memo live_grep" },
  },
}
