-----------------------------------------------------------
-- Keymaps configuration file: keymaps of neovim
-- and plugins.
-----------------------------------------------------------

local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local noremap_opt = { noremap = true}
local cmd = vim.cmd
local g = vim.g         				-- global variables
local fn = vim.fn       				-- call Vim functions

-----------------------------------------------------------
-- Neovim shortcuts:
-----------------------------------------------------------

-- neovim command
map('c', '<c-a>', '<home>', {noremap = true})
map('c', '<c-e>', '<end>', {noremap = true})

-- clear search highlighting
map('n', '<leader><space>', ':noh<CR>:call clearmatches()<CR>', default_opts)

-- map Esc to kk
map('i', 'kk', '<Esc>', {noremap = true})

-- don't use arrow keys
map('', '<up>', '<nop>', { noremap = true })
map('', '<down>', '<nop>', { noremap = true })
map('', '<left>', '<nop>', { noremap = true })
map('', '<right>', '<nop>', { noremap = true })

-- fast saving with <leader> and s
map('n', '<leader>s', ':w<CR>', default_opts)
map('i', '<leader>s', '<C-c>:w<CR>', default_opts)

-- move around splits using Ctrl + {h,j,k,l}
map('n', '<C-h>', '<C-w>h', default_opts)
map('n', '<C-j>', '<C-w>j', default_opts)
map('n', '<C-k>', '<C-w>k', default_opts)
map('n', '<C-l>', '<C-w>l', default_opts)

-- close all windows and exit from neovim
map('n', '<leader>q', ':qa!<CR>', default_opts)

-----------------------------------------------------------
-- Applications & Plugins shortcuts:
-----------------------------------------------------------
-- terminal normal mode
map('t', '<Esc>', '<C-\\><C-n>', noremap_opt)

-- nvim-tree
map('n', '<C-n>', ':NvimTreeToggle<CR>', default_opts)       -- open/close
map('n', '<leader>r', ':NvimTreeRefresh<CR>', default_opts)  -- refresh
-- map('n', '<leader>n', ':NvimTreeFindFile<CR>', default_opts) -- search file

-- Vista tag-viewer
map('n', '<C-m>', ':Vista!!<CR>', default_opts)   -- open/close

-- bufferline
map('n', '<leader>k', ':BufferLineCycleNext<CR>', default_opts)
map('n', '<leader>j', ':BufferLineCyclePrev<CR>', default_opts)

-- Splits ,v and ,h to open new splits (vertical and horizontal)
map('n', '<leader>v', '<C-w>v<C-w>l', default_opts)
map('n', '<leader>h', '<C-w>s<C-w>j', default_opts)

-- Reselect visual block after indent/outdent
map('v', '<', '<gv', noremap_opt)
map('v', '>', '>gv', noremap_opt)

-- interestingwords
map('n', '<leader>m', ':call InterestingWords("n")<cr>', default_opts)
map('v', '<leader>m', ':call InterestingWords("v")<cr>', default_opts)
map('n', '<leader>M', ':call UncolorAllWords()<cr>', default_opts)
map('n', '<leader>mn', ':call WordNavigation(1)<cr>', default_opts)
map('n', '<leader>mN', ':call WordNavigation(0)<cr>', default_opts)

-- YankRing
map('n', '<leader>y', ':lua require("telescope").extensions.neoclip.default()<cr>', {})

-- NERDCommenter
map('n', '<leader>#', '<Plug>NERDCommenterToggle', {})
map('v', '<leader>#', '<Plug>NERDCommenterToggle', {})

-- remove trailing whitespace
map('n', '<leader>w', ':%s/\\s\\+$//e<cr>', default_opts)

-- Quick editing
map('n', '<leader>ev', '<C-w>s<C-w>j:e $MYVIMRC<cr>', default_opts)

-- change numbering or other extra display
map('n', '<leader>ll', ':set invlist<cr>', {silent = true})
map('n', '<leader>nn', ':set invnumber<cr>', {silent = true})
map('n', '<leader>pp', ':set invpaste<cr>', {silent = true})
map('n', '<leader>ii', ':set invrelativenumber<cr>', {silent = true})
map('n', '<leader>hh', ':set invnumber<CR>:set invrelativenumber<CR>:set invlist<CR>', {silent = true})


-- Don't jump when using * for search
map('n', '*', '*<c-o>', noremap_opt)

-- Keep search matches in the middle of the window.
map('n', 'n', 'nzzzv', noremap_opt)
map('n', 'N', 'Nzzzv', noremap_opt)

-- Same when jumping around
map('n', 'g;', 'g;zz', noremap_opt)
map('n', 'g,', 'g,zz', noremap_opt)

-- more natural movement with wrap on
map('n', 'j', 'gj', noremap_opt)
map('n', 'k', 'gk', noremap_opt)
map('v', 'j', 'gj', noremap_opt)
map('v', 'k', 'gk', noremap_opt)

-- sane regexes
map('n', '/', '/\\v', noremap_opt)
map('v', '/', '/\\v', noremap_opt)

-- conform
vim.keymap.set("v", "<leader>=", function()
    require("conform").format()
      -- Escape visual mode
    vim.api.nvim_input("<esc>")
  end,
  { buffer = bufnr, remap = false, silent = true }
)

-- lsp
map('n', ']g', ':lua vim.diagnostic.jump({count=1, float=false})<cr>', noremap_opt)
map('n', '[g', ':lua vim.diagnostic.jump({count=-1, float=false})<cr>', noremap_opt)
