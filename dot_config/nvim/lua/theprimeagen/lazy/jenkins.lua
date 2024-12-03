return {
    "ckipp01/nvim-jenkinsfile-linter",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function()
        vim.keymap.set('n', '<leader>jv', function()
            require("jenkinsfile_linter").validate()
        end, { desc = 'Validate Jenkinsfile' })
    end
}
