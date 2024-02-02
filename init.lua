require("set")
require("remap")
require("lazy-nvim")

vim.cmd.colorscheme("catppuccin")

-- obrir l'ajuda en vert split a la dreta
vim.api.nvim_create_autocmd("BufWinEnter", {
    group = vim.api.nvim_create_augroup("help_window_right", {}),
    pattern = { "*.txt" },
    callback = function()
        if vim.o.filetype == 'help' then vim.cmd.wincmd("L") end
    end
})

