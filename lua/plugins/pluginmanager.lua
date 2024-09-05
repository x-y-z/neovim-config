-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: packer.nvim
-- https://github.com/wbthomason/packer.nvim


local fn = vim.fn
local g = vim.g         				-- global variables

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

g.mapleader = ','             -- change leader to a comma

-- Add packages
return require('lazy').setup({
  -- file explorer
  'kyazdani42/nvim-tree.lua',

  -- indent line
  {'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    opts = {}
  },

  -- autopair
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({map_cr=false})
    end
  },

  -- icons
  'kyazdani42/nvim-web-devicons',

  -- tagviewer
  'liuchengxu/vista.vim',

  -- treesitter interface
  'nvim-treesitter/nvim-treesitter',

  -- colorschemes
  'tanvirtin/monokai.nvim',

  { 'rose-pine/neovim', name = 'rose-pine' },

  {
    'tomasr/molokai',
    config = function ()
      vim.cmd[[colorscheme molokai]]
    end
  },


  -- statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {'kyazdani42/nvim-web-devicons', opt = true}
  },

  -- git
  'tpope/vim-fugitive',

  -- git labels
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup()
    end
  },

  -- dashboard
  {
    'goolord/alpha-nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function ()
      require'alpha'.setup(require'alpha.themes.startify'.opts)
    end
  },

  {
    'akinsho/bufferline.nvim',
    branch = 'main',
    dependencies = {'kyazdani42/nvim-web-devicons'},
    config = function ()
      require('bufferline').setup()
    end
  },

  'x-y-z/numbers.vim',

  'lfv89/vim-interestingwords',

  {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
      {
        'tami5/sqlite.lua',
        config = function ()
          if vim.loop.os_uname().sysname == "Darwin" then
            vim.cmd[[let g:sqlite_clib_path = '/opt/local/lib/libsqlite3.dylib']]
          end
        end
      },
      {'nvim-telescope/telescope.nvim'},
    },
    config = function()
      require('neoclip').setup({
      enable_persistent_history = true,
      on_paste = {
        set_reg = true,
      },
      })
    end,
  },

  {
    'Yggdroot/LeaderF',
    build = function()
        vim.cmd[[:LeaderfInstallCExtension]]
    end,
  },

  -- comment
  'scrooloose/nerdcommenter',

  -- language server
  {
    'neoclide/coc.nvim',
    branch = 'release',
  },

  -- async make or other command
  'tpope/vim-dispatch',

  -- better vim menu
  {
    'gelguy/wilder.nvim',
    dependencies = { 'romgrk/fzy-lua-native' }
  },

  -- automatically ask sudo permission if file is not writable.
  'lambdalisue/suda.vim',

  -- complete code block
  'tpope/vim-endwise',

  -- fancy csv format
  'chrisbra/csv.vim',

  {
    "akinsho/toggleterm.nvim",
    branch = 'main'
  },
  -- highlight todo
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {}
    end
  },

  -- new text surrounding targets, like da, for "ad, sdfads, saf"
  "wellle/targets.vim",

  -- clang-format
  'rhysd/vim-clang-format',

  -- cscope
  'dhananjaylatkar/cscope_maps.nvim',

  -- diffview
  'sindrets/diffview.nvim',

})

