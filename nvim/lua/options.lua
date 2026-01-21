require "nvchad.options"

local opt = vim.opt

opt.clipboard = "unnamedplus"

opt.splitright = true 
opt.splitbelow = true

opt.swapfile = false


vim.api.nvim_create_user_command('Ff', function()
    vim.cmd('silent !firefox % &')
end, {})

