" -----------------------------PLUGINS---------------------------------------
" To install vim-plug, run the vim plug install script at m/v.sh

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \| PlugInstall --sync | source $MYVIMRC
            \| endif

" TODO: update comments
call plug#begin(stdpath('data') . '/plugged')
" FZF integration
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " FuzzyFinder FZF
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter' " rooter

" Git integration
Plug 'tpope/vim-fugitive' " git support
Plug 'airblade/vim-gitgutter' " git diff signs on file
Plug 'junegunn/gv.vim' " commit browser
Plug 'stsewd/fzf-checkout.vim' " Git branch management

" Comments
Plug 'preservim/nerdcommenter' " Nerd Commenter

" Project file tree
Plug 'preservim/nerdtree' " nerd tree

" Colors and UI
Plug 'gruvbox-community/gruvbox' " color scheme and visual customization
Plug 'vim-airline/vim-airline' " airline: bottom status bar and tabs
Plug 'vim-airline/vim-airline-themes' " airline themes

" Utilities
Plug 'tpope/vim-surround' " vim surround
Plug 'bronson/vim-visual-star-search' " visual star search
Plug 'mbbill/undotree' " Undotree
Plug 'matze/vim-move' " alt j/k moves selected lines normal and visual mode
Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins' } " wilder menu
Plug 'romgrk/fzy-lua-native' " dependency for wilder
Plug 'ntpeters/vim-better-whitespace' " trim whitespace with :StripWhiteSpace

" LSP
Plug 'neovim/nvim-lspconfig' " lsp configuration
Plug 'hrsh7th/cmp-buffer' " buffer suggestions
Plug 'hrsh7th/cmp-path' " path suggestions
Plug 'hrsh7th/cmp-nvim-lua' " lua suggestions
Plug 'hrsh7th/cmp-nvim-lsp' " dependency for nvim-cmp
Plug 'hrsh7th/nvim-cmp' " autocompletion
Plug 'simrat39/symbols-outline.nvim' " highlight symbols on hover
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'L3MON4D3/LuaSnip' " TODO: learn this
call plug#end()

" ============SETS (and passive mappings)============
syntax on
filetype on
filetype plugin on
set grepprg=rg\ --vimgrep " use rg as default grepper
set updatetime=100
set encoding=utf-8
set guicursor=
set exrc "also source vimrcs inside directory of file
set nocompatible
set showcmd
set showmatch " show matching open-closing symbol
set splitright splitbelow
set hidden
set title
set scrolloff=8

set number " show line numbers
set relativenumber "line numbers moving relatively
set noerrorbells
set nowrap
set cursorline cursorcolumn

set nohlsearch "search highlight off
set incsearch "cursor moves as soon as typing search
set ignorecase "search ignore cases
set smartcase "search start to not ignore cases if search for uppercase letter

set signcolumn=yes "leftmost column, used for linting
set colorcolumn=80

set shortmess+=A "ignores swap files error

" sets tab width in spaces
set softtabstop=4
" sets width to be used when using indentation in normal mode
set shiftwidth=4
" width of tab char
set tabstop=4
" if set uses spaces intead of tabs
set expandtab
set autoindent

" Ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*

" better tabbing
vnoremap < <gv
vnoremap > >gv

" jumpList mutations
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

"below command is for vimrc testing while ediing it
autocmd! bufwritepost *.vim source $MYVIMRC
" wrap text when in a txt file
autocmd! VimEnter *.txt set wrap


" =========== TREESITTER ===========
lua << EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    indent = { enable = true },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    incremental_selection = { enable = true },
    textobjects = { enable = true }}
EOF
" ============COLORS============
set termguicolors
set noshowmode
colorscheme gruvbox
let g:airline_theme='minimalist'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemode=':t'
set background=dark

" ============MAPPINGS (active mappings)============
nnoremap <Space> <nop>
vnoremap <Space> <nop>
let mapleader = " "

"Navigate splits
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"ctrl A select all file, y and p uses system clipboard
set clipboard=unnamedplus
noremap <C-a> GVgg
nnoremap Y y$

"esc with jk
inoremap jk <ESC>

"replace all ocurrence by typing old and new
nnoremap S :%s//gI<Left><Left><Left>

"replace ocurrences of last searched word
nnoremap <leader>r :%s///g<Left><Left>
nnoremap <leader>rc :%s///gc<Left><Left><Left>

" same as above, but works in a visual selection
xnoremap <leader>r :s///g<left><left>
xnoremap <leader>rc :s///gc<left><left><left>

" alternate between opened buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>
" close close only current buffer
nnoremap <down> :bd<CR>
" alternate between current edited file and last edited file
nnoremap <up> <C-^>

" ============UNDOTREE============
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.undodir
set undofile
nnoremap <F5> :UndotreeToggle<CR>
let g:undotree_WindowLayout = 2
if has("persistent_undo")
    let target_path = expand('~/.undodir')
    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif
    let &undodir=target_path
    set undofile
endif

" undo break points
inoremap , ,<c-g>u
inoremap ? ?<c-g>u
inoremap ! !<c-g>u
inoremap . .<c-g>u
inoremap ; ;<c-g>u

" ============NERDCOMMENTER============
filetype plugin on
imap <C-_> <ESC><Plug>NERDCommenterToggle
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv

