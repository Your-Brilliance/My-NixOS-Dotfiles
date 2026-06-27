vim.api.nvim_create_autocmd("User", {
  pattern = "NvChadThemeReload", 
  callback = function()
    pcall(vim.api.nvim_del_augroup_by_name, "LspSignature")
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    pcall(vim.api.nvim_del_augroup_by_name, "LspSignature")
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      client.server_capabilities.signatureHelpProvider = false
    end
  end,
})

return {

  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  "nvim-lua/plenary.nvim", -- lua functions that many plugins use
  "christoomey/vim-tmux-navigator", -- tmux & split window navigation

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    enabled = false,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css", "cpp", 
        "python", "rust", "ocaml", 
        "haskell", "java", "xml"
      },
      auto_install = false,
      sync_install = false,
      indent = { 
        enable = true,
      }, 
    },
  },
}

