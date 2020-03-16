" =============================================================================
" File: keymap.vim
" Descritpion: Keymap configuration
" =============================================================================

let mapleader=","

" Make backspace work like most other apps
set backspace=indent,eol,start

" =============================================================================
" Section: Tab navigation
" =============================================================================

map tn :tabn<CR>
map tp :tabp<CR>
map tm :tabm<CR>
map tt :tabnew<CR>
map to :tabonly!<CR>

map <C-T> <ESC>:tabnew<CR>
map <C-W> <ESC>:confirm bdelete<CR>

" =============================================================================
" Section: Window navigation
" =============================================================================

nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

noremap <leader>- :split<CR>
noremap <leader>\| :vsplit<CR>

" To UTF8/Unix
nmap <leader>su :setlocal ff=unix<CR>:set fileencoding=utf8<CR>:w<CR>

" ReFormat the Document
vmap <Tab> >
vmap <S-Tab> <

" Indent Out
map <F6> >i}<CR>
imap <F6> <ESC>>i}<CR>i

" Indent In
map <F5> <i}<CR>
imap <F5> <ESC><i}<CR>i

" Strip trailing whitespaces
map <leader>tw <ESC>:call TrimWhiteSpace()<CR><CR>
imap <leader>tw <ESC>:call TrimWhiteSpace()<CR><CR>i

" Escape visual selection
map <leader>es <ESC>:s/\%V"/\\"/g<CR>:s/\%V'/\\'/g<CR>

" Move Lines / Selections
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Force quick exit - without saving
" map <M-q> <ESC>:qa!<CR>

" Force quick exit - with saving
map <M-s> <ESC>:wqa!<CR>

" show tab list
map <F2> <ESC>tl<CR>

" show pending tasks list
" map <F2> <ESC>:TaskList<CR>

" Paste Toggle
nnoremap <S-F2> :set invpaste paste?<CR>
set pastetoggle=<S-F2>

" map <silent> <F12> <ESC>:!~/.vim/tools/ctags-updater.sh &<CR>

" Copy Paste
" map <C-c> "+y<CR>
" imap <C-c> <ESC>"+yi
" map <C-x> "+x<CR>
" imap <C-x> <ESC>"+xi
" map <C-v> "+gP<ESC>:call TrimWhiteSpace()<CR>
" imap <C-v> <ESC>"+pa

" Map word switcher to -
nnoremap - :Switch<cr>

set notimeout
set ttimeout
map <leader><ESC> :noh<CR>

" Enable/Disable spellchecking
map <leader>ee :setlocal spell spelllang=en<CR>
map <leader>ed :setlocal spell spelllang=de<CR>
map <leader>ds :setlocal spell spelllang=<CR>

