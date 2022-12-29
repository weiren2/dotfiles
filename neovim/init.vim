let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.vim/plugged')
    Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
    Plug 'danilamihailov/beacon.nvim'
    Plug 'mbbill/undotree'
    Plug 'preservim/nerdtree'
    Plug 'preservim/nerdcommenter'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'easymotion/vim-easymotion'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'qpkorr/vim-bufkill'
    Plug 'NMAC427/guess-indent.nvim'
    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'RRethy/vim-illuminate'
    Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
    Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

" Color scheme
colorscheme catppuccin-mocha

" undotree key mapping
nnoremap <F5> :UndotreeToggle<CR>

" NERDTree key mapping
nnoremap <C-n> :NERDTreeToggle<CR>

" Customize easymotion
map <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
nmap s <Plug>(easymotion-overwin-f2)
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='catppuccin'
let g:airline_powerline_fonts = 0

" NVIM completion
let g:coq_settings = { 'auto_start': 'shut-up', 'xdg': v:true}

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

" enable highlight after search
set hlsearch

" utf-8 encoding for text files
set encoding=utf-8

filetype plugin indent on

" vim syntax support
syntax enable
syntax on

set pastetoggle=<F2>

" Use Ctrl-L to clear search highlight
nnoremap <silent> <C-L> : nohls<CR><C-L>

set mouse=a
set nofoldenable

lua << EOF
require("catppuccin").setup({
    integrations = {
        beacon = true,
    }
})

require("indent_blankline").setup {
    show_current_context = true,
    show_current_context_start = true,
}

require'nvim-treesitter.configs'.setup {
    auto_install = true,
    highlight = {
        -- `false` will disable the whole extension
        enable = true,
        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
        disable = function(lang, buf)
        local max_filesize = 10 * 1024 * 1024 -- 10 MB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
        end,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
-- Enable completion triggered by <c-x><c-o>
vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

-- Mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
local bufopts = { noremap=true, silent=true, buffer=bufnr }
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, bufopts)
vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end
local lspconfig = require('lspconfig')
local coq = require "coq" 
-- Enable some language servers with the additional completion capabilities offered by coq_nvim
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup(require('coq').lsp_ensure_capabilities({
    on_attach = on_attach,
}))
end

EOF