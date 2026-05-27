-- Import NvChad defaults
local nvlsp = require "nvchad.configs.lspconfig"
local on_attach = nvlsp.on_attach
local on_init = nvlsp.on_init
local capabilities = nvlsp.capabilities

-- The 0.11+ way to enable servers? I think so at least lmao
local servers = { 
  "html",          -- HTML
  "cssls",         -- CSS
  "pyright",       -- Python
  "clangd",        -- C/C++
  "rust_analyzer", -- Rust
  "ocamllsp",      -- OCaml
  "hls",           -- Haskell
  "jdtls",         -- Java
  "sqls",          -- SQL
  "lemminx",       -- XML
  "nil_ls"         -- Nix
}

for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    install = true, -- Tells Neovim to look for the binary in the path
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  })
  vim.lsp.enable(lsp)
end

-- Config for lua_ls (to fix red line in my dotfiles)
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
