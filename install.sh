cp -r nvim ~/.config
local_folder=~/.local/share/nvim/site/pack/main/start/
mkdir -p $local_folder
cd $local_folder
git clone https://github.com/kyazdani42/nvim-tree.lua
git clone https://github.com/neovim/nvim-lspconfig
git clone https://github.com/morhetz/gruvbox
