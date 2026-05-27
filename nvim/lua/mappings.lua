local map = vim.keymap.set

map("n", "<leader>h", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggle" }
end, { desc = "Terminal Toggle Horizontal" })

map("t", "<leader>x", "<C-\\><C-n>:lua require('nvchad.term').toggle({pos='sp', id='htoggle'})<CR>", { desc = "Terminal Hide" })

-- Cycle through buffers (tabs)
map("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Buffer Next" })
map("n", "<S-Tab>", "<cmd>bprev<CR>", { desc = "Buffer Previous" })

map("n", "<leader>tx", function()
  require("nvchad.term").toggle({pos = "sp", id = "htoggle"})
end, { desc = "Terminal Toggle/Hide" })

map("n", "<leader>v", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggle" }
end, { desc = "Terminal Toggle Vertical" })

-- Basic NvChad UI
map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<leader>nf", ":nohl<CR>", { desc = "Clear search highlights" })

-- Window management
map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- NvimTree
map("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
map("n", "<leader>ef", "<cmd>NvimTreeFocus<CR>", { desc = "Focus file explorer" })

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

-- LaTeX / VimTeX Mappings
map("n", "<leader>ll", "<cmd>VimtexCompile<CR>", { desc = "LaTeX: Start/Stop Compilation" })
map("n", "<leader>lv", "<cmd>VimtexView<CR>", { desc = "LaTeX: View PDF (Zathura)" })
map("n", "<leader>lc", "<cmd>VimtexClean<CR>", { desc = "LaTeX: Clean Auxiliary Files" })
map("n", "<leader>lt", "<cmd>VimtexTocToggle<CR>", { desc = "LaTeX: Toggle Table of Contents" })


