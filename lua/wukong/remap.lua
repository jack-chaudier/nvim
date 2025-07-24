-- lua/wukong/remap.lua
local colorscheme_utils = require("wukong.colorscheme-utils")

-- File explorer
vim.keymap.set('n', '<Leader>ex', ':Ex<CR>', { noremap = true, desc = "File explorer" })

-- Telescope
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Buffers" })
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent files" })

-- Colorscheme
vim.keymap.set("n", "<leader>tc", colorscheme_utils.cycle_colorscheme, { desc = "Cycle all colorschemes" })
vim.keymap.set("n", "<leader>td", colorscheme_utils.cycle_dark_colorscheme, { desc = "Cycle dark themes" })
vim.keymap.set("n", "<leader>tl", colorscheme_utils.cycle_light_colorscheme, { desc = "Cycle light themes" })
vim.keymap.set("n", "<leader>ts", "<cmd>Telescope colorscheme<CR>", { desc = "Select colorscheme" })
