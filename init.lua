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
require('plugins/pluginmanager')
require('settings')
require('keymaps')
require('plugins/lualine')
require('plugins/numbers')
require('plugins/interestingwords')
require('plugins/nerdcommenter')
require('plugins/nvim-tree')
require('plugins/indent-blankline')
require('plugins/vista')
require('plugins/nvim-treesitter')
require('plugins/wilder')
require('plugins/csv')
require('plugins/conform')
