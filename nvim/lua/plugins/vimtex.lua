return {
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_view_general_viewer = "zathura"
      
      -- Tell VimTeX exactly what the server name is instead of asking for it
      vim.g.vimtex_compiler_progname = "nvr"
    end,
    config = function()
      -- Start the server using a fixed path
      -- This avoids the "Unknown function" error entirely
      local echo_pipe = "/tmp/nvimsocket"
      if vim.fn.has("nvim") == 1 and vim.v.servername == "" then
        vim.fn.serverstart(echo_pipe)
      end
    end,
  },
}
