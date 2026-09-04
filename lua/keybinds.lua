-- General configs
vim.api.nvim_create_user_command('Fmt', function() vim.lsp.buf.format() end, { nargs = 0 })
vim.api.nvim_create_user_command('Impl',function() vim.lsp.buf.definition() end, { nargs = 0 })
vim.api.nvim_create_user_command('Rename',function() vim.lsp.buf.rename() end, { nargs = 0 })
vim.api.nvim_create_user_command('Hover',function() vim.lsp.buf.hover() end, { nargs = 0 })
vim.api.nvim_create_user_command('Codeaction',function() vim.lsp.buf.code_action() end, { nargs = 0 })
vim.api.nvim_create_user_command('Diag',function() vim.diagnostic.open_float() end, { nargs = 0 })

vim.keymap.set(
	'n',
	'<leader>qf',
	function() require('trouble').toggle() end,
    { desc = 'Quick fix'}
)

vim.keymap.set(
	'n',
	'<leader>tf',
    '<cmd>Telescope file_browser<CR>',
	{noremap = true, desc = 'Telescope file browser'}
)


vim.keymap.set(
    'i',
    '<a-e>',
    "<esc>l<cmd>lua require('nvim-autopairs.fastwrap').show()<cr>",
    { noremap = true }
)

-- Bufdelete stuff
vim.keymap.set('n','<leader>bd',function ()
	require('bufdelete').bufdelete(0,false)
end,{silent=true, noremap=true, desc = 'Bufdelete'} )
