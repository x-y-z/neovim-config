local cmd = vim.cmd     				-- execute Vim commands

cmd [[
    let g:clang_format#style_options = {
        \ "BasedOnStyle" : "Google",
        \ "IndentWidth": 4,
        \ "AccessModifierOffset": -2,
        \ "DerivePointerAlignment": "false"}
    " map to <Leader>cf in C++ code
    autocmd FileType cpp nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
    autocmd FileType cpp vnoremap <buffer><Leader>cf :ClangFormat<CR>
    " Toggle auto formatting:
    nmap <Leader>C :ClangFormatAutoToggle<CR>
    " autocmd FileType cpp ClangFormatAutoEnable
]]
