return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    {
      "rcarriga/nvim-notify",
      opts = {
        background_colour = "#000000", 
        timeout = 1000,
        render = "default", 
      },
    },
  },
  opts = {
    lsp = {
      progress = { enabled = false }, -- Already hides the loading bars
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    routes = {
      --- Nuclear Option: Silence ALL LSP messages (Info, Warning, etc.)
      {
        filter = {
          event = "lsp",
          kind = "message",
        },
        opts = { skip = true },
      },
      --- Silence common "written" and "search" messages
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "written" },
            { find = "search hit" },
            { find = "change" },
          },
        },
        opts = { skip = true },
      },
      --- Silence the "NotifyBackground" error and specific lua_ls noise
      {
        filter = {
          any = {
            { find = "lua_ls" },
            { find = "NotifyBackground" },
            { find = "No signature help available" },
          },
        },
        opts = { skip = true },
      },
    },
    presets = {
      bottom_search = false,
      command_palette = true, 
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = true,
    },
  },
}
