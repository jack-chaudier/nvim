return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            -- Setup mason first
            require("mason").setup()
            
            -- Setup mason-lspconfig with automatic server enabling
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "pyright",
                    "ts_ls",
                    "rust_analyzer",
                    "clangd",
                    "zls"
                },
                automatic_enable = true, -- This is the new feature in v2.0.0
            })
            
            -- Configure diagnostics appearance
            vim.diagnostic.config({
                virtual_text = {
                    prefix = '●',
                },
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                float = {
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            })
            
            -- Change diagnostic symbols in the sign column
            local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end
            
            -- Diagnostic keymaps
            vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open diagnostic float" })
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
            vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
            
            -- Configure specific servers using vim.lsp.config (new in Neovim 0.11)
            vim.lsp.config('lua_ls', {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' }
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = {
                            enable = false,
                        },
                    }
                }
            })
            
            -- LSP keymaps (applied when LSP attaches to buffer)
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
                    
                    -- Buffer local mappings
                    local opts = { buffer = ev.buf }
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
                    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                    
                    -- Show line diagnostics automatically in hover window
                    vim.api.nvim_create_autocmd("CursorHold", {
                        buffer = ev.buf,
                        callback = function()
                            local opts = {
                                focusable = false,
                                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                                border = 'rounded',
                                source = 'always',
                                prefix = ' ',
                                scope = 'cursor',
                            }
                            vim.diagnostic.open_float(nil, opts)
                        end
                    })
                end,
            })
        end
    },
}
