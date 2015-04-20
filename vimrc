execute pathogen#infect()
set nocompatible
filetype on

syntax on
filetype plugin indent on
filetype plugin on

colorscheme monokai

let mapleader = " "

map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

map <Leader>w :w!<CR>
map <Leader>q :wq<CR>
map <Leader>x :bd<CR>

autocmd FileType go,ruby,eruby,yaml,javascript,html.handlebars setlocal ai sw=2 sts=2 et
set expandtab
set shiftwidth=2
set softtabstop=2

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

set laststatus=2

" turn vim-go trailing whitespace highlighting off
let g:go_highlight_trailing_whitespace_error = 0

:set number

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

" Wild ignore for ctrlp (it ignores stuff)
set wildignore+=*tmp/*,*coverage/*,*bower_components/*,*node_modules/
