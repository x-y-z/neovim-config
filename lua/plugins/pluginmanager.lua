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
      local coq = require "coq"
      vim.lsp.config('clangd', coq.lsp_ensure_capabilities({
        cmd = {"clangd", "--header-insertion=never"}
      }))
      vim.lsp.enable('clangd')
      vim.lsp.config('pyright', coq.lsp_ensure_capabilities({}))
      vim.lsp.enable('pyright')
      vim.lsp.config('rust_analyzer', coq.lsp_ensure_capabilities({}))
      vim.lsp.enable('rust_analyzer')

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
  {
    "hat0uma/csvview.nvim",
    ---@module "csvview"
    ---@type CsvView.Options
    opts = {
      parser = { comments = { "#", "//" } },
      keymaps = {
        -- Text objects for selecting fields
        textobject_field_inner = { "if", mode = { "o", "x" } },
        textobject_field_outer = { "af", mode = { "o", "x" } },
        -- Excel-like navigation:
        -- Use <Tab> and <S-Tab> to move horizontally between fields.
        -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
        -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
        jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
        jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
        jump_next_row = { "<Enter>", mode = { "n", "v" } },
        jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
      },
    },
    cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
  },

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

  {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  },

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
      },
      input = {
        enabled = true,
      },
      picker = {
        enabled = true,
      },
      explorer = {
        enabled = true,
      },
    },
    keys = {
    -- find
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
      { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
      { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
    -- Grep
      { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
      { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
    -- search
      { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
      { '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
      { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
      { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
      { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
      { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
      { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
      { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
      { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
      { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
      { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
      { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
      { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
      { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
      { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
      { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
      { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
    --- search
      { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
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
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Buffer delete" },
    },
  },

})

