" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	"autocmd VimEnter * PlugInstall
	"autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

	Plug 'scrooloose/nerdtree'
	Plug 'joshdick/onedark.vim'
	Plug 'mhinz/vim-startify'
	Plug 'tpope/vim-unimpaired'
	Plug 'tpope/vim-repeat'
	Plug 'justinmk/vim-sneak'
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-commentary'
	Plug 'michaeljsmith/vim-indent-object'
	Plug 'jiangmiao/auto-pairs'
	Plug 'machakann/vim-highlightedyank'
	" Plug 'vim-airline/vim-airline'
	" Plug 'vim-airline/vim-airline-themes'
  Plug 'itchyny/lightline.vim'
	Plug 'ThePrimeagen/vim-be-good'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'junegunn/vim-easy-align'

call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Uncomment to autostart the NERDTree
" autocmd vimenter * NERDTree
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '►'
let g:NERDTreeDirArrowCollapsible = '▼'
let NERDTreeShowLineNumbers=1
let NERDTreeShowHidden=1
let NERDTreeMinimalUI = 1
let g:NERDTreeWinSize=28

let g:highlightedyank_highlight_duration = 200

" Powerline config
" let g:airline_powerline_fonts = 1
" let g:airline_left_sep = ''
" let g:airline_right_sep = ''

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status Line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The lightline.vim theme
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ }

" Always show statusline
set laststatus=2
" Uncomment to prevent non-normal modes showing in powerline and below powerline.
set noshowmode
" set showtabline=2           " Always show tabs

" PLUGIN FZF
" from https://dev.to/iggredible/how-to-search-faster-in-vim-with-fzf-vim-36ko
nnoremap <silent> <Leader>b  :Buffers<CR>
nnoremap <silent> <Leader>f  :Files<CR>
nnoremap <silent> <Leader>r  :Rg<CR>
nnoremap <silent> <Leader>/  :BLines<CR>
nnoremap <silent> <Leader>'  :Marks<CR>
nnoremap <silent> <Leader>g  :Commits<CR>
nnoremap <silent> <Leader>H  :Helptags<CR>
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR>
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

" Replacing grep with rg
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

" vim easy align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" easy align
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)
