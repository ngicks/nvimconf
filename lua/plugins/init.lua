return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "lazyconf.conform",
  },
  {
    "nvim-lua/plenary.nvim",
  },
  -- lsp
  {
    "neovim/nvim-lspconfig",
    opts = require "lazyconf.lspconfig",
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = require "lazyconf.mason-lspconfig",
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
    opts = require "lazyconf.treesitter",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPre", "BufNewFile" },
    opts = require "lazyconf.treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    event = "BufReadPost *.md",
    opts = require "lazyconf.render-md",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "kevinhwang91/nvim-bqf", -- preview for quick list items
    event = "QuickFixCmdPre",
    opts = require "lazyconf.bqf",
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
      require "lazyconf.memolist"
    end,
    cmd = { "MemoNew" },
  },
  {
    "delphinus/telescope-memo.nvim",
    config = function()
      require "lazyconf.telescope-memo"
    end,
    dependencies = { "glidenote/memolist.vim", "nvim-telescope/telescope.nvim" },
    cmd = { "Telescope memo list", "Telescope memo live_grep" },
  },
}
