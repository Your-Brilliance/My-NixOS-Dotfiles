return {
  "AlphaTechnolog/pywal.nvim",
  name = "pywal",
  lazy = false,
  priority = 1000,
  config = function()
    require("pywal").setup()
    
    -- Safely wait for NvChad to finish loading
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        -- Schedule Pywal to apply at the very end of the startup queue
        vim.schedule(function()
          local ok, _ = pcall(vim.cmd, "colorscheme pywal")
          
          if ok then
            -- Apply the transparency overrides
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
            vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
            vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
          end
        end)
      end,
    })
  end,
}
