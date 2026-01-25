-- Import NvChad defaults
local nvlsp = require "nvchad.configs.lspconfig"
local on_attach = nvlsp.on_attach
local on_init = nvlsp.on_init
local capabilities = nvlsp.capabilities

-- The new 0.11+ way to enable servers
local servers = { "html", "cssls", "pyright" }

for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    install = true, -- Tells Neovim to look for the binary in your path
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  })
  vim.lsp.enable(lsp)
end

-- Config for lua_ls (to fix those red lines in your dotfiles)
vim.lsp.config("lua_ls", {
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.stdpath "config" .. "/lua"] = true,
        },
      },
    },
  },
})
vim.lsp.enable("lua_ls")
