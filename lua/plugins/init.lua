-- General rule:
--
-- lists every plugins
-- opts, configs, inits may be stored in separate lua scripts.
-- Each script file may have name its plugin name with suffix _opts, _configs, etc.
-- Scripts may have nvim suffix or prefix omitted in their name.
--
-- orders are
--  - SPEC LOADING
--    - dependencies, enabled, cond, priority
--  - SPEC SETUP
--    - init, opts, config, main, build
--  - SPEC LAZY LOADING
--    - lazy, event, cmd, ft, keys
--  - SPEC VERSIONING
--    - branch, tag, commit, version, pin, submodule
--  - SPEC ADVANCED
--    - optional, specs, module, import
return {
  { -- utils
    "nvim-lua/plenary.nvim",
  },
  -- lsp
  {
    "neovim/nvim-lspconfig",
    opts = require "lazyconf.lspconfig_opts",
    config = function(p, opt)
      require "lazyconf.lspconfig_config"(p, opt)
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = require "lazyconf.mason-lspconfig_opts",
  },
  { -- format file types where lsp is not available.
    "stevearc/conform.nvim",
    opts = require "lazyconf.conform_opts",
    event = "BufWritePre",
  },
  { -- inject non-lsp tools as lsp client
    "mfussenegger/nvim-lint",
    config = function()
      require "lazyconf.lint_config"
    end,
    event = "BufWritePost",
  },
  { -- display lsp symbols, diagnoses
    "folke/trouble.nvim",
    opts = require "lazyconf.trouble_opts",
    event = { "LspAttach" },
    cmd = "Trouble",
  },
  { -- list symbols in the current buffer in floating window. search and jump
    "bassamsdata/namu.nvim",
    opts = require "lazyconf.namu_opts",
    event = { "LspAttach" },
  },
  -- telescope
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension "fzf"
    end,
    build = "make",
    keys = "<leader>",
  },
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    config = function()
      require "lazyconf.telescope-live-grep-args_config"
    end,
  },
  -- visual helper
  {
    "nvim-treesitter/nvim-treesitter",
    opts = require "lazyconf.treesitter_opts",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = require "lazyconf.treesitter-context_opts",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup()
      require("scrollbar.handlers.gitsigns").setup()
    end,
    event = { "BufReadPre", "BufNewFile" },
  },
  { -- display breadcrumb list at top of the buffer.
    "Bekaboo/dropbar.nvim",
    dependencies = { "nvim-telescope/telescope-fzf-native.nvim" },
    config = function()
      require "lazyconf.dropbar_config"
    end,
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = require "lazyconf.render-markdown_opts",
    event = { "BufReadPost *.md", "BufReadPost *.mdx" },
  },
  { -- preview for quick list items
    "kevinhwang91/nvim-bqf",
    dependencies = { "junegunn/fzf" },
    opts = require "lazyconf.bqf_opts",
    -- Opening quickfix window itself can't be hooked? fall back to VeryLazy to ensure it works
    event = { "QuickFixCmdPre", "VeryLazy" },
    cmd = { "Telescope", "Telescope live_grep" },
  },
  {
    "akinsho/toggleterm.nvim",
    config = true,
  },
  -- memo
  {
    "glidenote/memolist.vim",
    config = function()
      require "lazyconf.memolist_config"
    end,
    cmd = { "MemoNew" },
  },
  {
    "delphinus/telescope-memo.nvim",
    dependencies = { "glidenote/memolist.vim", "nvim-telescope/telescope.nvim" },
    config = function()
      require "lazyconf.telescope-memo_config"
    end,
    cmd = { "Telescope memo list", "Telescope memo live_grep" },
  },
  -- debug
  { -- gets buffer content then eval in nvim as lua script.
    "bfredl/nvim-luadev",
  },
}
