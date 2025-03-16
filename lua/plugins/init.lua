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
  {
    "stevearc/conform.nvim",
    opts = require "lazyconf.conform_opts",
    event = "BufWritePre",
  },
  {
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
  { -- list symbol list in the current buffer.
    "bassamsdata/namu.nvim",
    opts = require "lazyconf.namu_opts",
    cmd = { "Namu symbols" },
  },
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup()
      require("scrollbar.handlers.gitsigns").setup()
    end,
    event = { "BufReadPre", "BufNewFile" },
  },
  {
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
    event = "BufReadPost *.md",
  },
  {
    "kevinhwang91/nvim-bqf", -- preview for quick list items
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
