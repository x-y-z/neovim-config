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

-- LeaderF

map('', '<leader>ff', ':LeaderfFile<CR>', default_opts)
map('', '<leader>fb', ':<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>', default_opts)
map('', '<leader>fm', ':<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>', default_opts)
map('', '<leader>ft', ':<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>', default_opts)
map('', '<leader>fl', ':<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>', default_opts)

map('x', 'gf', ':<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>', default_opts)
map('', 'go', ':<C-U>Leaderf! rg --recall<CR>', default_opts)
map('n', '<leader>a', ':Leaderf rg ', default_opts)

map('', '<leader>fr', ':<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>', default_opts)
map('', '<leader>fd', ':<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>', default_opts)
map('', '<leader>fo', ':<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>', default_opts)
map('', '<leader>fn', ':<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>', default_opts)
map('', '<leader>fp', ':<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>', default_opts)
map('', '<leader>t', ':LeaderfFunction!<cr>', default_opts)

-- NERDCommenter
map('n', '<leader>#', '<Plug>NERDCommenterToggle', {})
map('v', '<leader>#', '<Plug>NERDCommenterToggle', {})

-- coc
-- Autocomplete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use Tab for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
-- other plugins before putting this into your config

local coc_opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
map("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', coc_opts)
map("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], coc_opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
map("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], coc_opts)

-- Use <c-j> to trigger snippets
map("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)", {})
-- Use <c-space> to trigger completion
map("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
map("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
map("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

-- GoTo code navigation
map("n", "gd", "<Plug>(coc-definition)", {silent = true})
map("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
map("n", "gi", "<Plug>(coc-implementation)", {silent = true})
map("n", "gr", "<Plug>(coc-references)", {silent = true})


-- Use K to show documentation in preview window
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
map("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})


-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})


-- Symbol renaming
map("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})


-- Formatting selected code
map("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
map("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})


-- Setup formatexpr specified filetype(s)
vim.api.nvim_create_autocmd("FileType", {
    group = "CocGroup",
    pattern = "typescript,json",
    command = "setl formatexpr=CocAction('formatSelected')",
    desc = "Setup formatexpr specified filetype(s)."
})

-- Update signature help on jump placeholder
vim.api.nvim_create_autocmd("User", {
    group = "CocGroup",
    pattern = "CocJumpPlaceholder",
    command = "call CocActionAsync('showSignatureHelp')",
    desc = "Update signature help on jump placeholder"
})

-- Apply codeAction to the selected region
-- Example: `<leader>aap` for current paragraph
local coc_opts = {silent = true, nowait = true}
map("x", "<leader>a", "<Plug>(coc-codeaction-selected)", coc_opts)
map("n", "<leader>a", "<Plug>(coc-codeaction-selected)", coc_opts)

-- Remap keys for apply code actions at the cursor position.
map("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", coc_opts)
-- Remap keys for apply code actions affect whole buffer.
map("n", "<leader>as", "<Plug>(coc-codeaction-source)", coc_opts)
-- Remap keys for applying codeActions to the current buffer
map("n", "<leader>ac", "<Plug>(coc-codeaction)", coc_opts)
-- Apply the most preferred quickfix action on the current line.
map("n", "<leader>qf", "<Plug>(coc-fix-current)", coc_opts)

-- Remap keys for apply refactor code actions.
map("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
map("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
map("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

-- Run the Code Lens actions on the current line
map("n", "<leader>cl", "<Plug>(coc-codelens-action)", coc_opts)


-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server
map("x", "if", "<Plug>(coc-funcobj-i)", coc_opts)
map("o", "if", "<Plug>(coc-funcobj-i)", coc_opts)
map("x", "af", "<Plug>(coc-funcobj-a)", coc_opts)
map("o", "af", "<Plug>(coc-funcobj-a)", coc_opts)
map("x", "ic", "<Plug>(coc-classobj-i)", coc_opts)
map("o", "ic", "<Plug>(coc-classobj-i)", coc_opts)
map("x", "ac", "<Plug>(coc-classobj-a)", coc_opts)
map("o", "ac", "<Plug>(coc-classobj-a)", coc_opts)


-- Remap <C-f> and <C-b> to scroll float windows/popups
---@diagnostic disable-next-line: redefined-local
local coc_opts = {silent = true, nowait = true, expr = true}
map("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', coc_opts)
map("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', coc_opts)
map("i", "<C-f>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', coc_opts)
map("i", "<C-b>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', coc_opts)
map("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', coc_opts)
map("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', coc_opts)


-- Use CTRL-S for selections ranges
-- Requires 'textDocument/selectionRange' support of language server
map("n", "<C-s>", "<Plug>(coc-range-select)", {silent = true})
map("x", "<C-s>", "<Plug>(coc-range-select)", {silent = true})


-- Add `:Format` command to format current buffer
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

-- " Add `:Fold` command to fold current buffer
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})

-- Add `:OR` command for organize imports of the current buffer
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

-- Add (Neo)Vim's native statusline support
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline
vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

-- Mappings for CoCList
-- code actions and coc stuff
---@diagnostic disable-next-line: redefined-local
local coc_opts = {silent = true, nowait = true}
-- Show all diagnostics
map("n", "<space>a", ":<C-u>CocList diagnostics<cr>", coc_opts)
-- Manage extensions
map("n", "<space>e", ":<C-u>CocList extensions<cr>", coc_opts)
-- Show commands
map("n", "<space>c", ":<C-u>CocList commands<cr>", coc_opts)
-- Find symbol of current document
map("n", "<space>o", ":<C-u>CocList outline<cr>", coc_opts)
-- Search workspace symbols
map("n", "<space>s", ":<C-u>CocList -I symbols<cr>", coc_opts)
-- Do default action for next item
map("n", "<space>j", ":<C-u>CocNext<cr>", coc_opts)
-- Do default action for previous item
map("n", "<space>k", ":<C-u>CocPrev<cr>", coc_opts)
-- Resume latest coc list
map("n", "<space>p", ":<C-u>CocListResume<cr>", coc_opts)


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

-- cscope
map('n', '<C-]>s', ':cs find s <C-R>=expand("<cword>")<CR><CR>', {})
map('n', '<C-]>g', ':cs find g <C-R>=expand("<cword>")<CR><CR>', {})
map('n', '<C-]>c', ':cs find c <C-R>=expand("<cword>")<CR><CR>', {})
map('n', '<C-]>t', ':cs find t <C-R>=expand("<cword>")<CR><CR>', {})
map('n', '<C-]>e', ':cs find e <C-R>=expand("<cword>")<CR><CR>', {})
map('n', '<C-]>f', ':cs find f <C-R>=expand("<cfile>")<CR><CR>', {})
map('n', '<C-]>i', ':cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>', {})
map('n', '<C-]>d', ':cs find d <C-R>=expand("<cword>")<CR><CR>', {})
