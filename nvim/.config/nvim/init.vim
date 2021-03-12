set number	" Show line numbers
set linebreak	" Break lines at word (requires Wrap lines)
set textwidth=100	" Line wrap (number of cols)
set showmatch	" Highlight matching brace
set hlsearch	" Highlight all search results
set smartcase	" Enable smart-case search
set ignorecase	" Always case-insensitive
set shiftwidth=4	" Number of auto-indent spaces
set smarttab	" Enable smart-tabs
set softtabstop=4	" Number of spaces per Tab
set expandtab
set tabstop=4
set ruler	" Show row and column ruler information
set undolevels=1000	" Number of undo levels
set backspace=indent,eol,start	" Backspace behaviour
set relativenumber
set nocursorline
set guicursor=
set autoindent
set smartindent
set cursorline
set hidden
set t_Co=256
set mouse=a
set conceallevel=0

filetype plugin indent on
syntax on

call plug#begin()

Plug 'metalelf0/supertab'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'
Plug 'itchyny/lightline.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'sheerun/vim-polyglot'
Plug 'vimwiki/vimwiki'
Plug 'haya14busa/is.vim'
Plug 'haya14busa/vim-asterisk'
Plug 'mattn/emmet-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Yggdroot/indentLine'
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'
Plug 'airblade/vim-gitgutter'
Plug 'neovim/nvim-lsp'
Plug 'Chiel92/vim-autoformat'
Plug 'vim-scripts/SingleCompile'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'voldikss/vim-floaterm'


" Language specific
Plug 'HerringtonDarkholme/yats.vim'

call plug#end()

let mapleader = ","

" Themes
set termguicolors     " enable true colors support
let g:nord_cursor_line_number_background = 1
let g:nord_bold_vertical_split_line = 1
let g:nord_uniform_diff_background = 1
let g:nord_bold = 1
let g:nord_italic = 1
let g:nord_underline = 1
let g:nord_italic_comments = 1
" let g:gruvbox_contrast_dark = 'hard'

set background=dark

augroup nord-theme-overrides
	autocmd!
	autocmd ColorScheme nord highlight vimCommentTitle ctermfg=14 guifg=#8FBCBB
	autocmd ColorScheme nord highlight Normal ctermbg=1 guibg=1
	autocmd ColorScheme nord highlight SignColumn ctermbg=1 guibg=1
	autocmd ColorScheme nord highlight LineNr ctermbg=1 guibg=1
	autocmd ColorScheme nord highlight CursorLine ctermbg=2 guibg=#232831
augroup END

colorscheme nord

function! CocCurrentFunction()
	return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
	  \ 'colorscheme': 'nord',
	  \ 'active': {
	  \   'left': [ [ 'mode', 'paste' ],
	  \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
	  \ },
	  \ 'component_function': {
	  \   'cocstatus': 'coc#status',
	  \   'currentfunction': 'CocCurrentFunction'
	  \ },
	  \ }
" IndentLine
let g:indentLine_char = '┆'

" vim-asterisk
map *  <Plug>(asterisk-z*)<Plug>(is-nohl-1)
map g* <Plug>(asterisk-gz*)<Plug>(is-nohl-1)
map #  <Plug>(asterisk-z#)<Plug>(is-nohl-1)
map g# <Plug>(asterisk-gz#)<Plug>(is-nohl-1)
map z*  <Plug>(asterisk-z*)<Plug>(is-nohl-1)
map gz* <Plug>(asterisk-gz*)<Plug>(is-nohl-1)
map z#  <Plug>(asterisk-z#)<Plug>(is-nohl-1)
map gz# <Plug>(asterisk-gz#)<Plug>(is-nohl-1)
let g:asterisk#keeppos = 1

" fzf.vim
let g:fzf_colors =
			\ { 'fg':      ['fg', 'Normal'],
			\ 'bg':      ['bg', 'Normal'],
			\ 'hl':      ['fg', 'Comment'],
			\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
			\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
			\ 'hl+':     ['fg', 'Statement'],
			\ 'info':    ['fg', 'PreProc'],
			\ 'border':  ['fg', 'Ignore'],
			\ 'prompt':  ['fg', 'Conditional'],
			\ 'pointer': ['fg', 'Exception'],
			\ 'marker':  ['fg', 'Keyword'],
			\ 'spinner': ['fg', 'Label'],
			\ 'header':  ['fg', 'Comment'] }

nnoremap <C-p> :FZF<Cr>
nnoremap <C-f> :Rg<Cr>

" coc-prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Filetype associations
autocmd FileType json syntax match Comment +\/\/.\+$+ " Highlight comments in JSON files
autocmd BufNewFile,BufRead *.asm set filetype=nasm

" Compile
call SingleCompile#SetCompilerTemplate('c', 'gcc', 'GNU C Compiler',
	\'gcc', '-o $(FILE_TITLE)$', './$(FILE_TITLE)$ && rm $(FILE_TITLE)$')
call SingleCompile#SetCompilerTemplate('cpp', 'g++', 'GNU C Compiler',
	\'g++', '-o $(FILE_TITLE)$', './$(FILE_TITLE)$ && rm $(FILE_TITLE)$')
nnoremap <C-K> :SCCompileRun<cr>

" Vimwiki
let wiki_style = {}
let wiki_style.path = '~/wiki'
let wiki_style.syntax = 'markdown'
let wiki_style.ext = '.md'

let g:vimwiki_list = [wiki_style]
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

autocmd FileType vimwiki set ft=markdown

" coc.nvim
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()

if exists('*complete_info')
	inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
	imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
	execute 'h '.expand('<cword>')
  else
	call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" coc-actions
" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

nmap <space>e :CocCommand explorer<CR>
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l
nmap <space>` :CocCommand terminal.Toggle<CR>

" Folding
if has('folding')
  if has('windows')
	set fillchars=vert:┃              " BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
  endif
  set foldmethod=indent               " not as cool as syntax, but faster
  set foldlevelstart=99               " start unfolded
endif

" IndentLine markdown
let g:indentLine_fileTypeExclude = ['markdown']
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

