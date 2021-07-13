" Start new line
inoremap <S-Return> <C-o>o

" Use alt + hjkl to resize windows
nnoremap <M-j>    :resize -2<CR>
nnoremap <M-k>    :resize +2<CR>
nnoremap <M-h>    :vertical resize -2<CR>
nnoremap <M-l>    :vertical resize +2<CR>

" Alternate way to save
nnoremap <C-s> :w<CR>
" Alternate way to quit
nnoremap <C-Q> :wq!<CR>

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Improve scroll, credits: https://github.com/Shougo
nnoremap <expr> zz (winline() == (winheight(0)+1) / 2) ?
			\ 'zt' : (winline() == &scrolloff + 1) ? 'zb' : 'zz'
noremap <expr> <C-f> max([winheight(0) - 2, 1])
			\ ."\<C-d>".(line('w$') >= line('$') ? "L" : "H")
noremap <expr> <C-b> max([winheight(0) - 2, 1])
			\ ."\<C-u>".(line('w0') <= 1 ? "H" : "L")
noremap <expr> <C-e> (line("w$") >= line('$') ? "j" : "2\<C-e>")
noremap <expr> <C-y> (line("w0") <= 1         ? "k" : "2\<C-y>")


" Select blocks after indenting
xnoremap < <gv
xnoremap > >gv|

" Remove spaces at the end of lines
" nnoremap <silent> ,<Space> :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>

" I hate escape more than anything else
inoremap df <Esc>

" Fast saving
nnoremap <C-s> :<C-u>w<CR>
vnoremap <C-s> :<C-u>w<CR>
cnoremap <C-s> <C-u>w<CR>

" Map Ctrl-Backspace to delete the previous word in insert mode.
" You need to first press ctrl+v in insert mode before pressing ctrl+backspace to insert the terminal code of ctrl+backspace.
imap <M-BS> <C-w>
cmap <M-BS> <C-w>

"clears highlights
nnoremap <leader>sc :noh<return>

" open vimrc in vertical split
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" update changes into current buffer
nnoremap <leader>sv :source $MYVIMRC<cr>

" Now pressing \b will list the available buffers and prepare :b for you.
" nnoremap <leader>b :ls<CR>:b<Space>
nnoremap <leader><tab> <C-^>

" the following command maps the <F4> key to display the current date and time.
:map <F4> :echo 'Current time is ' . strftime('%c')<CR>

" The following command maps the <F3> key to insert the current date and time in the current buffer:
:map! <F3> <C-R>=strftime('%c')<CR>

" The following command maps <F2> to insert the directory name of the current buffer:
:inoremap <F2> <C-R>=expand('%:p:h')<CR>

" change directory to the file being edited and  print the directory after changing
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" working directory is always the same as the file you are editing
autocmd BufEnter * silent! lcd %:p:h

" the following command maps the <F5> key to search for the keyword under the cursor in the current directory using the 'grep' command:
:nnoremap <F5> :grep <C-R><C-W> *<CR>

" Automatically removing all trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e
" map <C-b> :r ~/.vimbuffer<CR>

" Generate pdf with pandoc
nnoremap <leader>d :w<CR>:!./md2pdf.sh pfe.md pfe.pdf<CR>
