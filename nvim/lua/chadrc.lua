--@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "onedark",
  transparency = true,
  hl_add = {
    Normal = { bg = "none" },
    NormalNC = { bg = "none" },
  };
}

M.ui = {
  lsp_semantic_tokens = true,
  
  statusline = {
    theme = "default", 
  },

  lsp = {
    signature = false, 
  },
  
  tabufline = {
    lazyload = false,
  },
}

M.nvdash = {
  load_on_startup = true, -- This ensures the dashboard shows the logo on start
}

-- Explicitly force the logo flag
vim.g.nvchad_logo = true

local default_notebook = [[
{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "print('New Notebook Initialized!')"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3",
   "language": "python",
   "name": "python3"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
]]

vim.api.nvim_create_user_command('NewNotebook', function(opts)
    local name = opts.args
    if not name:match("%.ipynb$") then
        name = name .. ".ipynb"
    end
    local file = io.open(name, "w")
    if file then
        file:write(default_notebook)
        file:close()
        vim.cmd("edit " .. name)
        vim.bo.filetype = "python"
    else
        print("Error: Could not create notebook file.")
    end
end, { nargs = 1 })

return M
