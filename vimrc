"iniciar pathogen
execute pathogen#infect()
syntax on
filetype plugin indent on

set nocompatible
set path+=**
set wildmenu
set laststatus=2
" ########################
"	coses globals
" ########################

let g:tex_flavor="latex"
let mapleader=","
let g:tipus_darxiu=&ft

" ########################
"	coses grafiques
" ########################

colorscheme gruvbox
set background=dark
let g:gruvbox_guisp_fallback='bg'
let g:gruvbox_termcolors=256
let g:gruvbox_contrast_dark='hard'

" ########################
"  	coses de linies
" ########################

set number
set relativenumber
set tabstop=2
set shiftwidth=2
set nocompatible
set guifont=Monospace\ 12
set wrap
set nolist
set linebreak

" ########################
" 	remappings
" ########################

 map <C-t> :NERDTreeToggle<CR>
 let g:ctrlp_map = '<c-p>'



" ########################
"	LATEX 
" ########################


""" remapings per que no salti de linea en linea sino amb les linies visuals
autocmd FileType tex noremap j gj
autocmd FileType tex noremap k gk

autocmd FileType tex noremap <down>		g<down>
autocmd FileType tex noremap <up> 		g<up>

autocmd FileType tex inoremap <down>	<C-o>g<down>
autocmd FileType tex inoremap <up> 		<C-o>g<up>


" ########################
"	EXPERIMENTS!!	
" ########################

"busqueda recursiva de la paraula de sota el cursor en els arxius amb extensio
"= a la actual

" // bona idea pero no funcionara a mes projectes amb multiples tipus
"noremap <leader>f :let "1=&filetype<CR> yiw:grep -R @0 ./*.@1<CR>:cw<CR>

"template
"autocmd FileType c noremap <leader>f yiw:grep -r @0 ./*

"fun! Busca(arg)
""	grep -r a:arg **/*
"endfunction

"command! -nargs=1 Busca call Busca('<args>')
"
"total que me cannsat i la comanda es com al grep normal aixi que ale!
"
autocmd FileType c noremap <leader>f "fyiw:grep -R <C-r>f **/*.[cSh]<CR>:cw<CR>


" ########################
"	TAGS
" ########################
command! Maketags !ctags -R .
