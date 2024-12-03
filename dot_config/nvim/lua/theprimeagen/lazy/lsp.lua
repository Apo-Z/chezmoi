-- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#configuration

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "stevearc/conform.nvim",
        "j-hui/fidget.nvim",
    },

    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )


        require("conform").setup({
            formatters_by_ft = {
                python = { "black", "isort" },
                groovy = { "npm_groovy_lint" },
                jenkinsfile = { "npm_groovy_lint" },
            },
        })


        vim.keymap.set("n", "<leader>f", function()
            require("conform").format({
                async = true,
                timeout_ms = 2000,
                lsp_fallback = true,
            })
        end)

        require("fidget").setup({})
        require("mason").setup({
            ensure_installed = {
                "jq"
            }
        })
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "gopls",
                "ansiblels",
                "terraformls",
                --                "yamlls",
                --                "jsonls",
                "ast_grep",
                --                "sqlls",
                --"nil_ls",
                --                "jinja_lsp",
                "helm_ls",
                "dockerls",
                "docker_compose_language_service",
                "pyright",
                "groovyls",
            },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                zls = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.zls.setup({
                        root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
                        settings = {
                            zls = {
                                enable_inlay_hints = true,
                                enable_snippets = true,
                                warn_style = true,
                            },
                        },
                    })
                    vim.g.zig_fmt_parse_errors = 0
                    vim.g.zig_fmt_autosave = 0
                end,


                ["pylyzer"] = function()
                    -- Ne rien faire, ce qui empêchera pylyzer de démarrer
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                },
                            }
                        }
                    }
                end,

                ["ansiblels"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.ansiblels.setup {
                        capabilities = capabilities,
                        settings = {
                            ansible = {
                                ansibleLint = {
                                    enabled = true,
                                },
                                linting = {
                                    enabled = true,
                                },
                            },
                        },
                    }
                end,

                ["terraformls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.terraformls.setup {}
                end,


                ["ast_grep"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.ast_grep.setup {
                        capabilities = capabilities,
                    }
                end,

                ["helm_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.helm_ls.setup {}
                end,

                ["docker_compose_language_service"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.docker_compose_language_service.setup {}
                end,

                ["dockerls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.dockerls.setup {
                        capabilities = capabilities,
                    }
                end,

                ["groovyls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.groovyls.setup {
                        capabilities = capabilities,
                        cmd = {
                            "java",
                            "-jar",
                            vim.fn.expand("~/.local/share/nvim/mason/packages/groovy-language-server/build/libs/groovy-language-server-all.jar")
                        },
                        filetypes = { "groovy", "jenkinsfile" }, -- Support des deux types
                    }
                end,

                ["pyright"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.pyright.setup {
                        capabilities = capabilities,
                        settings = {
                            python = {
                                analysis = {
                                    typeCheckingMode = "basic",
                                    autoSearchPaths = true,
                                    useLibraryCodeForTypes = true,
                                    diagnosticMode = "workspace"
                                }
                            }
                        }
                    }
                end
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<Tab>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            }, {
                { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
