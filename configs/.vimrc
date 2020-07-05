let mapleader=" "
let maplocalleader=" "

set vb t_vb=
set belloff=all
syntax on
set number
set relativenumber
set wildmenu
set showcmd
set wrap
set backspace=indent,eol,start

set hlsearch
exec "nohlsearch"
noremap <LEADER><CR> :nohlsearch<CR>

set nocompatible
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
set encoding=utf-8
let &t_ut=''

set foldmethod=indent
set foldlevel=99
let &t_SI.= "\e[5 q" "SI = INSERT model
let &t_SR.= "\e[4 q" "SR = REPLACE model
let &t_EI.= "\e[1 q" "EI = NORMAL model(else)
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
set laststatus=2
set autochdir
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

map s <nop>
map S :w<CR>
"------------------------------------------------------------"
" screen split
map sl :set splitright<CR>:vsplit<CR>
map sh :set nosplitright<CR>:vsplit<CR>
map sk :set nosplitbelow<CR>:split<CR>
map sj :set splitbelow<CR>:split<CR>
" toggle between multiple screens
map <LEADER>l <C-w>l
map <LEADER>k <C-w>k
map <LEADER>h <C-w>h
map <LEADER>j <C-w>j
" resize screen  
map <up> :res +5<CR>
map <down> :res -5<CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>
" tag edit  add new tag windows
map te :tabe<CR> 
map th :-tabnext<CR>
map tl :+tabnext<CR>
"------------------------------------------------------------"

" N key: go to the start of the line
noremap <C-h> ^
" I key: go to the end of the line
noremap <C-l> $
"------------------------------------------------------------"
"auto indent and set indent length = 4
set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab
set autoindent
"------------------------------------------------------------"
" Convert word to Uppercase
inoremap <C-u> <esc>gUiwea
inoremap <C-j> <esc>guiwgUlea
"------------------------------------------------------------"
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'vim-airline/vim-airline'

" Color scheme
Plug 'altercation/vim-colors-solarized'

" Auto complete
Plug 'ycm-core/YouCompleteMe'

" Error checking
Plug 'w0rp/ale'

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }
Plug 'vimwiki/vimwiki'

" File navigation
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'

" HTML, CSS, JavaScript, PHP, JSON, etc.
Plug 'elzr/vim-json'
Plug 'hail2u/vim-css3-syntax'
Plug 'spf13/PIV', { 'for' :['php', 'vim-plug'] }
Plug 'gko/vim-coloresque', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
Plug 'pangloss/vim-javascript', { 'for' :['javascript', 'vim-plug'] }
Plug 'mattn/emmet-vim'

" latex
Plug 'lervag/vimtex'
" Snippet plugin -- ultisnips
Plug 'SirVer/ultisnips'
Plug 'ervandew/supertab'

" tmuxline
Plug 'edkolev/tmuxline.vim'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

"------------------------------------------------------------"
"==
"== Plugins Setting
"==
"------------------------------------------------------------"

"==  
"== colorscheme setting
"==
syntax enable
set background=dark
call togglebg#map("<F5>")
let g:solarized_termcolors=16
let g:solarized_termtrans=1
let g:solarized_visibility="normal"
colorscheme solarized

"==  
"== you complete me setting
"==
nnoremap gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap g/ :YcmCompleter GetDoc<CR>
nnoremap gt :YcmCompleter GetType<CR>
nnoremap gr :YcmCompleter GoToReferences<CR>
let g:ycm_autoclose_preview_window_after_completion=0
let g:ycm_autoclose_preview_window_after_insertion=0
let g:ycm_use_clangd = 0
let g:ycm_python_interpreter_path = "/home/xy/anaconda3/envs/py3/bin/python3"
let g:ycm_python_binary_path = "/home/xy/anaconda3/envs/py3/bin/"

let g:ycm_python_sys_path = [
  \   '/home/xy/anaconda3/envs/py3/lib/python3.6/',
  \   '/home/xy/anaconda3/envs/py3/lib/python3.6/site-packages/']
let g:ycm_extra_conf_vim_data = [
  \  'g:ycm_python_interpreter_path',
  \  'g:ycm_python_sys_path'
  \]
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/global_extra_conf.py'
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>']
let g:ycm_key_list_previous_completion = ['<C-p>']
let g:SuperTabDefaultCompletionType = '<C-n>'


"==  
"== ale error check setting
"==
let b:ale_linters = ['pylint']
let b:ale_fixers = ['autopep8', 'yapf']
let g:ale_echo_msg_error_str = 'error'

" ==
" == MarkdownPreview setting
" ==
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_browser = 'google-chrome'
let g:mkdp_echo_preview_url = 1
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1
    \ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'

"let g:mkdp_open_to_the_world = 1
"let g:mkdp_open_ip = '127.0.0.1'
"let g:mkdp_port = 8080
"function! g:Open_browser(url)
"    silent exe '!lemonade open 'a:url
"endfunction
"let g:mkdp_browserfunc = 'g:Open_browser'
nmap <LEADER>md <Plug>MarkdownPreviewToggle

" ==
" == vim-table-mode create neat table
" ==
 
" For Markdown-compatible tables use
let g:table_mode_corner='|'
map <LEADER>tm :TableModeToggle<CR>
map <LEADER>tdc g:table_mode_delete_column_map<CR>

" ==
" == NERDTree
" ==
map tt :NERDTreeToggle<CR>
let NERDTreeMapOpenExpl = ""
let NERDTreeMapUpdir = ""
let NERDTreeMapUpdirKeepOpen = "l"
let NERDTreeMapOpenSplit = ""
let NERDTreeOpenVSplit = ""
let NERDTreeMapActivateNode = "i"
let NERDTreeMapOpenInTab = "o"
let NERDTreeMapPreview = ""
let NERDTreeMapCloseDir = "n"
let NERDTreeMapChangeRoot = "y"

" ==
" == NERDTree-git
" ==
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

" ==
" == LaTex: vimtex plugin setting
" ==
let g:tex_flavor='latex'  
let g:vimtex_view_method='zathura'  
let g:vimtex_quickfix_mode=1  
set conceallevel=1  
let g:tex_conceal='abdmg'
let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \   '-xelatex',
    \   
    \ ],
    \}
let g:vimtex_quickfix_latexlog = {
    \ 'overfull' : 0,
    \ 'underfull' : 0,
    \ 'packages' : {
    \   'default' : 0,
    \ },
    \}

let g:vimtex_quickfix_ignore_filters = [
      \ 'Unused global option',
      \]

" ==
" == UltiSnips
" ==
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"
let g:UltiSnipsEditSplit = 'context'
