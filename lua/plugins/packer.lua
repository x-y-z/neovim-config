-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: packer.nvim
-- https://github.com/wbthomason/packer.nvim

-- For information about installed plugins see the README
--- neovim-lua/README.md
--- https://github.com/brainfucksec/neovim-lua#readme


local fn = vim.fn
local g = vim.g         				-- global variables
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd[[packadd packer.nvim]]
end

-- Add packages
return require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- packer can manage itself

  -- file explorer
  use 'kyazdani42/nvim-tree.lua'

  -- indent line
  use 'lukas-reineke/indent-blankline.nvim'

  -- autopair
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end
  }

  -- icons
  use 'kyazdani42/nvim-web-devicons'

  -- tagviewer
  use 'liuchengxu/vista.vim'

  -- treesitter interface
  use 'nvim-treesitter/nvim-treesitter'

  -- colorschemes
  use 'tanvirtin/monokai.nvim'

  use { 'rose-pine/neovim', as = 'rose-pine' }

  use {
    'tomasr/molokai',
    as = 'molokai',
    config = function ()
      vim.cmd[[colorscheme molokai]]
    end
  }


  -- statusline
  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  -- git
  use {
    'tpope/vim-fugitive'
  }

  -- git labels
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup()
    end
  }

  -- dashboard
  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function ()
      require'alpha'.setup(require'alpha.themes.startify'.opts)
    end
  }

  use {
    'akinsho/bufferline.nvim',
    requires = {'kyazdani42/nvim-web-devicons'},
    config = function ()
      require('bufferline').setup()
    end
  }

  use {
    'x-y-z/numbers.vim',
  }

  use {
    'lfv89/vim-interestingwords'
  }

  use {
    "AckslD/nvim-neoclip.lua",
    requires = {
      {'tami5/sqlite.lua', module = 'sqlite'},
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
  }

  use {
    'Yggdroot/LeaderF',
    run = function()
        vim.cmd[[:LeaderfInstallCExtension]]
    end,
  }

  -- comment
  use {
    'scrooloose/nerdcommenter'
  }

  -- language server
  use {
    'neoclide/coc.nvim',
    branch = 'release'
  }

  -- async make or other command
  use {
    'tpope/vim-dispatch'
  }

  -- better vim menu
  use {
    'gelguy/wilder.nvim',
    requires = { 'romgrk/fzy-lua-native' }
  }

  -- automatically ask sudo permission if file is not writable.
  use {
    'lambdalisue/suda.vim'
  }

  -- complete code block
  use {
    'tpope/vim-endwise'
  }

  -- fancy csv format
  use {
    'chrisbra/csv.vim'
  }

  use {
    "akinsho/toggleterm.nvim",
  }
  -- highlight todo
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {}
    end
  }

  -- new text surrounding targets, like da, for "ad, sdfads, saf"
  use {
    "wellle/targets.vim",
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end

end)
