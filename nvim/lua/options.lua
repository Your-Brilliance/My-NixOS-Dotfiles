require "nvchad.options"

local opt = vim.opt

opt.clipboard = "unnamedplus"
opt.splitright = true 
opt.splitbelow = true
opt.swapfile = false

vim.api.nvim_create_user_command('Ff', function()
    vim.cmd('silent !firefox % &')
end, {})

-- Python Provider Settings
vim.g.loaded_python3_provider = nil
vim.cmd("runtime! autoload/provider/python3.vim")
vim.g.python3_host_prog = vim.fn.exepath("python3")
vim.cmd([[runtime! plugin/remote.vim]])
vim.g.remote_plugin_manifest = vim.fn.stdpath("config") .. "/rplugin.vim"

vim.filetype.add({
  extension = {
    py = "python",
    ipynb = "python",
    qmd = "quarto",
  },
})
