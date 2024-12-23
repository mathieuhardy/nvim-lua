" ==============================================================================
"
" Script name: book.vim
" Description: Configuration for neovim (book mode).
" Dependencies:
" GitHub: https://www.github.com/mathieuhardy/nixos
" License: https://www.github.com/mathieuhardy/nixos/LICENSE
" Contributors: Mathieu Hardy
"
" Run :PlugInstall at first run to install plugins
"
" ==============================================================================

" ------------------------------------------------------------------------------
" Vim-plug
" ------------------------------------------------------------------------------

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'

if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo ' . data_dir . '/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ------------------------------------------------------------------------------
" Variables
" ------------------------------------------------------------------------------

let s:vim_dir = expand('$HOME') . '/.vim'
let s:templates_dir = s:vim_dir . '/templates'
let s:backup_dir = s:vim_dir . '/backup'
let s:undo_dir = s:vim_dir . '/undo'
let g:local_plugins_dir = expand('$HOME') . '/.config/nvim/local-plugged'

" Leader key
if has('macunix')
    let mapleader=","
endif

" Text to be displayed in tabs
:set guitablabel=%t

" ------------------------------------------------------------------------------
" Plugins
" ------------------------------------------------------------------------------

call plug#begin()

" Auto completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Fuzzy file search
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" File tree
Plug 'scrooloose/nerdtree'

" Syntax highlighter
Plug 'sheerun/vim-polyglot'

" Navigate through buffers
Plug 'christoomey/vim-tmux-navigator'

" Devicons
Plug 'ryanoasis/vim-devicons'

" Distraction free mode
Plug 'junegunn/goyo.vim'

" Limited view
Plug 'junegunn/limelight.vim'

" Jump to definitions
Plug 'pechorin/any-jump.vim'

" Local plugins
Plug g:local_plugins_dir . '/mapping'
Plug g:local_plugins_dir . '/theme'

call plug#end()

" ------------------------------------------------------------------------------
" Functions
" ------------------------------------------------------------------------------

function! s:get_uid()
    if !exists('s:uid')
        let s:uid = 0
    else
        let s:uid += 1
    endif

    return s:uid
endfunction


" ------------------------------------------------------------------------------
" Setup
" ------------------------------------------------------------------------------

" Create output directories
if !isdirectory(s:vim_dir)
    call mkdir(s:vim_dir, '', 0770)
endif

if !isdirectory(s:backup_dir)
    call mkdir(s:backup_dir, '', 0770)
endif

if !isdirectory(s:undo_dir)
    call mkdir(s:undo_dir, '', 0770)
endif

" ------------------------------------------------------------------------------
" Plugin: fzf
" ------------------------------------------------------------------------------

" Run Fzf with DevIcons
function! s:FzfDevicons(qargs)
    let l:bat_cmd = 'bat --style=numbers,changes --color always {2..-1}'
    let l:head_cmd = 'head -' . &lines
    let l:preview_cmd = '--preview "' . l:bat_cmd . ' | ' . l:head_cmd . '"'
    let l:opts = l:preview_cmd
        \ . ' --expect=ctrl-t,ctrl-v,ctrl-x'
        \ . ' --multi'
        \ . ' --bind=ctrl-a:select-all,ctrl-z:deselect-all'

    function! s:files(dir)
        let l:cmd = 'ag -l -g ""'

        if a:dir != ''
            let l:cmd .= ' ' . shellescape(a:dir)
        endif

        let l:files = split(system(l:cmd), '\n')

        return s:prepend_icon(l:files)
    endfunction

   function! s:prepend_icon(candidates)
        let l:result = []

        for l:candidate in a:candidates
            let l:fname = fnamemodify(l:candidate, ':p:t')
            let l:is_directory = isdirectory(l:fname)
            let l:icon = WebDevIconsGetFileTypeSymbol(l:fname, l:is_directory)

            call add(l:result, printf('%s %s', l:icon, l:candidate))
        endfor

        return l:result
   endfunction

   function! s:edit_file(lines)
        if len(a:lines) < 2 | return | endif

        let l:cmd = get({
            \ 'ctrl-x': 'split',
            \ 'atrl-v': 'vertical split',
            \ 'ctrl-t': 'tabe'
            \ },
            \ a:lines[0], 'e')

        for l:item in a:lines[1:]
            let l:pos = stridx(l:item, ' ')
            let l:file_path = l:item[pos+1:-1]

            execute 'silent '. l:cmd . ' ' . l:file_path
        endfor
    endfunction

    call fzf#run(
        \ fzf#wrap(
        \ 'files-with-icons', {
            \ 'source': <SID>files(a:qargs),
            \ 'sink*': function('s:edit_file'),
            \ 'options': '-m ' . l:opts,
            \ 'down': '40%' },
        \ 0))
endfunction

