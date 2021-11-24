local g = vim.g         				-- global variables

g['Lf_HideHelp'] = 1
g['Lf_UseCache'] = 0
g['Lf_UseVersionControlTool'] = 0
g['Lf_IgnoreCurrentBufferName'] = 1
g['Lf_StlSeparator'] = { left = "\u{e0b0}", right = "\u{e0b2}", font = "DejaVu Sans Mono for Powerline" }
g['Lf_PreviewResult'] = {Function = 0, BufTag = 0, Rg = 1 }
g['Lf_FollowLinks'] = 1

g['Lf_ShortcutF'] = '<leader>ff'

g['Lf_GtagsStoreInProject'] = 1
g['Lf_GtagsAutoGenerate'] = 0
g['Lf_Gtagslabel'] = 'native-pygments'

g['Lf_RgConfig'] = {"--max-columns=150", "--type-add web:*.{html,css,js}*", "--glob=!git/*", "--hidden"}
