local g = vim.g         				-- global variables
local fn = vim.fn

local vim_data_path = fn.stdpath('data')
local yankring_dir = vim_data_path..'/tmp/yankring'

fn.mkdir(yankring_dir, "p")

g['yankring_replace_n_pkey'] = '<leader>['
g['yankring_replace_n_nkey'] = '<leader>]'
g['yankring_history_dir'] = yankring_dir