" ============GIT============
" git status
nnoremap <leader>gs :G<CR>
" git branch checkout/management
nnoremap <leader>gb :GBranches<CR>
" diffget left theirs ans yours
nmap <leader>gf :diffget //2<CR>
nmap <leader>gh :diffget //3<CR>
" git log
nmap <leader>glo :GV<CR>
" git log in file
"nmap <leader>glf :GV!<CR>

" ============FZF============
let $FZF_DEFAULT_OPTS = '--layout=reverse --inline-info'
let $FZF_DEFAULT_COMMAND = "rg --files --hidden --glob '!.git/**' --glob '!build/**' --glob '!.dart_tool/**' --glob '!.idea' --glob '!node_modules'"
" automatically chooses between project files and git files
function! s:find_files()
    let git_dir = system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
    if git_dir != ''
        execute 'GFiles' git_dir
    else
        execute 'Files'
    endif
endfunction
command! ProjectFiles execute s:find_files()

nnoremap <C-p> :ProjectFiles<CR>
noremap <C-b> :Buffers<CR>
noremap <C-f> :Rg!<CR>

" ============NERDTREE============
nnoremap <leader>e :NERDTreeToggle<CR>

" ==========WILDER================
call wilder#setup({'modes': [':', '/', '?']})
call wilder#set_option('use_python_remote_plugin', 0)
call wilder#set_option('pipeline', [
      \   wilder#branch(
      \     wilder#cmdline_pipeline({
      \       'fuzzy': 1,
      \       'fuzzy_filter': wilder#lua_fzy_filter(),
      \     }),
      \     wilder#vim_search_pipeline(),
      \   ),
      \ ])

call wilder#set_option('renderer', wilder#renderer_mux({
      \ ':': wilder#popupmenu_renderer({
      \   'highlighter': wilder#lua_fzy_highlighter(),
      \   'left': [
      \     ' ',
      \     wilder#popupmenu_devicons(),
      \   ],
      \   'right': [
      \     ' ',
      \     wilder#popupmenu_scrollbar(),
      \   ],
      \ }),
      \ '/': wilder#wildmenu_renderer({
      \   'highlighter': wilder#lua_fzy_highlighter(),
      \ }),
      \ }))

" ==========BETTER WHITESPACE================
let g:better_whitespace_enabled=1

" ===============LSP CONFIG========================
" PS: requires node >= 12  ====> just run: nvm install 14.4.0

lua << EOF
local function config(_config)
    return vim.tbl_deep_extend("force", {
        capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    }, _config or {})
end

-- python
-- npm i -g pyright
require'lspconfig'.pyright.setup{}

-- bash
-- npm i -g bash-language-server
require'lspconfig'.bashls.setup{}

-- typescript
-- npm install -g typescript typescript-language-server
require'lspconfig'.tsserver.setup(config())

-- C++
-- sudo apt-get install clangd-12
-- sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-12 100
require'lspconfig'.clangd.setup(config({
    cmd = { "clangd", "--background-index", "--clang-tidy" },
    filetypes = { "c", "cpp", "h"}
}))

-- docker
-- npm install -g dockerfile-language-server-nodejs
require'lspconfig'.dockerls.setup{}

-- go
require'lspconfig'.gopls.setup(config({
    cmd = {"gopls", "serve"},
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        },
    },
}))

-- vim
-- npm install -g vim-language-server
require'lspconfig'.vimls.setup{}

-- lua
-- git clone https://github.com/sumneko/lua-language-server
-- cd lua-language-server
-- git submodule update --init --recursive
-- cd 3rd/luamake
-- ./compile/install.sh
-- cd ../..
-- ./3rd/luamake/luamake rebuild
local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

local sumneko_root_path = '/home/ze/Downloads/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

require('symbols-outline').setup({
    -- whether to highlight the currently hovered symbol
    -- disable if your cpu usage is higher than you want it
    -- or you just hate the highlight
    -- default: true
    highlight_hovered_item = true,

    -- whether to show outline guides
    -- default: true
    show_guides = true,
})
EOF

" usefull lsp remaps
nnoremap gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap [d <cmd>lua vim.diagnostic.goto_prev({float = false})<CR>
nnoremap ]d <cmd>lua vim.diagnostic.goto_next({float = false})<CR>
"nnoremap <space>q <cmd>lua vim.lsp.diagnostic.set_loclist()<CR> " TODO: check how to use quickfixlist vs locationlist before using this
nnoremap <leader>F <cmd>lua vim.lsp.buf.formatting_sync(nil, 100)<CR>
nnoremap <leader>R <cmd>lua vim.lsp.buf.rename()<CR>

" ============== COMPLETION ==============
set completeopt=menu,menuone,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

lua << EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-u>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<esc>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
    },
    sources = {
        { name = 'nvim_lua' },
      { name = 'nvim_lsp' },
      { name = 'path' },
      { name = 'buffer', keyword_length = 5 },
      { name = 'luasnip' },
    },
    snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
    formatting = {
        with_text = true,
        menu = {
            buffer = "[buf]",
            nvim_lsp = "[LSP]",
            nvim_lua = "[api]",
            path = "[path]",
            luasnip = "[snip]",
            },
        },
    experimental = {
        native_menu = false,
        }
  })
EOF
