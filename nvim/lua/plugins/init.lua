return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  "nvim-lua/plenary.nvim", -- lua functions that many plugins use
  "christoomey/vim-tmux-navigator", -- tmux & split window navigation

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.completion = {
        -- This overrides the default 'true' setting in NvChad
        autocomplete = false,
      }
    end,
  },
   
  --{ import = "nvchad.blink.lazyspec" },

 
  {
 	  "nvim-treesitter/nvim-treesitter",
 	  opts = {
 		ensure_installed = {
 			"vim", "lua", "vimdoc",
      "html", "css"
   		},
   	},
   },
}
