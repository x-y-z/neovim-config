local opt = vim.opt         		-- global/buffer/windows-scoped options

opt.encoding = 'utf-8'
opt.hidden = true
-- opt.nobackup = true
-- opt.nowritebackup = true

opt.cmdheight = 2

opt.updatetime = 300

table.insert(opt.shortmess, 'c')

opt.signcolumn = 'yes'

vim.cmd [[
    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
    ]]
