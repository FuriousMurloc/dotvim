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

vim.opt.mouse = "a"
vim.g.vim_ui_open_cmd = 'gio open'

vim.cmd('set completeopt+=noselect,menuone,popup')

-- move throug tabs
vim.keymap.set({'n','i'}, '<C-h>', ':tabprevious<CR>')
vim.keymap.set({'n','i'}, '<C-l>', ':tabnext<CR>')
-- reload this file
vim.keymap.set('n', '<leader>+', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, { desc = 'vim.lsp.buf.definition' })
vim.keymap.set('n', '<leader>fo', vim.lsp.buf.format, { desc = 'vim.lsp.buf.format' })
-- exit terminal with esc
vim.keymap.set('t', '<esc>', '<c-\\><c-n>', { desc = 'esc in terinal mode.' })

vim.pack.add({
    { src = 'https://github.com/catppuccin/nvim.git' },
    { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = vim.version.range('3') },
    { src = 'https://github.com/MunifTanjim/nui.nvim.git' },
    { src = 'https://github.com/nvim-lua/plenary.nvim.git' },
    { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
    { src = 'https://github.com/nvim-telescope/telescope.nvim.git' },
    { src = 'https://github.com/NeogitOrg/neogit.git' },
    { src = 'https://github.com/sindrets/diffview.nvim.git' },
})

Tree = require('neo-tree')
Picker = require('telescope.builtin')
Catppuccin = require("catppuccin")
Git = require('neogit')


Tree.setup({
    enable_git_status = true,
    enable_diagnostics = true,
    event_handlers = {
      {
        event = "file_opened",
        handler = function()
          require("neo-tree.command").execute({ action = "close" })
        end,
      },
    },
    default_component_configs = {
        git_status = {
            symbols = {
                -- Change type
                added = "+", -- or "✚"
                modified = "",
                deleted = "-", -- this can only be used in the git_status source
                renamed = "󰁕", -- this can only be used in the git_status source
                -- Status type
                untracked = "",
                ignored = "",
                unstaged = "󰄱",
                staged = "",
                conflict = "",
      },
    },
  }
})
-- lsp stuff

local on_attach = function(client, bufnr)
    vim.lsp.completion.enable(true, client.id, bufnr, {
        autotrigger = true,
        convert = function(item)
            return { abbr = item.label:gsub('%b()', '') }
        end,
    })
    vim.keymap.set('i', '<C-space>', vim.lsp.completion.get, { desc = 'trigger autocompletion' })
end

vim.lsp.config('lua_ls',{
    on_attach = on_attach ,
    filetypes = { 'lua' },
    cmd = { 'lua-language-server' },
    root_markers = {
        ".luarc.json",
        ".luarc.jsonc",
        ".luacheckrc",
        ".stylua.toml",
        ".git",
      },
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
          }
        }
      }
})

vim.lsp.config('clangd',{
    cmd = { 'clangd', '--background-index', '--clang-tidy' },
    filetypes = { 'c', 'cpp' },
    on_attach = on_attach
})

vim.lsp.config('zls', {
    on_attach = on_attach,
    settings = {
        zls = {

            semantic_tokens = "partial",
            zig_lib_path = "/home/aleix/srcs/zig/lib/"

        }
    }
})

vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { desc = 'vim.lsp.buf.format()' })

--activar lsps
vim.lsp.enable({ "lua_ls", "clangd" })

-- MAN stuff
vim.g.man_default_sects = '2,3'

    --obrir man de la paraula sota el cursor
vim.keymap.set('n', 'mm', function()
    local cursor = vim.fn.expand('<cword>')
    vim.api.nvim_command(':tab Man ' .. cursor)
end, {desc='open man on cursor'})




--picker stuff
vim.keymap.set('n', '<leader>gl', vim.diagnostic.open_float, { desc = 'vim.diagnostic.open_float()' })
vim.keymap.set('n', '<leader>ff', Picker.find_files, { desc = 'find files' })
vim.keymap.set('n', '<leader>fg', Picker.live_grep, { desc = 'live grep' })
vim.keymap.set('n', '<leader>fb', Picker.buffers, { desc = 'pick buffers' })
vim.keymap.set('n', '<leader>h', function()
    Picker.help_tags({ default_split = 'vertical' }, {})
    vim.api.nvim_win_set_width(0,83);
end, { desc = 'pick help' })

--file tree 
vim.keymap.set('n', '<leader>t', function()
    require('neo-tree.command').execute({ action='focus', source='filesystem', position='float', toggle=true })
end , { desc = 'file tree' })

-- git
vim.keymap.set('n', '<leader>gs', function() Git.open({kind='split'}) end, { desc = 'pick buffers' })
vim.keymap.set('n', '<leader>gd', "<cmd>DiffviewOpen<CR>", { desc = 'pick buffers' })

Catppuccin.setup()
vim.cmd.colorscheme("catppuccin")
vim.cmd.highlight({"Normal", "guibg=none"})
vim.cmd.highlight({"NonText", "guibg=none"})
vim.cmd.highlight({"Normal", "ctermbg=none"})
vim.cmd.highlight({"NonText", "ctermbg=none"})
