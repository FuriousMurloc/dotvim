return 	{
  {'nvim-telescope/telescope.nvim', tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      {
        "<leader>ff", function() require('telescope.builtin').find_files() end,
      },
      {
        "<leader>fb", function() require('telescope.builtin').buffers() end,
      },
      {
        "<leader>fh", function() require('telescope.builtin').help_tags() end,
      },
      {
        "<leader>fg", function() require('telescope.builtin').live_grep() end,
      },
      {
        "<leader>gf", function() require('telescope.builtin').git_files() end,
      },
      {
        "<leader>gb", function() require('telescope.builtin').git_branches() end,
      },
      {
        "<leader>jl", function() require('telescope.builtin').jumplist() end,
      },
    },
  }
}

