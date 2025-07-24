-- lua/wukong/lazy/colorscheme.lua
return {
  -- Tokyo Night (has both excellent dark and light variants)
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "storm",
      light_style = "day",
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
      },
      lualine_bold = false,
    },
  },
  
  -- Catppuccin (excellent dark and light variants)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha", -- default dark variant
      background = {
        light = "latte",
        dark = "mocha",
      },
    },
  },
  
  -- One Dark Pro (classic dark theme)
  {
    "olimorris/onedarkpro.nvim",
    lazy = false,
    priority = 1000,
  },
  
  -- GitHub Theme (excellent light theme)
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require('github-theme').setup({})
    end,
  },
}
