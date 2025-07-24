-- lua/wukong/colorscheme-utils.lua
local M = {}

-- More advanced colorscheme cycling with variants
M.colorscheme_variants = {
  { name = "tokyonight", variants = { "tokyonight-storm", "tokyonight-moon", "tokyonight-night", "tokyonight-day" } },
  { name = "catppuccin", variants = { "catppuccin-latte", "catppuccin-frappe", "catppuccin-macchiato", "catppuccin-mocha" } },
  { name = "gruvbox", variants = { "gruvbox" } },
  { name = "onedark", variants = { "onedark" } },
  { name = "nightfox", variants = { "nightfox", "dayfox", "dawnfox", "duskfox", "nordfox", "terafox", "carbonfox" } },
}

-- Flatten the variants into a single list
M.all_colorschemes = {}
for _, scheme in ipairs(M.colorscheme_variants) do
  for _, variant in ipairs(scheme.variants) do
    table.insert(M.all_colorschemes, variant)
  end
end

M.current_index = 1

function M.cycle_colorscheme()
  M.current_index = M.current_index % #M.all_colorschemes + 1
  local colorscheme = M.all_colorschemes[M.current_index]
  
  local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
  if ok then
    vim.notify("Colorscheme: " .. colorscheme)
    -- Update lualine theme when colorscheme changes
    require('lualine').setup({ options = { theme = 'auto' } })
  else
    vim.notify("Failed to load colorscheme: " .. colorscheme, vim.log.levels.ERROR)
  end
end

-- Set default colorscheme
function M.set_default_colorscheme()
  local ok, _ = pcall(vim.cmd, "colorscheme tokyonight-storm")
  if not ok then
    vim.notify("Failed to set default colorscheme", vim.log.levels.WARN)
  end
end

return M
