syntax on
call plug#begin('~/.config/nvim/plugged')
Plug 'github/copilot.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdcommenter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'chrisbra/Colorizer'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'HerringtonDarkholme/yats.vim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline-themes'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim' " needed for telescope
Plug 'nvim-telescope/telescope.nvim'
Plug 'ryanoasis/vim-devicons'
Plug 'farmergreg/vim-lastplace'
Plug 'vimwiki/vimwiki'
call plug#end()
" vv always center the cursor vertically vv
" set scrolloff=999
let mapleader=" "
nnoremap / /\v
vnoremap / /\v
autocmd BufWritePost *.tex silent! !pdflatex %
autocmd BufWritePost *.rs !make check
"make a compile script for groff documents and complie on save
autocmd BufWritePost *.ms silent! !./compile.sh
autocmd BufWritePost config.h !sudo make clean install
autocmd BufWritePost *.cpp !make
nnoremap Y y$
nnoremap Q <Nop>
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
	inoremap <expr> <Tab> pumvisible() ? "\<C-y>" : "\<Tab>"
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-s> :w<CR>
nnoremap <C-G> <cmd>Telescope live_grep<cr>
nmap <leader>rn <Plug>(coc-rename)
nnoremap <C-b> <cmd>Telescope buffers<cr>
nnoremap <leader>qq <cmd>bw!<CR>
nnoremap <leader>p "*yy
nnoremap <leader>t :terminal<CR>
tnoremap <C-h> <C-\><C-n>
tnoremap <C-l> <C-\><C-n>
tnoremap <C-b> <cmd>Telescope buffers<cr>
tnoremap <leader>qq <cmd>bw!<CR>
nnoremap <C-n> <cmd>Telescope file_browser<CR>
vnoremap <leader>p "*y
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
nnoremap <leader>0 :tablast<cr>
nnoremap <silent> <leader>+ :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>
nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //2<CR>
"Keybind to get github status
nmap <leader>gs :G<CR>
"Keybind to commit to github
nmap <leader>gc :Git commit<CR>
"Keybind to push to github
nmap <leader>gp :Git push<CR>
vmap cc <Plug>NERDCommenterToggle
nmap cc <Plug>NERDCommenterToggle
"vvvvvvvvvvvvv set airline to have angled separators vvvvvvvvvvvv
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'base16'
let g:airline#extensions#wordcount#enabled = 1
let g:airline#extensions#wordcount#filetypes ='\vnotes|help|markdown|rst|org|text|asciidoc|tex|mail'
let g:vimwiki_list = [{'path': '~/.local/share/vimwiki'}]
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/UltiSnips']
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
"autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.yaml,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html,*.py PrettierAsync
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
set completeopt=menuone,noselect
set relativenumber
set nu
set nowrap
set encoding=UTF-8
set smarttab
set smartindent
set smartcase
set noswapfile
set nobackup
set undodir=~/.config/nvim/undodir
set undofile
set incsearch
set colorcolumn=150
set cindent
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
colorscheme tokyonight
set background=dark
let g:coc_global_extensions = [
  \ 'coc-snippets',
  "\ 'coc-java',
  "\ 'coc-go',
  \ 'coc-discord-rpc',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-json', 
  \ 'coc-pyright'
  \ ]
set hidden
set updatetime=300
set shortmess+=c
set signcolumn=yes
"Use tab for trigger completion with characters ahead and navigate.
"Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
"Use <c-space> to trigger completion.
inoremap <silent><expr> <C-Space> coc#refresh()
"Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
"Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
nmap <leader>a  <Plug>(coc-codeaction-selected)
" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)
" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')
" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
" Remap for rename current word
nmap <F2> <Plug>(coc-rename)
" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
hi! Normal ctermbg=NONE guibg=NONE
nnoremap <esc> :noh<CR>
" enabling mouse support
set mouse=a
set window title
set title
set ttyfast
set guifont=JetBrains\ Mono:h15
