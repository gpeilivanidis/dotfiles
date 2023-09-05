-- Define a function to toggle Zen Mode
local zen_mode_active = false

function ToggleZenMode()
    if zen_mode_active then
        -- Restore the original settings (exit Zen Mode)
        vim.cmd('set number')
        vim.cmd('set relativenumber')
        vim.cmd('set cmdheight=1')
        vim.cmd('set cursorline')
        vim.cmd('set signcolumn=yes')
        zen_mode_active = false
    else
        -- Enable Zen Mode settings
        vim.cmd('set nonumber')
        vim.cmd('set norelativenumber')
        vim.cmd('set cmdheight=0')
        vim.cmd('set nocursorline')
        vim.cmd('set signcolumn=no')
        zen_mode_active = true
    end
end

