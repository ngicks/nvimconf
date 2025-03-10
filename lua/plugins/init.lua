return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "nvim-lua/plenary.nvim",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "markdown",
        "go",
        "rust",
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    config = function()
      require "configs.render-markdown"
    end,
    dependencies = { "nvim-treesitter/nvim-treesitter" }, -- Ensure Treesitter is installed
  },
}
