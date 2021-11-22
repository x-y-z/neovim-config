local g = vim.g         				-- global variables

-- Add spaces after comment delimiters by default
g['NERDSpaceDelims'] = 1
-- Use compact syntax for prettified multi-line comments
g['NERDCompactSexyComs'] = 1
-- Align line-wise comment delimiters flush left instead of following code indentation
g['NERDDefaultAlign'] = 'left'
-- Allow commenting and inverting empty lines (useful when commenting a region)
g['NERDCommentEmptyLines'] = 1
-- Enable trimming of trailing whitespace when uncommenting
g['NERDTrimTrailingWhitespace'] = 1
-- Enable NERDCommenterToggle to check all selected lines is commented or not
g['NERDToggleCheckAllLines'] = 1
