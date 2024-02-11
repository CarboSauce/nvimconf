set listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣
set tabstop=4
set shiftwidth=4
set softtabstop=-1
set copyindent
set guicursor=n-v-c:block-Cursor,i:block-iCursor
set number relativenumber
set mouse=a
set nohlsearch
set foldlevelstart=99
set nofoldenable
set sessionoptions+=globals
set guifont=Terminus:h12
let mapleader = ";"
" Keybindings
noremap <leader>; ;
noremap ; <Nop>

" " Jump to next word with ctrl+j/l
nnoremap <C-l>	w
nnoremap <C-h>	b
" Hack for <C-i>
nnoremap <C-k>	<C-u>
" nnoremap <Tab>	<C-u>
nnoremap <C-j>	<C-d>
inoremap <C-l>	<Esc>w
inoremap <C-h>	<Esc>b
inoremap <C-k>	<Esc>k
" " Line swapping
nnoremap <silent> <M-k> :m-2<CR>==
nnoremap <silent> <M-j> :m+1<CR>==
vnoremap <silent> <M-j> :m '>+1<CR>gv=gv
vnoremap <silent> <M-k> :m '<-2<CR>gv=gv
" noremap <silent> <M-j> J

" " Map save to Ctrl+S
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>
" " Remap copy paste
vnoremap <leader>y "+y
nnoremap <leader>y "+y
vnoremap <leader>p "+p
vnoremap <leader>P "+P
nnoremap <leader>p "+p
nnoremap <leader>P "+P
" " Move to next buffer
noremap <silent> <S-h> 	:bp<CR>
noremap <silent> <S-l> 	:bn<CR>
" " Change dir to current file's dir 
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <leader>lcd :tcd %:p:h<CR>:pwd<CR>
"nnoremap <leader>tcd :tcd %:p:h<CR>:pwd<CR>
nnoremap <leader>e :NvimTreeToggle<CR>
" " Terminal
tnoremap <Esc> <C-\><C-n>
" nnoremap <silent><c-/> <Cmd>exe v:count1 . "ToggleTerm direction=float"<CR>
" inoremap <silent><c-/> <Esc><Cmd>exe v:count1 . "ToggleTerm direction=float"<CR>

lua require('plugins')
" POST plugin download hooks
if (has("termguicolors"))
  set termguicolors
endif

syntax enable
let g:use_clangd = 1
" Lua init codes
lua require('init')

colorscheme xcodedarkhc
highlight Cursor guifg=none guibg=pink
highlight iCursor guifg=none guibg=#99bbff
if !exists('g:neovide')
	highlight Normal guibg=none ctermbg=none
	highlight NormalNc guibg=none ctermbg=none
	highlight LineNr guibg=none ctermbg=none
	highlight SignColumn guibg=none ctermbg=none
	highlight! StatusColumn guibg=none ctermbg=none
	highlight! StatusLine guibg=none ctermbg=none
	highlight! TabLine guibg=none ctermbg=none
	highlight! TabLineFill guibg=none ctermbg=none
	highlight! EndOfBuffer guibg=none ctermbg=none
endif
