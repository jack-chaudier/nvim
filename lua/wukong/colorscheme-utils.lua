-- lua/wukong/colorscheme-utils.lua
local M = {}

-- Define the 6 colorschemes: 3 dark, 3 light
M.colorschemes = {
  -- Dark themes
  { name = "tokyonight-storm", background = "dark" },
  { name = "catppuccin-mocha", background = "dark" },
  { name = "onedark", background = "dark" },  -- Changed from "onedarkpro" to "onedark"
  -- Light themes
  { name = "tokyonight-day", background = "light" },
  { name = "catppuccin-latte", background = "light" },
  { name = "github_light", background = "light" },
}

-- Get the data path for storing colorscheme preference
local data_path = vim.fn.stdpath("data") .. "/colorscheme.txt"

-- Save colorscheme to file
function M.save_colorscheme(colorscheme)
  local file = io.open(data_path, "w")
  if file then
    file:write(colorscheme)
    file:close()
  end
end

-- Load saved colorscheme
function M.load_saved_colorscheme()
  local file = io.open(data_path, "r")
  if file then
    local colorscheme = file:read("*l")
    file:close()
    return colorscheme
  end
  return nil
end

-- Set colorscheme with proper background
function M.set_colorscheme(colorscheme_name)
  -- Find the colorscheme in our list
  local scheme_info = nil
  for _, scheme in ipairs(M.colorschemes) do
    if scheme.name == colorscheme_name then
      scheme_info = scheme
      break
    end
  end
  
  if scheme_info then
    -- Set background first
    vim.o.background = scheme_info.background
    
    -- Then set colorscheme
    local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme_name)
    if ok then
      vim.notify("Colorscheme: " .. colorscheme_name .. " (" .. scheme_info.background .. ")")
      -- Save the colorscheme
      M.save_colorscheme(colorscheme_name)
      -- Force lualine refresh with proper theme
      vim.defer_fn(function()
        require('lualine').setup({
          options = {
            theme = 'auto',
            refresh = {
              statusline = 1000,
              tabline = 1000,
              winbar = 1000,
            }
          }
        })
      end, 50)
    else
      vim.notify("Failed to load colorscheme: " .. colorscheme_name, vim.log.levels.ERROR)
    end
  else
    vim.notify("Unknown colorscheme: " .. colorscheme_name, vim.log.levels.ERROR)
  end
end

-- Cycle through colorschemes
M.current_index = 1

function M.cycle_colorscheme()
  M.current_index = M.current_index % #M.colorschemes + 1
  local colorscheme = M.colorschemes[M.current_index]
  M.set_colorscheme(colorscheme.name)
end

-- Cycle only dark themes
function M.cycle_dark_colorscheme()
  local dark_schemes = vim.tbl_filter(function(s) return s.background == "dark" end, M.colorschemes)
  local current_dark_index = 1
  
  -- Find current dark scheme index
  local current = vim.g.colors_name
  for i, scheme in ipairs(dark_schemes) do
    if scheme.name == current then
      current_dark_index = i
      break
    end
  end
  
  -- Cycle to next dark scheme
  current_dark_index = current_dark_index % #dark_schemes + 1
  M.set_colorscheme(dark_schemes[current_dark_index].name)
end

-- Cycle only light themes
function M.cycle_light_colorscheme()
  local light_schemes = vim.tbl_filter(function(s) return s.background == "light" end, M.colorschemes)
  local current_light_index = 1
  
  -- Find current light scheme index
  local current = vim.g.colors_name
  for i, scheme in ipairs(light_schemes) do
    if scheme.name == current then
      current_light_index = i
      break
    end
  end
  
  -- Cycle to next light scheme
  current_light_index = current_light_index % #light_schemes + 1
  M.set_colorscheme(light_schemes[current_light_index].name)
end

-- Initialize colorscheme on startup
function M.init()
  -- Try to load saved colorscheme
  local saved = M.load_saved_colorscheme()
  if saved then
    M.set_colorscheme(saved)
  else
    -- Default to dark theme
    M.set_colorscheme("tokyonight-storm")
  end
  
  -- Update current_index to match loaded colorscheme
  for i, scheme in ipairs(M.colorschemes) do
    if scheme.name == vim.g.colors_name then
      M.current_index = i
      break
    end
  end
end

return M
