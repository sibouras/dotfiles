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
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  " The tabular plugin must come before vim-markdown
  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown'
  " if you don't have node and yarn, use pre build
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}

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
nnoremap <silent> <Leader>s  :Snippets<CR>
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


" UltiSnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"  " use <Tab> to trigger autocompletion
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" vim-markdown
" disable header folding
let g:vim_markdown_folding_disabled = 0
" do not use conceal feature, the implementation is not so good
let g:vim_markdown_conceal = 0
" disable math tex conceal feature
let g:tex_conceal = ""
let g:vim_markdown_math = 0
" Allow for the TOC window to auto-fit when it's possible for it to shrink
let g:vim_markdown_toc_autofit = 1
" disable adjust new list item indent
let g:vim_markdown_new_list_item_indent = 0


" Vim Tabular
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a; :Tabularize /:\zs<CR>
vmap <Leader>a; :Tabularize /:\zs<CR>

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" N.B. Currently only enabled for return key in insert mode, not for normal
" mode 'o' or 'O'
inoremap <buffer> <CR> <CR><Esc>:call <SID>auto_list()<CR>A


" markdown preview
" do not close the preview tab when switching to other buffers
let g:mkdp_auto_close = 0
