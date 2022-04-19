"Plug
call plug#begin('~/.config/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdtree'
Plug 'dracula/vim',{ 'as': 'dracula' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ap/vim-css-color'
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lervag/vimtex'
call plug#end()

"Vim
set mouse=a
set encoding=UTF-8
set tabstop=2
"set signcolumn=number
set number
set t_Co=256
set updatetime=1500
set clipboard=unnamedplus
filetype plugin indent on
syntax on

"Italico
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

" laTeX
let g:tex_flavor = 'latex' 
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_method = 'latexmk'

" Theme
set termguicolors
colorscheme dracula

"Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_powerline_fonts = 1

" Git Gutter
let g:gitgutter_enable = 1
"highlight SignColumn guibg=#0C0912 ctermbg=black
let g:gitgutter_set_sign_backgrounds = 1

"NERDTree
let NERDTreeShowHidden=1

"Fzf
let g:fzf_preview_window = 'right:50%'
let g:fzf_fzf_layout = { 'window': { 'width:': 0.9, 'height': 0.6} }


" Treesiter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true
  },
}
EOF

" Hotkeys
map <F4> :buffers<CR>:buffer<Space>
map <F5> :NERDTreeToggle<CR>
map <F6> :Files<CR>
"   COC
inoremap <silent><expr> <c-space> coc#refresh()
