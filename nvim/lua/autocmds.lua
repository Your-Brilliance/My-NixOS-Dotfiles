require "nvchad.autocmds"

vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*.ipynb",
  callback = function()
    -- This doesn't run it, it just sets the mapping or suggests the init
    vim.keymap.set("n", "<leader>mi", ":MoltenInit python3<CR>", { buffer = true, desc = "Initialize Molten" })
  end,
})
