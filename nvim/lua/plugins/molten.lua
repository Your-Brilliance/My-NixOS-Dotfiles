return {
  "benlubas/molten-nvim",
  lazy = false,
  dependencies = { "3rd/image.nvim" },
  build = ":UpdateRemotePlugins", 
  init = function()
    -- These must be set BEFORE the plugin loads
    vim.g.molten_image_provider = "image.nvim"
    vim.g.molten_output_win_max_height = 12
    vim.g.molten_auto_open_output = false
    vim.g.molten_wrap_output = false     -- Disable wrapping to keep height predictable
    vim.g.molten_virt_text_output = true
    vim.g.molten_virt_lines_off_by_1 = 12 -- Match this exactly to image max_height
  end,
  config = function()
    vim.api.nvim_create_user_command('NewNotebook', function(opts)
        local name = opts.args
        if not name:match("%.qmd$") then name = name .. ".qmd" end
        local file = io.open(name, "w")
        if file then
            file:write("---\ntitle: " .. opts.args .. "\nformat: ipynb\n---\n\n```{python}\nprint('Hello from Quarto!')\n```")
            file:close()
            vim.cmd('edit ' .. name)
        end
    end, { nargs = 1 })
  end,
}
