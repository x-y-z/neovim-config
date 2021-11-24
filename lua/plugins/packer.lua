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
    'bling/vim-airline'
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
        require'alpha'.setup(require'alpha.themes.dashboard'.opts)
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
    'myusuf3/numbers.vim',
  }

  use {
    'lfv89/vim-interestingwords'
  }

  use {
    'vim-scripts/YankRing.vim',
    run = function ()
      local yankring_dir = fn.stdpath('data')..'/tmp/yankring'
      fn.system({'mkdir', yankring_dir})
    end
  }

  use {
    'Yggdroot/LeaderF',
    run = function()
        vim.cmd[[:LeaderfInstallCExtension]]
    end,
  }

  use {
    'scrooloose/nerdcommenter'
  }

  use {
    'neoclide/coc.nvim',
    branch = 'release'
  }

  use {
    'tpope/vim-dispatch'
  }

  use {
    'gelguy/wilder.nvim',
    requires = { 'romgrk/fzy-lua-native' }
  }

  use {
    'lambdalisue/suda.vim'
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end

end)
