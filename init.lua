vim.g.mapleader = ' '

Lsp = require('lsp')

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
    { src = 'https://github.com/pianocomposer321/project-templates.nvim' },
    { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = vim.version.range('3') },
    { src = 'https://github.com/MunifTanjim/nui.nvim.git' },
    { src = 'https://github.com/nvim-lua/plenary.nvim.git' },
    { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
    { src = 'https://github.com/nvim-telescope/telescope.nvim.git' },
    { src = 'https://github.com/NeogitOrg/neogit.git' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
    { src = 'https://github.com/sindrets/diffview.nvim.git' },
    { src = 'https://github.com/ThePrimeagen/harpoon' , version='harpoon2' },
})

local tree = require('neo-tree')
local picker = require('telescope.builtin')
local catppuccin = require("catppuccin")
local git = require('neogit')
local harpoon = require("harpoon")
local treesitter = require('nvim-treesitter.config')

vim.cmd.colorscheme("catppuccin")

--file tree 
tree.setup({
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

vim.keymap.set('n', '<leader>t', function()
    require('neo-tree.command').execute({ action='focus', source='filesystem', position='float', toggle=true })
end , { desc = 'file tree' })

-- tree-sitter magic
treesitter.setup({
    install_dir = vim.fs.joinpath(vim.fn.stdpath('data') --[[@as string]], 'site/'),
    ensure_installed = { 'c', 'cpp', 'zig', 'html', 'lua'},
    highlight = { enable = true },
    ident = {enable = false},
})

-- MAN stuff
vim.g.man_default_sects = '2,3'

    --obrir man de la paraula sota el cursor
vim.keymap.set('n', 'mm', function()
    local cursor = vim.fn.expand('<cword>')
    vim.api.nvim_command(':tab Man ' .. cursor)
end, {desc='open man on cursor'})


--picker stuff
vim.keymap.set('n', '<leader>gl', vim.diagnostic.open_float, { desc = 'vim.diagnostic.open_float()' })
vim.keymap.set('n', '<leader>ff', picker.find_files, { desc = 'find files' })
vim.keymap.set('n', '<leader>fg', picker.live_grep, { desc = 'live grep' })
vim.keymap.set('n', '<leader>fb', picker.buffers, { desc = 'pick buffers' })
vim.keymap.set('n', '<leader>fh', function()
    picker.help_tags({ default_split = 'vertical' }, {})
    vim.api.nvim_win_set_width(0,83);
end, { desc = 'pick help' })

-- git
vim.keymap.set('n', '<leader>gs', function() git.open({kind='split'}) end, { desc = 'pick buffers' })
vim.keymap.set('n', '<leader>gd', "<cmd>DiffviewOpen<CR>", { desc = 'pick buffers' })


-- harpoon

harpoon:setup()

vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {desc = "harpoon"})
vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, {desc = "harpoon add"})

vim.keymap.set("n", "<leader>hq", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>hw", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>he", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>hr", function() harpoon:list():select(4) end)

catppuccin.setup({ transparent_background = true })
