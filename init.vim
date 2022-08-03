set tabstop=4
set shiftwidth=4
set softtabstop=0
set guicursor=n-v-c:block-Cursor,i:block-iCursor
set number
set mouse=a
set foldmethod=manual
set foldlevel=99
set nofoldenable
set nohlsearch
set sessionoptions+=globals
let mapleader = ";"
" Keybindings
" " Move with ijkl
map <Space> <insert>
map i <Up>
map j <Left>
map k <Down>
noremap <Space> i
noremap h i
" " Jump to next word with ctrl+j/l
noremap <C-l> w
noremap <C-j> b
inoremap <C-l> <Esc>w
inoremap <C-j> <Esc>b
" " Line swapping
nnoremap <silent> <M-i> :m-2<CR>==
nnoremap <silent> <M-k> :m+1<CR>==
vnoremap <silent> <M-k> :m '>+1<CR>gv=gv
vnoremap <silent> <M-i> :m '<-2<CR>gv=gv
noremap <silent> <M-j> J

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
noremap <silent> <S-j> 	:bp<CR>
noremap <silent> <S-l> 	:bn<CR>
" " Change dir to current file's dir 
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <leader>lcd :lcd %:p:h<CR>:pwd<CR>
nnoremap <leader>e :NvimTreeToggle<CR>
" " Terminal
tnoremap <Esc> <C-\><C-n>
" nnoremap <silent><c-/> <Cmd>exe v:count1 . "ToggleTerm direction=float"<CR>
" inoremap <silent><c-/> <Esc><Cmd>exe v:count1 . "ToggleTerm direction=float"<CR>

lua require('plugins')
" POST plugin download hooks
lua require('impatient')
if (has("termguicolors"))
  set termguicolors
endif

syntax enable
colorscheme horizon

highlight Cursor guifg=none guibg=pink
highlight iCursor guifg=none guibg=#99bbff

" Lua init codes
lua require('init')
