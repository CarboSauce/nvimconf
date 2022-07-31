set tabstop=4
set shiftwidth=4
set softtabstop=0
set guicursor=n-v-c:block-Cursor
set number
set mouse=a
set foldmethod=manual
set foldlevel=99
set nofoldenable
set nohlsearch
" Keybindings
" " Move with ijkl
map <Space> <insert>
map i <Up>
map j <Left>
map k <Down>
noremap h i
" " Jump to next word with ctrl+j/l
noremap <C-l> W
noremap <C-j> B
" Map save to Ctrl+S
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>
" Remap copy paste
vnoremap <leader>y "+y
nnoremap <leader>y "+y
vnoremap <leader>p "+p
nnoremap <leader>p "+p
vnoremap <leader>P "+P
nnoremap <leader>P "+P
" Move to next buffer
noremap <silent> <leader>bn :bn<CR>
noremap <silent> <leader>bp :bp<CR>

let mapleader = ";"
noremap <Space> i

lua require('plugins')
" POST plugin download hooks
nnoremap <leader>e :NvimTreeToggle<CR>

if (has("termguicolors"))
  set termguicolors
endif

syntax enable
colorscheme purpura 

" Lua init codes
lua require('init')
