if &compatible
 set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
 call dein#begin('~/.cache/dein')

 call dein#add('~/.cache/dein')
 call dein#add('Shougo/deoplete.nvim')

 call dein#add('tomasr/molokai')
 call dein#add('mbbill/undotree')
 call dein#add('scrooloose/nerdtree')
 call dein#add('scrooloose/nerdcommenter')
 call dein#add('ctrlpvim/ctrlp.vim')
 call dein#add('majutsushi/tagbar')
 call dein#add('spf13/vim-autoclose')
 call dein#add('easymotion/vim-easymotion')
 call dein#add('vim-airline/vim-airline')
 call dein#add('vim-airline/vim-airline-themes')
 call dein#add('flazz/vim-colorschemes')
 call dein#add('qpkorr/vim-bufkill')
 "call dein#add('vim-syntastic/syntastic')
 call dein#add('nathanaelkane/vim-indent-guides')
 " extra cpp syntax highlighting
 call dein#add('octol/vim-cpp-enhanced-highlight')
 call dein#add('RRethy/vim-illuminate')
 if !has('nvim')
   call dein#add('roxma/nvim-yarp')
   call dein#add('roxma/vim-hug-neovim-rpc')
 endif
 
 call dein#end()
 call dein#save_state()
endif

filetype plugin indent on
syntax enable
if has('gui_running')
  set background=dark
  colorscheme molokai
else                 
  set t_Co=256       
  let g:rehash256 = 1           " better colors with molokai in terminal
  colorscheme molokai                                                   
"  let g:zenburn_high_Contrast=1 " for high-contrast mode with zenburn  
"  colorscheme zenburn                                                  
endif                                                                   

map <C-n> :NERDTreeToggle<CR>
 

map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

nmap s <Plug>(easymotion-overwin-f2)

map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" Put plugins and dictionaries in this dir (also on Windows)
let vimDir = '$HOME/.vim'                                   
let &runtimepath.=','.vimDir                                

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')                                  
    let myUndoDir = expand(vimDir . '/undodir')            
    " Create dirs                                          
    call system('mkdir ' . vimDir)                         
    call system('mkdir ' . myUndoDir)                      
    let &undodir = myUndoDir                               
    set undofile                                           
endif                                                      

" enable highlight after search
set hlsearch                   

" copy-paste to terminal is bracketed due to vim configs sometimes.
" Disable this                                                     
set t_BE=                                                          

" utf-8 encoding for text files
set encoding=utf-8             

" custom font and font size
" set gfn=DejaVu\ Sans\ Mono\ 12

" vim syntax support
syntax on           

" Display unprintable characters f12 - switches
" set list " use 'set invlist' to show/hide special characters
" Unprintable chars mapping                                   
set listchars=tab:?\ ,trail:?,extends:»,precedes:« " use 'set invlist' to show/hide special characters
" show line numbers                                                                                   
set number                                                                                            
" confimr before closing                                                                              
set confirm                                                                                           
" incremental search. search as you type                                                              
set incsearch                                                                                         
" syntax based folding. other folding are file specific. eg: .vim/ftplugin/python.vim                 
setlocal foldmethod=syntax                                                                            
" change vim working directory to current file                                                        
set autochdir                                                                                         
" backspace does not work on autocompletes and few other cases                                        
set backspace=indent,eol,start                                                                        
" cursor seems to be blinking with vim 8.0                                                            
set guicursor+=a:blinkon0                                                                             
" enable powerline. 2=always, 1=atleast two windows.                                                  
set laststatus=2
" disable status. powerline/airline/lightline already show vim edit modes
set noshowmode
" show a visual line under the cursor's current line
set cursorline
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
set smarttab
set smartindent
" On pressing tab, insert 4 spaces
"set expandtab
" Enable/disable bottom scrollbar based on the line wrap/nowrap state
nnoremap <silent><expr> <f9> ':set wrap! go'.'-+'[&wrap]."=b\r"

set pastetoggle=<F2>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:deoplete#enable_at_startup=1

" Toggle tagbar using F3 key
nmap <F3> :TagbarToggle<CR>
" Toggle indentation guide using F4 key
nmap <F4> :IndentGuidesToggle<CR>
" IndentGuide color scheme. Colors can be changed by changing hex values
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#523D1F ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#6F532A ctermbg=4

 "" Toggle Syntastic on/off
 silent! nnoremap  <F7> :SyntasticToggleMode<CR>
 " manually run syntax check
 nnoremap <F5> :SyntasticCheck<CR> :lopen<CR>
 nnoremap <F6> :lclose<CR>

 let g:airline#extensions#tabline#enabled = 1
 let g:airline_theme='simple'
 let g:airline_powerline_fonts = 0

" Use Ctrl-L to clear search highlight
nnoremap <silent> <C-L> : nohls<CR><C-L>

" Uncomment the following to have Vim jump to the last position when                                                       
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif
endif

set mouse=a
set nofoldenable

" vim-cpp-enhanced-highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1