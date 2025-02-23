" =============================================================================
" File: plugins.vim
" Description: Plugin configuration
" =============================================================================

" =============================================================================
" Section: Minimal package manager
" =============================================================================

function! PackInit(verbose_level) abort
  packadd minpac

  if !exists('g:loaded_minpac')
    " minpac is not available.
    " Settings for plugin-less environment
    echoerr "minpac is not available"
    cq 1
  else
    " Initialize minpac
    call minpac#init({'verbose': a:verbose_level, 'status_open': 'vertical'})

    " Minimal package manager
    call minpac#add('k-takata/minpac', {'type': 'opt'})
    " A tree explorer plugin for vim.
    call minpac#add('scrooloose/nerdtree')
    " Syntax checking hacks for vim.
    call minpac#add('scrooloose/syntastic')
    " A command-line fuzzy finder
    call minpac#add('junegunn/fzf',{'do': { -> fzf#install()}})
    " lean & mean status/tabline for vim that's light as air
    call minpac#add('vim-airline/vim-airline')
    call minpac#add('vim-airline/vim-airline-themes')
    " Pairs of handy bracket mappings
    call minpac#add('tpope/vim-unimpaired')
    " Asynchronous build and test dispatcher
    call minpac#add('tpope/vim-dispatch')
    " Comment stuff out
    call minpac#add('tpope/vim-commentary')
    " A Git wrapper so awesome, it should be illegal
    call minpac#add('tpope/vim-fugitive')
    " A class outline viewer for Vim
    call minpac#add('majutsushi/tagbar')
    " A code-completion engine for Vim
    if has('python3')
      call minpac#add('ycm-core/YouCompleteMe',{'do': {-> system('./install.py --clangd-completer --force-sudo')}})
    else
      echomsg "YouCompleteMe needs vim compiled with python support"
    endif
    " Vim plugin for clang-format, a formatter for C, C++, Obj-C, Java, JavaScript, TypeScript and ProtoBuf.
    call minpac#add('rhysd/vim-clang-format')
    " Cosmetics
    call minpac#add('vim-scripts/Wombat')
    call minpac#add('vim-scripts/wombat256.vim')
    " Template
    call minpac#add('gentoo/gentoo-syntax')
    call minpac#add('kergoth/vim-bitbake')
  endif

endfunction

" =============================================================================
" Section: k-takata/minpac
" =============================================================================

" Define minpac user commands
command! PackUpdate  call PackInit(3) | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean   call PackInit(3) | call minpac#clean()
command! PackStatus  call PackInit(3) | call minpac#status()
command! PackInstall call PackInit(4) | call minpac#update('', {'do': 'quit'})

" =============================================================================
" Section: scrooloose/nerdtree
" =============================================================================

let NERDChristmasTree = 1
let NERDTreeShowHidden = 1

" =============================================================================
" Section: scrooloose/syntastic
" =============================================================================

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open =0
let g:syntastic_check_on_wq = 0

" =============================================================================
" Section: junegunn/fzf
" =============================================================================
" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

" - down / up / left / right
let g:fzf_layout = { 'down': '20%' }

" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.vim/fzf-history'

" =============================================================================
" Section: majutsushi/tagbar
" =============================================================================

" Set autofocus on Tagbar open
"let g:tagbar_autofocus = 1

" =============================================================================
" Section: ycm-core/YouCompleteMe
" =============================================================================
"let g:ycm_log_level = 'debug'
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
"let g:ycm_max_num_candidates = 10
"let g:ycm_max_num_identifiers_candidates = 10
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
" want to just turn off the identifier completer but keep the semantic trigger (. or ->) active
let g:ycm_min_num_of_chars_for_completion = 99
let g:ycm_key_list_stop_completion = ['<C-y>', '<Enter>']

" =============================================================================
" Section: rhysd/vim-clang-format
" =============================================================================
" automatically detect .clang-format / _clang-format in project's root
let g:clang_format#detect_style_file = 1
" automatically format buffer on save
let g:clang_format#auto_format = 1
" If autodetect of .clang-format / _clang-romat failes, use that settings
let g:clang_format#code_style = "microsoft"
let g:clang_format#style_options = {
      \ "AllowShortBlocksOnASingleLine" : "true",
      \ "AllowShortCaseLabelsOnASingleLine" : "true",
      \ "AllowShortFunctionsOnASingleLine" : "true",
      \ "BraceWrapping" : {
      \     "AfterCaseLabel" : "true",
      \     "AfterUnion" : "true" },
      \ "PointerAlignment" : "Left",
      \ "BreakInheritanceList" : "BeforeComma",
      \ "BreakConstructorInitializers" : "BeforeComma",
      \ "SplitEmptyFunction" : "false",
      \ "SplitEmptyRecord" : "false",
      \ "SplitEmptyNamespace" : "false",
      \ "CompactNamespaces" : "true",
      \ "IndentCaseLabels" : "true",
      \ "NamespaceIndentation" : "All",
      \ "ConstructorInitializerIndentWidth" : 2,
      \ "ContinuationIndentWidth" : 2,
      \ "IndentWidth" : 2,
      \ "TabWidth" : 2 }

" =============================================================================
" Section: vim-airline
" =============================================================================

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline_theme='wombat'
let g:airline#extensions#tabline#formatter = 'unique_tail'

