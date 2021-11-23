-----------------------------------------------------------
-- Keymaps configuration file: keymaps of neovim
-- and plugins.
-----------------------------------------------------------

local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local cmd = vim.cmd
local g = vim.g         				-- global variables
local fn = vim.fn       				-- call Vim functions

-----------------------------------------------------------
-- Neovim shortcuts:
-----------------------------------------------------------

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
-- open terminal
map('n', '<C-t>', ':Term<CR>', { noremap = true })

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
map('v', '<', '<gv', default_opts)
map('v', '>', '>gv', default_opts)

-- interestingwords
map('n', '<leader>m', ':call InterestingWords("n")<cr>', default_opts)
map('v', '<leader>m', ':call InterestingWords("v")<cr>', default_opts)
map('n', '<leader>M', ':call UncolorAllWords<cr>', default_opts)
map('n', '<leader>mn', ':call WordNavigation(1)<cr>', default_opts)
map('n', '<leader>mN', ':call WordNavigation(0)<cr>', default_opts)

-- YankRing
map('n', '<leader>y', ':YRShow<cr>', {})

-- LeaderF

map('', '<leader>fb', ':<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>', default_opts)
map('', '<leader>fm', ':<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>', default_opts)
map('', '<leader>ft', ':<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>', default_opts)
map('', '<leader>fl', ':<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>', default_opts)

map('x', 'gf', ':<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>', default_opts)
map('', 'go', ':<C-U>Leaderf! rg --recall<CR>', default_opts)

map('', '<leader>fr', ':<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>', default_opts)
map('', '<leader>fd', ':<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>', default_opts)
map('', '<leader>fo', ':<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>', default_opts)
map('', '<leader>fn', ':<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>', default_opts)
map('', '<leader>fp', ':<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>', default_opts)

-- NERDCommenter
map('n', '<leader>#', '<Plug>NERDCommenterToggle', {})
map('v', '<leader>#', '<Plug>NERDCommenterToggle', {})

-- coc
local function check_back_space()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    return (col == 0 or vim.api.nvim_get_current_line():sub(col, col):match('%s')) and true
end

local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function _G.smart_tab()
    return fn.pumvisible() == 1 and t'<C-n>' or (check_back_space() and t'<TAB>' or fn['coc#refresh']())
end

function _G.smart_s_tab()
    return fn.pumvisible() == 1 and t'<C-p>' or t'<C-h>'
end

function _G.smart_enter()
    return fn.pumvisible() == 1 and fn['coc#_select_confirm']() or vim.api.nvim_eval('<C-g>u<CR><c-r>=coc#on_enter()<CR>')
end

map('i', '<TAB>', 'v:lua.smart_tab()', {noremap = true, silent = true, expr = true})
map('i', '<S-TAB>', 'v:lua.smart_s_tab()', {noremap = true, silent = true, expr = true})
map('i', '<c-space>', 'coc#refresh()', {noremap = true, silent = true, expr = true})
map('i', '<cr>', 'v:lua.smart_enter()', {noremap = true, silent = true, expr = true})

-- Quick editing
map('n', '<leader>ev', '<C-w>s<C-w>j:e $MYVIMRC<cr>', default_opts)
