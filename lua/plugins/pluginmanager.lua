-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: packer.nvim
-- https://github.com/wbthomason/packer.nvim


local fn = vim.fn
local g = vim.g                 -- global variables

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
    "neovim/nvim-lspconfig", -- REQUIRED: for native Neovim LSP integration
    lazy = false, -- REQUIRED: tell lazy.nvim to start this plugin at startup
    dependencies = {
      -- main one
      { "ms-jpq/coq_nvim", branch = "coq" },

      -- 9000+ Snippets
      { "ms-jpq/coq.artifacts", branch = "artifacts" },

      -- lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
      -- Need to **configure separately**
      { 'ms-jpq/coq.thirdparty', branch = "3p" }
      -- - shell repl
      -- - nvim lua api
      -- - scientific calculator
      -- - comment banner
      -- - etc
    },
    init = function()
      vim.g.coq_settings = {
          auto_start = true, -- if you want to start COQ at startup
          ["display.statusline.helo"] = false,
          ["keymap.jump_to_mark"] = "<c-m>"
          -- Your COQ settings here
      }
    end,
    config = function()
      require'lspconfig'.clangd.setup{}
      require'lspconfig'.pyright.setup{}
      -- Your LSP settings here
    end,
  },

  -- formatter
  {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          -- Conform will run multiple formatters sequentially
          python = { "black" },
          -- You can customize some of the format options for the filetype (:help conform.format)
          rust = { "rustfmt", lsp_format = "fallback" },
          c = { "clang-format" },
          cpp = { "clang-format" },
        },
      })
    end,
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

  -- cscope
  'dhananjaylatkar/cscope_maps.nvim',

  -- diffview
  'sindrets/diffview.nvim',

  --leap
  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').create_default_mappings()
    end
  }

})

