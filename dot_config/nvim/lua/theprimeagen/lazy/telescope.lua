return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup({})

        local builtin = require('telescope.builtin')
        -- vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

        vim.keymap.set('n', '<leader>pf', function()
            require('telescope.builtin').find_files({ no_ignore = true })
        end, {})
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Show references' })
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Show hover documentation' })
        vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, { desc = 'Show diagnostics' })
        vim.keymap.set('n', '[d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
        vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code actions' })
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
    end
}
