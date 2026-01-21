return {
  "nvim-telescope/telescope.nvim",
  -- Note: branch and dependencies are already handled by NvChad, 
  -- but keeping them here is fine for clarity.
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  -- Use 'opts' to MERGE your settings with NvChad's defaults
  opts = function()
    local conf = require("nvchad.configs.telescope") -- Get NvChad's defaults
    
    -- Add your custom path display and mappings
    conf.defaults.path_display = { "smart" }
    conf.defaults.mappings.i = {
      ["<C-k>"] = require("telescope.actions").move_selection_previous,
      ["<C-j>"] = require("telescope.actions").move_selection_next,
      ["<C-q>"] = require("telescope.actions").send_selected_to_qflist + require("telescope.actions").open_qflist,
    }
    
    return conf
  end,
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("fzf")
  end,
}