" Path to fzf
let &rtp .= ',' . expand('$HOME') . '/.fzf'

let g:fzf_colors = {
    \   'fg':      ['fg', 'Normal'],
    \   'bg':      ['bg', 'Normal'],
    \   'hl':      ['fg', 'ModeMsg'],
    \   'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \   'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \   'hl+':     ['fg', 'ModeMsg'],
    \   'info':    ['fg', 'PreProc'],
    \   'border':  ['fg', 'Ignore'],
    \   'prompt':  ['fg', 'MoreMsg'],
    \   'pointer': ['fg', 'Comment'],
    \   'marker':  ['fg', 'Keyword'],
    \   'spinner': ['fg', 'Label'],
    \   'header':  ['fg', 'Comment']
    \ }

" ------------------------------------------------------------------------------
" Plugin: goyo
" ------------------------------------------------------------------------------

function! s:goyo_enter()
    :Limelight

    let b:quitting = 0
    let b:quitting_bang = 0
    autocmd QuitPre <buffer> let b:quitting = 1
    cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
    " Quit Vim if this is the only remaining buffer
    if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
        if b:quitting_bang
            qa!
        else
            qa
        endif
    endif

    :Limelight!
    :call theme#apply()
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()


" ------------------------------------------------------------------------------
" Plugin: limelight
" ------------------------------------------------------------------------------

let g:limelight_conceal_ctermfg = 'gray'

" ------------------------------------------------------------------------------
" Plugin: mapping
" ------------------------------------------------------------------------------

let g:mapping_uid = s:get_uid()

" ------------------------------------------------------------------------------
" Plugin: coc
" ------------------------------------------------------------------------------

inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<TAB>"

" ------------------------------------------------------------------------------
" Plugin: nerdtree
" ------------------------------------------------------------------------------

function! NERDTreeDoubleClickCbk(node)
   call a:node.activate({'stay': 0, 'where': 'p', 'keepopen': 1})
endfunction

let NERDTreeIgnore          = ['CVS\C']
let NERDTreeMouseMode       = 2 " open files by double clicking
let NERDTreeWinSize         = 30
let NERDTreeMapActivateNode = '<right>'

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "~",
    \ "Staged"    : "✚",
    \ "Untracked" : "?",
    \ "Renamed"   : "»",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✘",
    \ "Dirty"     : "!",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : "✹",
    \ "Unknown"   : "?"
    \ }

hi NERDTreeGitStatusModified    guifg=#FD971F gui=bold
hi NERDTreeGitStatusStaged      guifg=#66D9EF gui=bold
hi NERDTreeGitStatusRenamed     guifg=#A6E22E gui=bold
hi NERDTreeGitStatusUnmerged    guifg=fg      gui=bold
hi NERDTreeGitStatusUntracked   guifg=fg      gui=bold
hi NERDTreeGitStatusDirDirty    guifg=#F92672 gui=bold
hi NERDTreeGitStatusDirClean    guifg=#A6E22E gui=bold
hi NERDTreeGitStatusIgnored     guifg=fg      gui=bold

" ------------------------------------------------------------------------------
" Plugin: polyglot
" ------------------------------------------------------------------------------

let g:cpp_no_function_highlight = 1

" ------------------------------------------------------------------------------
" Plugin: any-jump
" ------------------------------------------------------------------------------

" Show line numbers
let g:any_jump_list_numbers = 0

" Normal mode: Jump to definition under cursor
nnoremap <C-s> :AnyJump<CR>

" Visual mode: jump to selected text in visual mode
xnoremap <C-s> :AnyJumpVisual<CR>

" Normal mode: open previous opened file (after jump)
nnoremap <C-BS> :AnyJumpBack<CR>

" Normal mode: open last closed search window again
nnoremap <C-p> :AnyJumpLastResults<CR>

" Auto group results by filename
let g:any_jump_grouping_enabled = 1

" Size of popup
let g:any_jump_window_width_ratio  = 0.9
let g:any_jump_window_height_ratio = 0.9
let g:any_jump_window_top_offset   = 1

" Colors
let g:any_jump_colors = {
      \"plain_text":         "AnyjumpPlainText",
      \"preview":            "AnyjumpPreview",
      \"preview_keyword":    "AnyjumpPreviewKeyword",
      \"heading_text":       "AnyjumpHeadingText",
      \"heading_keyword":    "AnyjumpHeadingKeyword",
      \"group_text":         "AnyjumpGroupText",
      \"group_name":         "AnyjumpGroupName",
      \"more_button":        "AnyjumpMoreButton",
      \"more_explain":       "AnyjumpMoreExplain",
      \"result_line_number": "AnyjumpLineNumber",
      \"result_text":        "AnyjumpResultText",
      \"result_path":        "AnyjumpResultPath",
      \"help":               "AnyjumpHelp"
      \}

