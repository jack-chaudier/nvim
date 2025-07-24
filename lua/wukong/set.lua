-- Relative line numbers
vim.opt.relativenumber = true

-- tab size (4)
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true


-- Enable absolute line numbers alongside relative ones
vim.opt.number = true

-- Enable mouse support (optional, useful for resizing splits or clicking)
vim.opt.mouse = 'a'

-- Case-insensitive searching unless \C or capital letters are used
vim.opt.ignorecase = true
vim.opt.smartcase = true


-- line wrapping
vim.opt.wrap = false

-- Highlight the current line
vim.opt.cursorline = true

-- Keep 8 lines visible above/below the cursor when scrolling
vim.opt.scrolloff = 8

-- Enable undo file to persist undo history across sessions
vim.opt.undofile = true

-- Set update time for signs and UI (e.g., for git gutter or diagnostics)
vim.opt.updatetime = 300

-- Enable system clipboard integration
vim.opt.clipboard = 'unnamedplus'

-- Show sign column (for git signs, diagnostics, etc.)
vim.opt.signcolumn = 'yes'

-- Better splitting behavior (open new splits to the right/below)
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Enable 24-bit RGB colors (for modern terminals)
vim.opt.termguicolors = true

-- Set a reasonable command-line height
vim.opt.cmdheight = 1

-- Disable swap file (optional, if you prefer backups elsewhere)
vim.opt.swapfile = false

-- Enable auto-indentation for new lines
vim.opt.autoindent = true
vim.opt.smartindent = true
