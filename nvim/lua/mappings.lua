local map = vim.keymap.set

-- Basic NvChad UI
map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Window management
map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- NvimTree
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files" })
map("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string" })

-- Molten Mappings (Using 'm' for Molten)
-- 1. INITIALIZE
map("n", "<leader>mi", ":MoltenInit<CR>", { desc = "Init Molten" })

-- 2. RUN CODE
map("n", "<leader>mr", ":MoltenReevaluateCell<CR>", { desc = "Molten Run Cell" })
map("v", "<leader>mr", ":<C-u>MoltenEvaluateVisual<CR>gv", { desc = "Molten Run Visual" })

-- 3. MANAGE OUTPUT (The <C-u> prevents the 'No range found' error)
map({ "n", "v" }, "<leader>mh", ":<C-u>MoltenHideOutput<CR>gv", { desc = "Molten Hide Output" })
map({ "n", "v" }, "<leader>md", ":<C-u>MoltenDelete<CR>gv", { desc = "Molten Delete Output" })
map({ "n", "v" }, "<leader>mo", ":<C-u>noautocmd MoltenEnterOutput<CR>", { desc = "Molten Show/Enter Output" })

-- 4. EMERGENCY IMAGE CLEAR
map({ "n", "v" }, "<leader>mc", function()
  require("image").clear()
end, { desc = "Molten Hard Clear Images" })

-- Auto-Session shit
map("n", "<leader>ws", "<cmd>AutoSession save<cr>", { desc = "Save session for current directory" })
map("n", "<leader>wr", "<cmd>AutoSession restore<cr>", { desc = "Restore session for current directory" })

-- Search through all your saved sessions (Telescope integration)
map("n", "<leader>wl", "<cmd>SessionSearch<cr>", { desc = "Search through all sessions" })

-- Notification Management
map("n", "<leader>nd", function()
  require("noice").cmd("dismiss")
end, { desc = "Dismiss all notifications" })