" ------------------------------------------------------------------------------
" General
" ------------------------------------------------------------------------------

set nocompatible  " no vi-compatible mode
set noexrc        " don't use local version of .(g)vimrc, .exrc

if has("cmdline_hist")
    set history=1000 " keep 1000 lines of command line
endif

" ------------------------------------------------------------------------------
" Filetypes
" ------------------------------------------------------------------------------

filetype on        " enable file type detection
filetype plugin on " load filetype plugins settings
filetype indent on " load filetype indent settings

" ------------------------------------------------------------------------------
" User interface
" ------------------------------------------------------------------------------

" Use mouse everywhere
if has('mouse')
    set mouse=a
endif

" Cursor shape
if has('gui_running')
    let &t_SI = '\<Esc>[6 q'
    let &t_EI = '\<Esc>[2 q'
endif

" Sizes
set cmdheight=1   " height of the command bar
set numberwidth=1 " minimal width of number margin
set linespace=0   " spaces between lines

if has('gui_running')
    set lines=50    " default row count of window
    set columns=150 " default column count of window
endif

" Error notifications
set novisualbell " don't blink windows on error
set noerrorbells " don't make noise

" Offsets from current position
set scrolloff=0     " offset below and above the current line
set sidescrolloff=0 " number of columns between active column and cursor

" Various
set nolazyredraw               " redraw window during scripts execution
set noinsertmode               " don't start in insert mode
set hidden                     " a buffer becomes hidden when it is abandoned
set report=0                   " always display messages like '1 line yanked'
set confirm                    " display graphical confirmation dialogs
set number                     " turn on line numbers
set backspace=indent,eol,start " make backspace more flexible
set nostartofline              " leave my cursor where it was
set ruler                      " always show current position in status bar
set showtabline=1              " show tab widget if there's more than 1 tab
set showcmd                    " show the command being typed
set whichwrap+=<,>,h,l         " go to next/previous line when reaching
                               " end/begin of line with cursor
set ttyfast                    " fast scrolling
set nopaste                    " allow indentation during pastes
set noshowmode                 " because we use lightline plugin
set laststatus=2               " always show the status line

" Tab bar
set guitablabel=%t " Only filename in tab bar

" Regex
set magic " allow to search with regex like '.*'

" Matching
set showmatch       " show matching brackets
set matchpairs+=<:> " add other sets of characters to match

" Highlightning
if has('syntax')
    set nocursorline          " no highlight of current row"
    set nocursorcolumn        " no highlight of current column"
    syntax on                 " syntax highlighting on
    "syntax sync minlines=200 " 'fromstart' = slower syntax highlightning but
                              " best results
    syntax sync fromstart
endif

" GUI
if has('gui_running') || $COLORTERM == 'truecolor'
    set t_Co=256                      " use 256 colors in terminals
    set guifont=DejaVu\ Sans\ Mono\ 9 " font
    set mousehide                     " hide the mouse cursor when typing
endif

" ------------------------------------------------------------------------------
" Files, backups and undo
" ------------------------------------------------------------------------------

" File format
set fileformats=unix,dos,mac " support all three, in this order

if &modifiable
    set fileformat=unix " Unix format by default
endif

" File encoding as UTF-8
set encoding=utf-8

if &modifiable
    set fileencoding=utf-8
endif

" Automatic tasks
set autoread       " set to auto read when a file is changed from the outside
set noautowrite    " no automatic writing
set noautowriteall " no automatic writing
set noswapfile     " turn off swap files

" Backups
set backup                  " enable backup
set writebackup             " backup when writing
set backupext=.backup       " extension of backup files
let &backupdir=s:backup_dir " directory of backup files

" Undo
set undolevels=1000 " undo levels

" Persistent undo
if has('persistent_undo') && !&diff
    let &undodir=s:undo_dir " set undo directory
    set undofile            " enable undo files
endif

" ------------------------------------------------------------------------------
" Text, tabs, and indent related
" ------------------------------------------------------------------------------

" Indentation
if has('smartindent')
    set nosmartindent " don't use stupid 'smart indentation'
endif

