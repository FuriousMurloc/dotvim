return
{
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    name = "neotree",
    lazy = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    keys = {
      {
        "<leader>t",
        function()
          require("neo-tree.command").
            execute({ toggle = true, source = "filesystem", position = "float", })
        end,
        desc = "Buffers (root dir)",
      },
      {
        "<leader>lt",
        function()
          require("neo-tree.command").
            execute({ toggle = true, source = "filesystem", position = "left", })
        end,
        desc = "Buffers (root dir)",
      },
    },

}

