--[[

  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝


Neovim init file
Based on: https://github.com/brainfucksec/neovim-lua

--]]

-----------------------------------------------------------
-- Import Lua modules
-----------------------------------------------------------
require('plugins/packer')
require('settings')
require('keymaps')
require('plugins/lualine')
require('plugins/numbers')
require('plugins/interestingwords')
require('plugins/YankRing')
require('plugins/LeaderF')
require('plugins/nerdcommenter')
require('plugins/nvim-tree')
require('plugins/indent-blankline')
require('plugins/vista')
require('plugins/nvim-treesitter')
require('plugins/alpha-nvim')
require('plugins/coc')
require('plugins/wilder')
require('plugins/csv')
