-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

local nvlsp = require "nvchad.configs.lspconfig"

local servers = {
  html = {},
  cssls = {},
  pyright = {},
  clangd = {},
  rust_analyzer = {},
}

local default_setups = {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

local sepecial_setups = { "lazyconf.lsp_setup.go", "lazyconf.lsp_setup.ts" }

for _, setup in ipairs(sepecial_setups) do
  require(setup).config(servers, default_setups)
end

-- lsps with default config
for name, lsp in pairs(servers) do
  lspconfig[name].setup(vim.tbl_deep_extend("keep", lsp, default_setups))
end

for _, setup in ipairs(sepecial_setups) do
  local lsp_cfg = require(setup)
  if lsp_cfg.setup then
    lsp_cfg.setup()
  end
end

return {
  inlay_hints = { enabled = true },
}
