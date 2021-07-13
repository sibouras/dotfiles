set encoding=utf-8
set fileencoding=utf-8      " The encoding written to file
syntax on
colorscheme onedark
set background=dark

set splitbelow              " Horizontal splits will automatically be below
set splitright              " Vertical splits will automatically be to the right
set cmdheight=2             " More space for displaying messages
set mouse=a                 " Enable your mouse
set t_Co=256                " Support 256 colors
set formatoptions-=cro      " Stop newline continution of comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
set autoread                " Automatically read a file changed outside of vim
set nowrap                  " Display long lines as just one line
set ruler                   " Show the cursor position all the time
set cmdheight=2             " More space for displaying messages
set smarttab                " Makes tabbing smarter will realize you have 2 vs 4
set expandtab               " Converts tabs to spaces
set updatetime=300          " Faster completion
set timeoutlen=200          " By default timeoutlen is 1000 ms
set cursorline
set scrolloff=4
set sidescrolloff=5
set number                  " Enable Line number
set relativenumber          " relative number
set tabstop=2 softtabstop=2 " tab size
set shiftwidth=2            " shift width
set hidden                  " Needed to keep multiple buffers open
set nobackup                " This is recommended by coc
set nowritebackup           " This is recommended by coc
set noswapfile              " No swap
set clipboard=unnamedplus   " Copy/paste between vim and other programs.
set wildmenu                " show wildmenu
set linebreak               " do not break words.
set incsearch
set ignorecase
set smartcase
" indent
set autoindent
set smartindent
set cindent
