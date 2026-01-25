vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- 1. LOAD OPTIONS AND AUTOCOMMANDS
require "options"
require "autocmds"

-- 2. LOAD MAPPINGS IMMEDIATELY (No schedule)
require "mappings"

-- 3. SCHEDULE ONLY UI/HIGHLIGHT UPDATES
vim.schedule(function()
  vim.cmd('highlight Normal guibg=NONE')
  vim.cmd('highlight NormalFloat guibg=NONE')
  vim.cmd('highlight NvimTreeNormal guibg=NONE')
  vim.cmd('highlight StatusLine guibg=NONE')
  vim.cmd('highlight LineNr guibg=NONE')
end)
