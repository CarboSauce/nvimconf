" Enable Mouse
set mouse=a
set guifontwide='

if exists('g:neovide')
	noremap <silent> <F11> :let g:neovide_fullscreen=!g:neovide_fullscreen<CR>
	finish
endif
" Disable GUI Tabline
if exists(':GuiTabline')
    GuiTabline 0
endif

" Disable GUI Popupmenu
if exists(':GuiPopupmenu')
    GuiPopupmenu 0
endif

" Set Editor Font
if exists(':GuiFont')
    " Use GuiFont! to ignore font errors
    GuiFont	Fira Code:h12
endif

if exists(':GuiLinespace')
	GuiLinespace 0
endif
if exists('GuiRenderLigatures 1')
	GuiRenderLigatures 1
endif

let g:is_fullscreen = 0
function! ToggleFullScreen()
	let g:is_fullscreen = !g:is_fullscreen
	call GuiWindowFullScreen(g:is_fullscreen)
endfunction 

" Right Click Context Menu (Copy-Cut-Paste)
nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv
nnoremap <silent><F11> :call ToggleFullScreen()<CR>
