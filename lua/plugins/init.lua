return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    opts = require "configs.lspconfig",
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = require "configs.mason-lspconfig",
  },
  {
    "nvim-lua/plenary.nvim",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufWritePre",
    opts = require "configs.treesitter",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufWritePre",
    opts = require "configs.treesitter-context",
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    event = "VeryLazy",
    opts = require "configs.render-md",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true,
  },
  {
    "glidenote/memolist.vim",
    event = "VeryLazy",
    config = function()
      require "configs.memolist"
    end,
  },
  {
    "delphinus/telescope-memo.nvim",
    config = function()
      require "configs.telescope-memo"
    end,
    dependencies = { "glidenote/memolist.vim", "nvim-telescope/telescope.nvim" },
  },
}
