function create_command(command, func)
    vim.api.nvim_create_user_command(command, func, { nargs = 0 })
end
function map(mode, key, func, config)
    vim.keymap.set(mode, key, func, config)
end
-- General configs
create_command('Fmt', function () require 'conform'.format({ lsp_format = 'fallback' }) end)
create_command('Impl', function () vim.lsp.buf.definition() end)
create_command('Rename', function () vim.lsp.buf.rename() end)
create_command('Hover', function () vim.lsp.buf.hover() end)
create_command('Codeaction', function () vim.lsp.buf.code_action() end)
create_command('Diag', function () vim.diagnostic.open_float() end)

map('n', '<leader>qf', function () require('trouble').toggle() end, { desc = 'Quick fix' })
map('n', '<F12>', function () vim.lsp.buf.definition() end, { desc = 'Go to implementation' })

map('n', '<leader>f', function () require 'snacks'.picker.smart() end, { noremap = true, desc = 'Find files' })
map({ 'n', 't' }, '<C-t>', function () require 'snacks'.terminal.toggle() end, { desc = 'Toggle terminal' })
map('n', '<leader>e', function () require 'snacks'.explorer() end, { desc = 'Open explorer' })

map('n', '<leader>db', function () require 'dap'.toggle_breakpoint() end, { desc = 'DAP Toggle breakpoint' })
map('n', '<leader>dso', function () require 'dap'.step_over() end, { desc = 'DAP Step over' })
map('n', '<leader>dsi', function () require 'dap'.step_into() end, { desc = 'DAP Step into' })
map('n', '<leader>dc', function () require 'dap'.continue() end, { desc = 'DAP continue' })

map('i', '<a-e>', "<esc>l<cmd>lua require('nvim-autopairs.fastwrap').show()<cr>", { noremap = true })

-- Bufdelete stuff
map('n', '<leader>bd', function ()
    require 'snacks'.bufdelete()
end, { silent = true, noremap = true, desc = 'Bufdelete' }
)
