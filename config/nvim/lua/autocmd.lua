vim.cmd([[
  augroup norg_settings
    autocmd!
    autocmd BufRead,BufNewFile *.norg lua ToggleZenMode() 
  augroup END
]])
