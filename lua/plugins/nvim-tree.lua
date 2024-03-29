-----------------------------------------------------------
-- File manager configuration file
-----------------------------------------------------------

-- Plugin: nvim-tree
-- https://github.com/kyazdani42/nvim-tree.lua

-- Keybindings are defined in `keymapping.lua`:
--- https://github.com/kyazdani42/nvim-tree.lua#keybindings

-- Note: options under the g: command should be set BEFORE running the
--- setup function:
--- https://github.com/kyazdani42/nvim-tree.lua#setup
--- See: `help NvimTree`
local g = vim.g

g.nvim_tree_width_allow_resize  = 1

local function open_nvim_tree(data)

  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  -- create a new, empty buffer
  vim.cmd.enew()

  -- wipe the directory buffer
  vim.cmd.bw(data.buf)

  -- change to the directory
  vim.cmd.cd(data.file)

  -- open the tree
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

require('nvim-tree').setup {
  view = {
    width = 32,
  },
  filters = {
    dotfiles = true,
    custom = { '.git', 'node_modules', '.cache', '.bin' },
  },
  git = {
    ignore = true,
  },
  actions = {
    open_file = {
      resize_window = true
    }
  },
  renderer = {
    indent_markers = {
      enable = true
    },
    highlight_git = true,
    highlight_opened_files = "icon",
    icons = {
      show = {
        file = true,
        folder = true,
        git = true
      },
      glyphs = {
        default = "‣ "
      }
    }
  },
  respect_buf_cwd = true
}
