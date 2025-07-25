-- lua/wukong/lazy/lualine.lua
return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = "VeryLazy",
    config = function()
        require('lualine').setup({
            options = {
                theme = 'auto', -- Automatically matches colorscheme
                component_separators = { left = '│', right = '│' },
                section_separators = { left = '', right = '' },
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                }
            },
            sections = {
                lualine_a = {'mode'},
                lualine_b = {'branch', 'diff', 'diagnostics'},
                lualine_c = {'filename'},
                lualine_x = {'encoding', 'fileformat', 'filetype'},
                lualine_y = {'progress'},
                lualine_z = {'location'}
            },
        })
    end,
}
