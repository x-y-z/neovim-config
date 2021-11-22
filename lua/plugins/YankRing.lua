local g = vim.g         				-- global variables
local fn = vim.fn

local vim_data_path = fn.stdpath('data')

g['yankring_replace_n_pkey'] = '<leader>['
g['yankring_replace_n_nkey'] = '<leader>]'
g['yankring_history_dir'] = vim_data_path..'/tmp/yankring'
