-- General configs
vim.api.nvim_create_user_command('Fmt', function() vim.lsp.buf.format() end, { nargs = 0 })
vim.api.nvim_create_user_command('Impl',function() vim.lsp.buf.definition() end, { nargs = 0 })
vim.api.nvim_create_user_command('Rename',function() vim.lsp.buf.rename() end, { nargs = 0 })
vim.api.nvim_create_user_command('Hover',function() vim.lsp.buf.hover() end, { nargs = 0 })
vim.api.nvim_create_user_command('Codeaction',function() vim.lsp.buf.code_action() end, { nargs = 0 })
vim.api.nvim_create_user_command('Diag',function() vim.diagnostic.open_float() end, { nargs = 0 })
vim.api.nvim_create_user_command( -- Lua Exec
  'Le',
  function(args)
    vim.api.nvim_exec([[pu=execute('lua ]] .. args.args ..  [[')]], false)
  end,
  { nargs = '*' }
)
vim.keymap.set(
	'n',
	'<leader>qf',
	function() require('trouble').toggle() end
)

-- Bufdelete stuff
vim.keymap.set('n','<leader>bd',function ()
	require('bufdelete').bufdelete(0,false)
end,{silent=true, noremap=true} )
