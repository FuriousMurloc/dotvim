return
{
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function ()
        vim.opt.runtimepath:append("$HOME/.local/share/treesitter")
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            parser_install_dir = "/home/aleix/.local/share/treesitter",
            ensure_installed = { "c", "lua", "vim", "vimdoc", "rust", "cpp" },
            sync_install = false,
            auto_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