:set cino+=(0 " align multiline parameters of a function
:set cino+==0 " align 'break' under the 'case' statement

" Indentation size
set tabstop=4     " tabulation size in display (in number of spaces)
set softtabstop=3 " mixed tabulation size
set shiftwidth=4  " size of tabulation in number of spaces
set smarttab      " be smart when using tabs
set expandtab     " use spaces instead of tabs
set cindent       " C identation

" set replacements (tab, nbsp, trailing spaces)
if has('gui_running') || $COLORTERM == 'truecolor'
    set listchars=tab:▸\ ,nbsp:␣,trail:-
else
    set listchars=tab:>\ ,nbsp:_,trail:-
endif

" Text
set conceallevel=0 " show `` characters

" Wrapping
set wrap
set linebreak
set nolist
set spell
setlocal spell spelllang=fr_fr

" ------------------------------------------------------------------------------
" Searching
" ------------------------------------------------------------------------------

set ignorecase " case insensitive by default
set smartcase  " case sensitive if using uppercase letters
set hlsearch   " enable highlight in search
set incsearch  " do incremental searching

" ------------------------------------------------------------------------------
" Abbreviations
" ------------------------------------------------------------------------------

iabbrev -- —
iabbrev oe œ
iabbrev << «
iabbrev >> »

" ------------------------------------------------------------------------------
" Mappings
"
"   :nmap - Display normal mode maps
"   :imap - Display insert mode maps
"   :vmap - Display visual and select mode maps
"   :smap - Display select mode maps
"   :xmap - Display visual mode maps
"   :cmap - Display command-line mode maps
"   :omap - Display operator pending mode maps
"
"   - mapping issue with ctrl key: $ showkey -a then search for key in `log`
"     file generated by doing: $ nvim -V3log
" ------------------------------------------------------------------------------

" alt-<arrow>|ctrl-<arrow>: tmux up/down/left/right
if has('macunix')
    nmap <silent> <C-Up>    :TmuxNavigateUp<CR>
    nmap <silent> <C-Down>  :TmuxNavigateDown<CR>
    nmap <silent> <C-Left>  :TmuxNavigateLeft<CR>
    nmap <silent> <C-Right> :TmuxNavigateRight<CR>
else
    nmap <silent> <A-Up>    :TmuxNavigateUp<CR>
    nmap <silent> <A-Down>  :TmuxNavigateDown<CR>
    nmap <silent> <A-Left>  :TmuxNavigateLeft<CR>
    nmap <silent> <A-Right> :TmuxNavigateRight<CR>
endif

" shift-v: visual block mode
nnoremap <S-v> <C-v>

" ctrl-x: cut
vnoremap <silent> <C-X> "+x

" ctrl-c: copy
map <silent> <C-c> "+y

" ctrl-v: paste
map  <silent> <C-v> "+gP
imap <silent> <C-v> <ESC>"+gpa

if has('gui_running') || $COLORTERM == 'truecolor'
    " ctrl-Space: auto completion
    if !has('macunix')
        imap <C-Space> <Plug>(ncm2_manual_trigger)
    else
        inoremap <silent><expr> <C-Space> coc#refresh()
    endif

    " \\: open previous file
    map <Leader><Leader> :e#<CR>

    " ctrl-f: search files
    :map <silent> <C-f> :call <SID>FzfDevicons($pwd)<CR>

    if !has('macunix')
        " ctrl-PageUp: previous tab
        map <silent> <C-PageUp> gT

        " ctrl-PageDown: next tab
        map <silent> <C-PageDown> gt
    endif

    " F1: save
    :map  <F1> :w<CR>
    :imap <F1> <ESC>:w<CR>a
    :vmap <F1> <ESC>:w<CR>

    " F2: quit
    map  <silent> <F2> :q<CR>
    imap <silent> <F2> <ESC>:q<CR>
    vmap <silent> <F2> <ESC>:q<CR>

    " F3: horizontal split
    map  <silent> <F3> :split<CR>
    imap <silent> <F3> <ESC>:split<CR>a
    vmap <silent> <F3> <ESC>:split<CR>

    " F4: vertical split
    map  <silent> <F4> :vsplit<CR>
    imap <silent> <F4> <ESC>:vsplit<CR>a
    vmap <silent> <F4> <ESC>:vsplit<CR>

    " F7: no highlight
    map  <silent> <F7> :nohlsearch<CR>
    imap <silent> <F7> <ESC>:nohlsearch<CR>a
    vmap <silent> <F7> <ESC>:nohlsearch<CR>

    " F10: tree file explorer
    map  <silent> <F10> :NERDTreeToggle<CR>
    imap <silent> <F10> <ESC>:NERDTreeToggle<CR>a
    vmap <silent> <F10> <ESC>:NERDTreeToggle<CR>

    " Book mode
    map  <F12> :Goyo<CR>
    imap <F12> <ESC>:Goyo<CR>
    vmap <F12> <ESC>:Goyo<CR>
endif

" ------------------------------------------------------------------------------
" Autocommands
" ------------------------------------------------------------------------------

if has('autocmd')
    autocmd VimEnter * :silent! Goyo

    " Remap double click in NERDTree
    autocmd VimEnter * :call NERDTreeAddKeyMap({
        \ 'key': '<2-LeftMouse>',
        \ 'scope': "FileNode",
        \ 'callback': "NERDTreeDoubleClickCbk",
        \ 'override':1
        \ })
endif

" ------------------------------------------------------------------------------
" Theme
" ------------------------------------------------------------------------------

call theme#apply()