" " autoclose (
" inoremap ( ()<Left>
" inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
"
" " autoclose [
" inoremap [ []<Left>
" inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
"
" " autoclose {
" inoremap { {}<Left>
" inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"

" (s)trip (w)hite(s)paces
vmap <leader>sws <ESC>:'<,'>s/\%V //g<CR><CR>
" (S)trip (w)hite(s)paces from the first word of a line to the end
map <leader>Sws <ESC>0wv$:s/\%V //g<CR><CR>

" Open tag under cursor in new tab
" map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
" nnoremap <C-LeftMouse> <LeftMouse>:tab split<CR>:exec("tag ".expand("<cword>"))<CR>:CloseDupTabs<CR>:NERDTreeFind<CR>:NERDTreeFocusToggle<CR>
" nnoremap <MiddleMouse> <LeftMouse>:tab split<CR>:exec("tag ".expand("<cword>"))<CR>:CloseDupTabs<CR>

" Search and replace selection on Ctrl+r
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" Swap the current word with the previous
nnoremap <silent> gl "_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>

" Swap the current word with the next
nnoremap <silent> gw "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>

" Swap the current character with the next
nnoremap <silent> gs xph

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
" command! W execute 'w !sudo tee % > /dev/null' <bar> edit!
command W w !sudo tee "%" > /dev/null

" Easy expansion of the active file directory
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" =============================================================================
" Section: Plugin related mappings
" =============================================================================
" toggle Tagbar display
map <F4> :TagbarToggle<CR>
" autofocus on Tagbar open
" let g:tagbar_autofocus = 1

" Keymap for vdebug
let g:vdebug_keymap = {
      \ "run" : "<A-F5>",
      \ "run_to_cursor" : "<A-F1>",
      \ "step_over" : "<A-F2>",
      \ "step_into" : "<A-F3>",
      \ "step_out" : "<A-F4>",
      \ "close" : "<A-F6>",
      \ "detach" : "<A-F7>",
      \ "set_breakpoint" : "<A-F10>",
      \ "get_context" : "<A-F11>",
      \ "eval_under_cursor" : "<A-F12>",
      \}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Section: CSCOPE settings for vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" This file contains some boilerplate settings for vim's cscope interface,
" plus some keyboard mappings that I've found useful.
"
" USAGE:
" -- vim 6:     Stick this file in your ~/.vim/plugin directory (or in a
"               'plugin' directory in some other directory that is in your
"               'runtimepath'.
"
" -- vim 5:     Stick this file somewhere and 'source cscope.vim' it from
"               your ~/.vimrc file (or cut and paste it into your .vimrc).
"
" NOTE:
" These key maps use multiple keystrokes (2 or 3 keys).  If you find that vim
" keeps timing you out before you can complete them, try changing your timeout
" settings, as explained below.
"
" Happy cscoping,
"
" Jason Duell       jduell@alumni.princeton.edu     2002/3/7
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" This tests to see if vim was configured with the '--enable-cscope' option
" when it was compiled.  If it wasn't, time to recompile vim...
if has("cscope")

  """"""""""""" Standard cscope/vim boilerplate

  " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
  "set cscopetag

  " check cscope for definition of a symbol before checking ctags: set to 1
  " if you want the reverse search order.
  set csto=0

  " add any cscope database in current directory
  if filereadable("cscope.out")
    cs add cscope.out
  else
    let cscope_file=findfile("cscope.out", ".;")
    let cscope_pre=matchstr(cscope_file, ".*/")
    "echo cscope_file
    if !empty(cscope_file) && filereadable(cscope_file)
      exe "cs add" cscope_file cscope_pre
    endif
  endif
  " else add the database pointed to by environment variable
  "elseif $CSCOPE_DB != ""
  "    cs add $CSCOPE_DB
  "endif

  " show msg when any other cscope db added
  set cscopeverbose

  set cscoperelative

  """"""""""""" My cscope/vim key mappings
  "
  " The following maps all invoke one of the following cscope search types:
  "
  "   's'   symbol: find all references to the token under cursor
  "   'g'   global: find global definition(s) of the token under cursor
  "   'c'   calls:  find all calls to the function name under cursor
  "   't'   text:   find all instances of the text under cursor
  "   'e'   egrep:  egrep search for the word under cursor
  "   'f'   file:   open the filename under cursor
  "   'i'   includes: find files that include the filename under cursor
  "   'd'   called: find functions that function under cursor calls
  "
  " Below are three sets of the maps: one set that just jumps to your
  " search result, one that splits the existing vim window horizontally and
  " diplays your search result in the new window, and one that does the same
  " thing, but does a vertical split instead (vim 6 only).
  "
  " I've used CTRL-\ and CTRL-@ as the starting keys for these maps, as it's
  " unlikely that you need their default mappings (CTRL-\'s default use is
  " as part of CTRL-\ CTRL-N typemap, which basically just does the same
  " thing as hitting 'escape': CTRL-@ doesn't seem to have any default use).
  " If you don't like using 'CTRL-@' or CTRL-\, , you can change some or all
  " of these maps to use other keys.  One likely candidate is 'CTRL-_'
  " (which also maps to CTRL-/, which is easier to type).  By default it is
  " used to switch between Hebrew and English keyboard mode.
  "
  " All of the maps involving the <cfile> macro use '^<cfile>$': this is so
  " that searches over '#include <time.h>" return only references to
  " 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
  " files that contain 'time.h' as part of their name).


  " To do the first type of search, hit 'CTRL-\', followed by one of the
  " cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
  " search will be displayed in the current window.  You can use CTRL-T to
  " go back to where you were before the search.
  "

  nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
  nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
  nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>


  " Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
  " makes the vim window split horizontally, with search result displayed in
  " the new window.
  "
  " (Note: earlier versions of vim may not have the :scs command, but it
  " can be simulated roughly via:
  "    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>

  nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
  nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
  nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>


  " Hitting CTRL-space *twice* before the search type does a vertical
  " split instead of a horizontal one (vim 6 and up only)
  "
  " (Note: you may wish to put a 'set splitright' in your .vimrc
  " if you prefer the new window on the right instead of the left

  nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
  nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
  nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>


  """"""""""""" key map timeouts
  "
  " By default Vim will only wait 1 second for each keystroke in a mapping.
  " You may find that too short with the above typemaps.  If so, you should
  " either turn off mapping timeouts via 'notimeout'.
  "
  "set notimeout
  "
  " Or, you can keep timeouts, by uncommenting the timeoutlen line below,
  " with your own personal favorite value (in milliseconds):
  "
  "set timeoutlen=4000
  "
  " Either way, since mapping timeout settings by default also set the
  " timeouts for multicharacter 'keys codes' (like <F1>), you should also
  " set ttimeout and ttimeoutlen: otherwise, you will experience strange
  " delays as vim waits for a keystroke after you hit ESC (it will be
  " waiting to see if the ESC is actually part of a key code like <F1>).
  "
  "set ttimeout
  "
  " personally, I find a tenth of a second to work well for key code
  " timeouts. If you experience problems and have a slow terminal or network
  " connection, set it higher.  If you don't set ttimeoutlen, the value for
  " timeoutlent (default: 1000 = 1 second, which is sluggish) is used.
  "
  "set ttimeoutlen=100

endif

