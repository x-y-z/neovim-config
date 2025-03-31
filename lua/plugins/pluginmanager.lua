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
  {
    'nvim-treesitter/nvim-treesitter',
    config = function ()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
      })
    end
  },

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
      require'lspconfig'.rust_analyzer.setup{}
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
        formatters = {
          clang_format = {
            prepend_args = { '--style=file', '--fallback-style=LLVM'},
          },
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
    "Dan7h3x/neaterm.nvim",
    branch = "stable",
    event = "VeryLazy",
    opts = {
      keymaps = {
        new_horizontal = '<leader>t'
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "ibhagwan/fzf-lua",
    },
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
  },

  -- snacks
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      dashboard = {
        enabled = true,
        example = "files",
      },
      bufdelete = {
        enabled = true,
      },
      bigfile = {
        enabled = true,
      },
      lazygit = {
        enabled = true,
      }
    },
    keys = {
    --- bufdelete
      { "bd", function() Snacks.bufdelete() end, desc = "Buffer delete" },
    --- LSF
      { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
      { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
      { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
      { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
      { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
      { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
      { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
    --- Others
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
    },
  },

})

