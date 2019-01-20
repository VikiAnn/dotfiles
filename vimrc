execute pathogen#infect()
set nocompatible
colorscheme monokai

syntax on
filetype on
filetype plugin indent on
filetype plugin on

autocmd FileType go,ruby,eruby,yaml,javascript,elixir,html.handlebars setlocal ai sw=2 sts=2 et
set expandtab
set shiftwidth=2
set softtabstop=2
set clipboard=unnamed
" use line numbers
set number
" use an undo file
set undofile
set hidden
" set a directory to store the undo history
set undodir=~/.vim/vimundo/
" always show status bar
set laststatus=2
" Wild ignore for ctrlp (it ignores stuff)
set wildignore+=*tmp/*,*coverage/*,*bower_components/*,*node_modules/,*doc/*

let g:rspec_command = "!bundle exec rspec {spec} --format documentation"
" turn vim-go trailing whitespace highlighting off
let g:go_highlight_trailing_whitespace_error = 0
let mapleader = " "

noremap <Leader>t :call RunCurrentSpecFile()<CR>
noremap <Leader>s :call RunNearestSpec()<CR>
noremap <Leader>l :call RunLastSpec()<CR>
noremap <Leader>a :call RunAllSpecs()<CR>

" write file
noremap <Leader>w :w!<CR>
" close buffer
noremap <Leader>x :bd<CR>
noremap <Leader>d <PageDown>
noremap <Leader>u <PageUp>
" move line up once
nnoremap _ ddkkp
" move line down once
nnoremap - ddp
" upcase current word while in insert mode
inoremap <c-u> <esc>viwUi
" upcase current word while in normal mode
nnoremap <c-u> viwU
" edit vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" source my vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

" Get rid of trailing spaces on lines
noremap <silent> <F6> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

iabbrev pry require 'pry';binding.pry

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#buffer_idx_mode = 1
map <leader>1 <Plug>AirlineSelectTab1
map <leader>2 <Plug>AirlineSelectTab2
map <leader>3 <Plug>AirlineSelectTab3
map <leader>4 <Plug>AirlineSelectTab4
map <leader>5 <Plug>AirlineSelectTab5
map <leader>6 <Plug>AirlineSelectTab6
map <leader>7 <Plug>AirlineSelectTab7
map <leader>8 <Plug>AirlineSelectTab8
map <leader>9 <Plug>AirlineSelectTab9

function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let l:win_view = winsaveview()
  let l:last_search = getreg('/')

  " execute the command without adding to the changelist/jumplist:
  execute 'keepjumps ' . a:command

  " Clean up: restore previous search history, and cursor position
  call winrestview(l:win_view)
  call setreg('/', l:last_search)
endfunction

" Reindent entire file
nnoremap <silent> <leader>e :call Preserve("normal! gg=G")<cr>")"
