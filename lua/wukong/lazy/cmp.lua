return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "onsails/lspkind.nvim", -- VS Code-like pictograms
    },
    config = function()
        local cmp = require("cmp")
        local lspkind = require("lspkind")
        
        cmp.setup({
            -- Better completion window appearance
            window = {
                completion = {
                    border = "rounded",
                    winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                    col_offset = -3,
                    side_padding = 1,
                },
                documentation = {
                    border = "rounded",
                    winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                    max_width = 80,
                    max_height = 12,
                    -- Make documentation window wider
                    min_width = 60,
                }
            },
            
            -- Better formatting with icons and menu info
            formatting = {
                format = lspkind.cmp_format({
                    mode = 'symbol_text',
                    maxwidth = 50,
                    ellipsis_char = '...',
                    menu = {
                        nvim_lsp = '[LSP]',
                        buffer = '[Buffer]',
                        path = '[Path]',
                    },
                    -- Show source and kind
                    before = function(entry, vim_item)
                        vim_item.menu = vim_item.menu or ""
                        return vim_item
                    end,
                })
            },
            
            -- Experimental features for better appearance
            experimental = {
                ghost_text = true, -- Show virtual text preview
            },
            
            mapping = cmp.mapping.preset.insert({
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<C-d>"] = cmp.mapping.scroll_docs(4),
                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            
            sources = {
                { name = "nvim_lsp", priority = 1000 },
                { name = "buffer", priority = 500 },
                { name = "path", priority = 250 },
            },
        })
    end,
}
