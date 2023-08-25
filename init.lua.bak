-- shortcuts
  local map = vim.api.nvim_set_keymap
  local default_opts = { noremap = true, silent = true }
  local exec = vim.api.nvim_exec 	-- execute Vimscript
  local g = vim.g
  local cmd = vim.cmd
  local opt = vim.opt

function nvim_tree()
  --remappings
  map("n","<C-t>",":NvimTreeToggle<CR>",default_opts)
  map("n", "<leader>r", ":NvimTreeRefresh<CR>", default_opts)
  map("n", "<leader>n", ":NvimTreeFindFile<CR>", default_opts)
  -- graphic settings
  g.nvim_tree_icons = {
    git = {
     unstaged = "✗",
     staged = "✓",
     unmerged = "u",
     renamed = "➜",
     untracked = ".",
     deleted = "r",
     ignored = "~"
    },
    folder = {
      arrow_open = "",
      default = "+",
      open = "-",
      empty = "+",
      arrow_closed = "",
      symlink = "",
      symlink_open = "",
    }
  }
  -- plugin configuration
  require'nvim-tree'.setup {
    disable_netrw       = true,
    hijack_netrw        = true,
    open_on_setup       = false,
    ignore_ft_on_setup  = {},
    auto_close          = false,
    open_on_tab         = false,
    hijack_cursor       = false,
    update_cwd          = false,
    update_to_buf_dir   = {
      enable = true,
      auto_open = true,
    },
    diagnostics = {
      enable = false,
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      }
    },
    update_focused_file = {
      enable      = false,
      update_cwd  = false,
      ignore_list = {}
    },
    system_open = {
      cmd  = nil,
      args = {}
    },
    filters = {
      dotfiles = false,
      custom = {}
    },
    git = {
      enable = true,
      ignore = true,
      timeout = 500,
    },
    view = {
      width = 30,
      height = 30,
      hide_root_folder = false,
      side = 'left',
      auto_resize = false,
      mappings = {
        custom_only = false,
        list = {}
      },
      number = false,
      relativenumber = false
    },
    trash = {
      cmd = "trash",
      require_confirm = true
    }
  }
end
function file_tree()
end
function tabulation()
  opt.expandtab = true      -- use spaces instead of tabs
  opt.shiftwidth = 2        -- shift 4 spaces when tab
  opt.tabstop = 2           -- 1 tab == 4 spaces
  opt.smartindent = true    -- autoindent new lines
end

function gui()
  opt.number = true             -- show line number
  opt.relativenumber = true             -- show line number
  opt.showmatch = true          -- highlight matching parenthesis
  opt.foldmethod = 'indent'     -- enable folding (default 'foldmarker')
  opt.colorcolumn = '80'        -- line lenght marker at 80 columns
  opt.splitright = true         -- vertical split to the right
  opt.splitbelow = true         -- orizontal split to the bottom
  opt.ignorecase = true         -- ignore case letters when search
  opt.smartcase = true          -- ignore lowercase for the whole pattern
  opt.linebreak = true          -- wrap on word boundary
  opt.termguicolors = true
end

function gruvbox()
  g.gruvbox_bold = 1
  g.gruvbox_italic = 1
  g.gruvbox_contrast_light = "hard"
  g.gruvbox_contrast_dark = "hard"
  g.gruvbox_italicize_strings=1
end

function fancy_vim_things()
  -- delete blank spaces at the end of lines
  cmd [[au BufWritePre * :%s/\s\+$//e]]
  -- highlight al copiar en vim
  exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
  augroup end
  ]], false)
end

-- main

cmd [[colorscheme gruvbox]]
gui()
tabulation()
gruvbox()
file_tree()
nvim_tree()


require'lspconfig'.rls.setup{
	settings = {
    rust = {
      unstable_features = true,
      build_on_save = true,
      all_features = true,
    },
  },
}

