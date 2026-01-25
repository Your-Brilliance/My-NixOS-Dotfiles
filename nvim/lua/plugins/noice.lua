return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    {
      "rcarriga/nvim-notify",
      opts = {
        -- This stops the error. Since your terminal is transparent, 
        -- Noice will still respect your terminal's transparency.
        background_colour = "#000000", 
        timeout = 1000,
        render = "default", 
      },
    },
  },
  opts = {
    lsp = {
      progress = { enabled = false }, -- Hides the "loading lua_ls" bar
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    routes = {
      { -- This block silences the lua_ls and NotifyBackground popups
        filter = {
          any = {
            { find = "lua_ls" },
            { find = "NotifyBackground" },
          },
        },
        opts = { skip = true },
      },
    },
    presets = {
      bottom_search = false,
      command_palette = true, -- Keeps your "rectangle" cmdline
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = true,
    },
  },
}

