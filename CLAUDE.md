# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Codebase Overview

This is a modern Neovim configuration built with Lua that uses lazy.nvim for plugin management. The configuration follows a modular architecture with all code organized under the `wukong` namespace.

## Key Architecture

### Entry Points
- `init.lua` - Simply requires the main wukong module
- `lua/wukong/init.lua` - Main initialization that loads all components in order:
  1. Sets leader key to space
  2. Loads keymaps from `remap.lua`
  3. Loads vim settings from `set.lua`
  4. Initializes plugin manager via `lazy_init.lua`
  5. Sets up custom colorscheme manager with deferred initialization

### Plugin Management
- Uses lazy.nvim with automatic bootstrapping
- Plugins defined in individual files under `lua/wukong/lazy/`
- Each plugin file returns a Lazy spec table
- Version locking via `lazy-lock.json`

### Custom Colorscheme System
The `colorscheme-utils.lua` implements a sophisticated theme management system:
- Maintains separate lists for dark and light themes
- Persists user preferences to `~/.local/share/nvim/wukong_colorscheme.json`
- Provides cycling functionality with `<leader>tt` (next) and `<leader>tr` (previous)
- Automatically refreshes lualine on theme change
- Handles missing themes gracefully with fallbacks

## Common Development Tasks

### Adding a New Plugin
1. Create a new file in `lua/wukong/lazy/` following the naming convention
2. Return a table with the plugin spec following lazy.nvim format
3. The file will be automatically loaded by the lazy setup

### Modifying Keymaps
Edit `lua/wukong/remap.lua` - all keymaps should include a `desc` field for which-key integration

### Changing Vim Settings
Edit `lua/wukong/set.lua` - keep related settings grouped with comments

### LSP Configuration
- LSP servers are managed by Mason and configured in `lua/wukong/lazy/lsp.lua`
- Uses Neovim 0.11's `vim.lsp.config` for automatic setup
- Currently configured for: Lua, Python, TypeScript, Rust, C, Zig

## Important Patterns

### Error Handling
Always use `pcall` when loading modules that might fail:
```lua
local ok, module = pcall(require, "module_name")
if not ok then return end
```

### Plugin Specs
Plugin files should return either a single table or array of tables:
```lua
return {
  "plugin/name",
  config = function()
    -- configuration
  end,
}
```

### File Naming
- Use lowercase with hyphens for consistency
- Plugin configs go in `lua/wukong/lazy/`
- Utility modules go directly in `lua/wukong/`

## Testing Changes
- Use `:Lazy sync` to update plugins after changes
- Reload configuration with `:source %` or restart Neovim
- Check `:checkhealth` for plugin issues
- Use `:Lazy profile` to check startup performance