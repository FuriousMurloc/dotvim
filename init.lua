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

vim.opt.mouse = ""
vim.g.vim_ui_open_cmd = 'gio open'

vim.cmd('set completeopt+=noselect,menuone,popup')

-- reload this file
vim.keymap.set('n', '<leader>+', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, { desc = 'vim.lsp.buf.definition' })
vim.keymap.set('n', '<leader>fo', vim.lsp.buf.format, { desc = 'vim.lsp.buf.format' })
-- exit terminal with esc
vim.keymap.set('t', '<esc>', '<c-\\><c-n>', { desc = 'esc in terinal mode.' })

vim.pack.add({
    { src = 'https://github.com/catppuccin/nvim.git' },
    { src = 'https://github.com/echasnovski/mini.pick' },
    { src = 'https://github.com/echasnovski/mini.files' },
    { src = 'https://github.com/zk-org/zk-nvim' },
    { src = '/home/aleix/Documents/floaterminal' },
})
Mini_pick = require('mini.pick')
Mini_files = require('mini.files')
Floaterminal = require('floaterminal')
Catppuccin = require("catppuccin")
Zk = require("zk")
Zk.setup({
    picker = "minipick",
    lsp = {
        -- `config` is passed to `vim.lsp.start_client(config)`
        config = {
            cmd = { "zk", "lsp" },
            name = "zk",
            -- on_attach = ...
            -- etc, see `:h vim.lsp.start_client()`
        },
        -- automatically attach buffers in a zk notebook that match the given filetypes
        auto_attach = {
            enabled = true,
            filetypes = { "markdown" },
        },
    },
})


local on_attach = function(client, bufnr)
    vim.lsp.completion.enable(true, client.id, bufnr, {
        autotrigger = true,
        convert = function(item)
            return { abbr = item.label:gsub('%b()', '') }
        end,
    })
    vim.keymap.set('i', '<C-space>', vim.lsp.completion.get, { desc = 'trigger autocompletion' })
end

vim.lsp.config('lua_ls',{ on_attach = on_attach })

vim.lsp.config('clangd',{
    cmd = { 'clangd', '--background-index', '--clang-tidy' },
    on_attach = on_attach
})

vim.lsp.config('zls', {
    -- Server-specific settings. See `:help lspconfig-setup`

    -- There are two ways to set config options:
    --   - edit your `zls.json` that applies to any editor that uses ZLS
    --   - set in-editor config options with the `settings` field below.
    --
    -- Further information on how to configure ZLS:
    -- https://zigtools.org/zls/configure/
    settings = {
        zls = {
            -- Whether to enable build-on-save diagnostics
            --
            -- Further information about build-on save:
            -- https://zigtools.org/zls/guides/build-on-save/
            -- enable_build_on_save = true,

            -- Neovim already provides basic syntax highlighting
            semantic_tokens = "partial",
            zig_lib_path = "/home/aleix/srcs/zig/lib/"

        }
    }
})

vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { desc = 'vim.lsp.buf.format()' })

-- MAN stuff
vim.g.man_default_sects = '2,3'
vim.keymap.set('n', 'mm', function()
    local cursor = vim.fn.expand('<cword>')
    vim.api.nvim_command(':tab Man ' .. cursor)
end, {desc='open man on cursor'})

vim.keymap.set({'n','i'}, '<C-h>', ':tabprevious<CR>')
vim.keymap.set({'n','i'}, '<C-l>', ':tabnext<CR>')

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
vim.keymap.set('n', '<leader>zz', Zk.edit, { desc = 'picker zk' })

vim.keymap.set('n', '<leader>h', function()
    Mini_pick.builtin.help({ default_split = 'vertical' }, {})
    vim.api.nvim_win_set_width(0,83);
end, { desc = 'mini_pick.builtin.help()' })


Floaterminal.setup()
Catppuccin.setup()
vim.cmd.colorscheme("catppuccin")
vim.cmd.highlight({"Normal", "guibg=none"})
vim.cmd.highlight({"NonText", "guibg=none"})
vim.cmd.highlight({"Normal", "ctermbg=none"})
vim.cmd.highlight({"NonText", "ctermbg=none"})
