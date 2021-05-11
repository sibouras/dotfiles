
syntax enable                           " Enables syntax highlighing
" set nowrap                                " Display long lines as just one line
set encoding=utf-8                      " The encoding displayed
" set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set ruler              			            " Show the cursor position all the time
set cmdheight=2                         " More space for displaying messages
" set iskeyword+=-                      	\" treat dash separated words as a word text object"
set mouse=a                             " Enable your mouse
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set t_Co=256                            " Support 256 colors
" set conceallevel=0                      " So that I can see `` in markdown files
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                           " Converts tabs to spaces
set laststatus=0                        " Always display the status line
set background=dark                     " tell vim what the background color looks like
set showtabline=2                       " Always show tabs
set noshowmode                          " We don't need to see things like -- INSERT -- anymore
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set updatetime=300                      " Faster completion
set timeoutlen=200                      " By default timeoutlen is 1000 ms
set formatoptions-=cro                  " Stop newline continution of comments
"set clipboard=unnamedplus               " Copy paste between vim and everything else
"set autochdir                           " Your working directory will always be the same as your working directory

"au! BufWritePost $MYVIMRC source %      " auto source when writing to init.vm alternatively you can run :source $MYVIMRC

" You can't stop me
" cmap w!! w !sudo tee %

" indent
set autoindent
set smartindent
" do not break words.
set linebreak

" Automatically read a file changed outside of vim
set autoread

set scrolloff=4
set sidescrolloff=5

set clipboard=unnamed
set number 		" Enable Line number
set relativenumber  "relative number
set tabstop=2 softtabstop=2   "tab size
set shiftwidth=2    "shift width
set hidden	" keep buffer in background
set cursorline	" 
" set noerrorbells

