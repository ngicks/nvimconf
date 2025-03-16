-- load defaults i.e lua_lsp
local function setup(p, opts)
  require("nvchad.configs.lspconfig").defaults()

  local lspconfig = require "lspconfig"

  local nvlsp = require "nvchad.configs.lspconfig"

  local servers = {
    html = {},
    cssls = {},
    marksman = {}, -- markdown
    pyright = {}, -- python
    clangd = {},
    rust_analyzer = {},
  }

  local default_setups = vim.tbl_deep_extend("keep", opts, {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  })

  local providerNames = { "lazyconf.lsp_provider.go", "lazyconf.lsp_provider.ts" }
  local providers = {}
  for _, name in ipairs(providerNames) do
    providers[name] = require(name)
  end

  for _, provider in ipairs(providers) do
    provider.config(servers, default_setups)
  end

  for name, lsp in pairs(servers) do
    lspconfig[name].setup(vim.tbl_deep_extend("keep", lsp, default_setups))
  end

  for _, provider in ipairs(providers) do
    if provider.setup then
      provider.setup()
    end
  end
end

return setup
