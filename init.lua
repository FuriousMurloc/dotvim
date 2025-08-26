function Editor_config()
    vim.g.mapleader = ' '

    -- Tabs stuff
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.expandtab = true

    -- numberline stuff
    vim.opt.number = true
    vim.opt.relativenumber = true
    vim.opt.signcolumn = 'yes'

    -- more general stuff
    vim.opt.termguicolors = true
    vim.opt.wrap = true
    vim.opt.swapfile = false
    vim.opt.winborder = 'rounded'
    vim.opt.clipboard = 'unnamedplus'

    vim.g.vim_ui_open_cmd = 'gio open'

    vim.cmd('set completeopt+=noselect,menuone,popup')

    -- reload this file
    vim.keymap.set('n', '<leader>+', ':update<CR> :source<CR>')
    -- exit terminal with esc
    vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>')
end

function Package_management()
    vim.pack.add({
        { src = 'https://github.com/catppuccin/nvim.git' },
        { src = 'https://github.com/neovim/nvim-lspconfig.git' },
        { src = 'https://github.com/echasnovski/mini.pick' },
        { src = 'https://github.com/echasnovski/mini.files' },
        { src = 'https://github.com/zk-org/zk-nvim' },
        { src = '/home/aleix/Documents/floaterminal' },
    })
    Mini_pick = require('mini.pick')
    Mini_files = require('mini.files')
    Lsp_config = require('lspconfig')
    Floaterminal = require('floaterminal')
    Catppuccin = require("catppuccin")
end

function Configure_lsp()
    local on_attach = function(client, bufnr)
        vim.lsp.completion.enable(true, client.id, bufnr, {
            autotrigger = true,
            convert = function(item)
                return { abbr = item.label:gsub('%b()', '') }
            end,
        })
        vim.keymap.set('i', '<C-space>', vim.lsp.completion.get, { desc = 'trigger autocompletion' })
    end
    Lsp_config['lua_ls'].setup({ on_attach = on_attach })
    Lsp_config['clangd'].setup({
        cmd = { 'clangd', '--background-index', '--clang-tidy' },
        on_attach = on_attach
    })
    vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { desc = 'vim.lsp.buf.format()' })

    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
            vim.lsp.buf.format({ bufnr = args.buf })
        end,
    })
    function Show_outline()
        local params = { textDocument = { uri = vim.uri_from_bufnr(0) } }
        vim.lsp.buf_request(0, 'textDocument/documentSymbol', params, function(_, _, result, _)
            if result and #result > 0 then
                local outline = {}
                for _, symbol in ipairs(result) do
                    table.insert(outline, symbol.name)
                end
                print(table.concat(outline, "\n"))
            else
                print("No symbols found.")
            end
        end)
    end

    vim.lsp.buf.document_symbol()
    vim.lsp.enable({ "lua_ls", "clangd" })
end

Package_management()
Editor_config()
Configure_lsp()

Mini_files.setup({ mappings = { close = '<ESC>' } })

Mini_pick.setup({
    mappings = {
        move_down = '<C-j>',
        move_up = '<C-k>'
    }
})

vim.keymap.set('n', '<leader>gl', vim.diagnostic.open_float, { desc = 'vim.diagnostic.open_float()' })
vim.keymap.set('n', '<leader>ff', Mini_pick.builtin.files, { desc = 'mini_pick.builtin.files()' })
vim.keymap.set('n', '<leader>fg', Mini_pick.builtin.grep_live, { desc = 'mini_pick.builtin.grep_live()' })
vim.keymap.set('n', '<leader>fb', Mini_pick.builtin.buffers, { desc = 'mini_pick.builtin.buffers()' })
vim.keymap.set('n', '<leader>t', Mini_files.open, { desc = 'mini_files.open()' })
vim.keymap.set('n', '<leader>o', Floaterminal.toggle_terminal, { desc = 'floaterminal.toggle_terminal' })

vim.keymap.set('n', '<leader>h', function()
    Mini_pick.builtin.help({ default_split = 'vertical' }, {})
end, { desc = 'mini_pick.builtin.help()' })

Floaterminal.setup()
Catppuccin.setup()
vim.cmd("colorscheme catppuccin")
