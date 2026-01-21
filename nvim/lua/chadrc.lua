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
  
  tabufline = {
    lazyload = false,
  },
}

M.nvdash = {
  load_on_startup = true, -- This ensures the dashboard shows the logo on start
}

-- Explicitly force the logo flag
vim.g.nvchad_logo = true

return M
