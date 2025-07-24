-- lua/wukong/lazy/colorscheme.lua
return {
  -- Tokyo Night
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
    config = function(_, opts)
      require("tokyonight").setup(opts)
      -- Set default colorscheme after all plugins are loaded
      vim.defer_fn(function()
        require("wukong.colorscheme-utils").set_default_colorscheme()
      end, 0)
    end,
  },
  
  -- Catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
  },
  
  -- Gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
  },
  
  -- One Dark
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
  },
  
  -- Nightfox
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
  },
}
