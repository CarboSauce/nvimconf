if vim.g.vscode then
	return 
end

vim.o.listchars="tab:▸\\ ,extends:❯,precedes:❮,nbsp:␣"
vim.o.tabstop=4
vim.o.shiftwidth=4
vim.o.softtabstop=-1
vim.o.copyindent=true
vim.o.guicursor="n-v-c:block-Cursor,i:block-iCursor"
vim.o.relativenumber=true
vim.o.number=true
vim.o.mouse="a"
vim.o.hlsearch=false
vim.o.foldlevelstart=99
vim.o.foldenable=false
vim.o.expandtab=true
--vim.o.sessionoptions=globals
vim.o.termguicolors=true
vim.g.mapleader=';'
vim.g.maplocalleader=';'
vim.keymap.set('n','<leader>;', ';')
vim.keymap.set('n',';','<Nop>')

vim.keymap.set('n','<C-k>','<C-u>')

vim.keymap.set('n','<C-j>','<C-d>')
vim.keymap.set('i','<C-l>','<Esc>w')
vim.keymap.set('i','<C-h>','<Esc>b')
vim.keymap.set('i','<C-k>','<Esc>k')
vim.keymap.set('n','<M-k>', ":m-2<CR>==")
vim.keymap.set('n','<M-j>', ":m+1<CR>==")
vim.keymap.set('v','<M-j>', ":m '>+1<CR>gv=gv")
vim.keymap.set('v','<M-k>', ":m '<-2<CR>gv=gv")

vim.keymap.set('v','<leader>y','"+y')
vim.keymap.set('n','<leader>y','"+y')
vim.keymap.set('v','<leader>p','"+p')
vim.keymap.set('v','<leader>P','"+P')
vim.keymap.set('n','<leader>p','"+p')
vim.keymap.set('n','<leader>P','"+P')

vim.keymap.set('n','<S-h>',':bp<CR>')
vim.keymap.set('n','<S-l>',':bn<CR>')

vim.keymap.set('n','<leader>e', ':NvimTreeToggle<CR>')
vim.keymap.set('t','<Esc>','<C-\\><C-n>')

require('init')

vim.cmd("colorscheme xcodedarkhc")

vim.cmd("highlight Cursor guifg=none guibg=pink")
vim.cmd("highlight iCursor guifg=none guibg=#99bbff")
if vim.g.neovide then
	vim.g.neovide_scroll_animation_length = 0.05
else
	vim.cmd("highlight Normal guibg=none ctermbg=none")
	vim.cmd("highlight NormalNc guibg=none ctermbg=none")
	vim.cmd("highlight LineNr guibg=none ctermbg=none")
	vim.cmd("highlight SignColumn guibg=none ctermbg=none")
	vim.cmd("highlight! StatusColumn guibg=none ctermbg=none")
	vim.cmd("highlight! StatusLine guibg=none ctermbg=none")
	vim.cmd("highlight! TabLine guibg=none ctermbg=none")
	vim.cmd("highlight! TabLineFill guibg=none ctermbg=none")
	vim.cmd("highlight! EndOfBuffer guibg=none ctermbg=none")
end
