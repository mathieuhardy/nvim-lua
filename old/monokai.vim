" Dark background
set background=dark

" Reset
hi clear

if exists("syntax_on")
   syntax reset
endif

" ------------------------------------------------------------------------------
" Script variables
" ------------------------------------------------------------------------------

let s:palette = {
    \ 'bg':             ['#262626', '235'],
    \ 'fg':             ['#f8f8f8', '15'],
    \ 'black':          ['#000000', '0'],
    \ 'red':            ['#ff0000', '9'],
    \ 'dark_red':       ['#a52a2a', '124'],
    \ 'yellow':         ['#ffff00', '11'],
    \ 'light_yellow':   ['#fff799', '228'],
    \ 'dark_yellow':    ['#e8cc06', '220'],
    \ 'purple':         ['#ae81ff', '140'],
    \ 'light_purple':   ['#d7d7ff', '189'],
    \ 'light_blue':     ['#afd7ff', '153'],
    \ 'very_light_blue':['#afffff', '153'],
    \ 'blue':           ['#66d9ef', '14'],
    \ 'dark_blue':      ['#66858D', '66'],
    \ 'grey':           ['#767676', '243'],
    \ 'light_grey':     ['#bbbbbb', '249'],
    \ 'dark_grey':      ['#494949', '238'],
    \ 'very_dark_grey': ['#3e3e3e', '238'],
    \ 'pink':           ['#f92672', '197'],
    \ 'light_pink':     ['#ffb6b8', '217'],
    \ 'green':          ['#00ff00', '10'],
    \ 'light_green':    ['#a6e22e', '148'],
    \ 'orange':         ['#fd971f', '208'],
    \ }

" ------------------------------------------------------------------------------
" Script methods
" ------------------------------------------------------------------------------

function! s:bind_sp(name, color)
    if a:name == '' || a:color == ''
        return
    endif

    execute 'hi ' . a:name . ' guisp=' . s:palette[a:color][0]
endfunction

function! s:bind(name, fg, bg, style)
    if a:name == ''
        return
    endif

    let l:cmd = 'hi ' . a:name

    if a:fg != ''
        let l:cmd = l:cmd
            \ . ' guifg=' . s:palette[a:fg][0]
            \ . ' ctermfg=' . s:palette[a:fg][1]
    endif

    if a:bg != ''
        let l:cmd = l:cmd
            \ . ' guibg=' . s:palette[a:bg][0]
            \ . ' ctermbg=' . s:palette[a:bg][1]
    endif

    if a:style != ''
        let l:cmd = l:cmd
            \ . ' gui=' . a:style
            \ . ' cterm=' . a:style
    endif

    execute l:cmd
endfunction

" ------------------------------------------------------------------------------
" Global groups
"
"   Normal        => default text
"   LineNr        => line numbers
"   Directory     => Directories
"   VertSplit     => vertical separator between 2 windows
"   NonText       => '~' and '@' at the end of the window, characters from
"                 'showbreak' and other characters that do not really exist in
"                 the text (e.g., ">" displayed when a double-wide character
"                 doesn't fit at the end of the line).
"   Colorcolumn   => column set with command 'colorcolumn'
"   ErrorMsg      => error messages on the command line
"   WarningMsg    => warning messages
"   MoreMsg       => more-prompt
"   ModeMsg       => 'showmode' message (INSERT, ...)
"   Question      => hit-enter prompt and yes/no questions
"   Title         => titles for output from ":set all", ":autocmd" etc
"   SpecialKey    => meta and special keys listed with ":map", also for text
"                    used to show unprintable characters in the text,
"                    'listchars'.
"                    Generally: text that is displayed differently from what it
"                    really is.
"   Error         => error messages
"   Ignore        => left blank
"   Todo          => TODO, FIXME, ...
"   Underlined    => underlined text
"   SignColumn    => column where signs are displayed
"   Menu          => Current font, background and foreground colors of the
"                    menus. Also used for the toolbar.
"                    Applicable highlight arguments: font, guibg, guifg.
"   WildMenu      => current match in 'wildmenu' completion
"   ScrollBar     => Current background and foreground of the main window's
"                    scrollbars.
"                    Applicable highlight arguments: guibg, guifg.
"   Tooltip       => Current font, background and foreground of the tooltips.
"                    Applicable highlight arguments: font, guibg, guifg.
"   Conceal       => TODO
" ------------------------------------------------------------------------------

call s:bind('Normal',      'fg',          'bg',           'none')
call s:bind('LineNr',      'bg',          'light_purple', 'none')
call s:bind('Directory',   'blue',        'bg',           'none')
call s:bind('VertSplit',   'grey',        'bg',           'bold')
call s:bind('NonText',     'fg',          'bg',           'none')
call s:bind('Colorcolumn', 'bg',          'light_pink',   'none')
call s:bind('ErrorMsg',    'pink',        'bg',           'none')
call s:bind('WarningMsg',  'pink',        'bg',           'none')
call s:bind('MoreMsg',     'blue',        'bg',           'none')
call s:bind('ModeMsg',     'light_green', 'bg',           'bold')
call s:bind('Question',    'light_green', 'bg',           'none')
call s:bind('Title',       'pink',        'bg',           'none')
call s:bind('SpecialKey',  'bg',          'light_grey',   'none')
call s:bind('Error',       'fg',          'pink',         'none')
call s:bind('Ignore',      'fg',          'bg',           'none')
call s:bind('Todo',        'bg',          'orange',       'none')
call s:bind('Underlined',  'blue',        'bg',           'underline')

"hi SignColumn
"hi Menu
"hi WildMenu
"hi ScrollBar
"hi Tooltip
"hi Conceal

" ------------------------------------------------------------------------------
" Search
"
"   IncSearch  => 'incsearch' highlighting; also used when text is replaced
"   MatchParen => character under cursor if it's a paired bracket
"   Search     => last search pattern highlighting
" ------------------------------------------------------------------------------

call s:bind('IncSearch',  'black', 'red',    'none')
call s:bind('MatchParen', 'fg',    'bg',     'bold')
call s:bind('Search',     'black', 'yellow', 'none')

" ------------------------------------------------------------------------------
" Diff mode
"   DiffAdd    => diff mode: Added line
"   DiffChange => diff mode: Changed line
"   DiffDelete => diff mode: Deleted line
"   DiffText   => diff mode: Changed text within a changed line
" ------------------------------------------------------------------------------

call s:bind('DiffAdd',    'bg', 'light_green',  'none')
call s:bind('DiffChange', 'bg', 'orange',       'none')
call s:bind('DiffDelete', 'bg', 'pink',         'none')
call s:bind('DiffText',   'bg', 'orange',       'none')

" ------------------------------------------------------------------------------
" Autocompletion window
"
"   Pmenu      => popup menu: normal item
"   PmenuSel   => popup menu: selected item
"   PmenuSbar  => popup menu: scrollbar
"   PmenuThumb => popup menu: thumb of the scrollbar
" ------------------------------------------------------------------------------

call s:bind('Pmenu',      'fg', 'very_dark_grey', 'none')
call s:bind('PmenuSbar',  'fg', 'light_purple',   'none')
call s:bind('PmenuSel',   'fg', 'dark_red',       'none')
call s:bind('PmenuThumb', 'fg', 'dark_blue',      'none')

" ------------------------------------------------------------------------------
" Spelling
"
"   SpellBad   => misspelled word
"   SpellCap   => word that needs a first capital character
"   SpellLocal => detected as a word from another local
"   SpellRare  => hardly ever used word
" ------------------------------------------------------------------------------

call s:bind_sp('SpellBad',   'pink')
call s:bind_sp('SpellCap',   'blue')
call s:bind_sp('SpellLocal', 'green')
call s:bind_sp('SpellLocal', 'purple')

" ------------------------------------------------------------------------------
" Cursor related
"
"   Cursor        => character under the cursor
"   CursorColumn  => color when 'cursorcolumn' is set
"   CursorIM      => like Cursor, but used when in IME mode
"   CursorLine    => color when 'cursorline' is set
" ------------------------------------------------------------------------------

call s:bind('Cursor',       'bg', 'fg',   'none')
call s:bind('CursorColumn', 'fg', 'grey', 'none')
call s:bind('CursorIM',     'bg', 'fg',   'none')
call s:bind('CursorLine',   'fg', 'grey', 'none')

" ------------------------------------------------------------------------------
" Folding
"
"   Folded     => line used for closed folds
"   FoldColumn => 'foldcolumn' option
" ------------------------------------------------------------------------------

call s:bind('Folded',     'grey', 'bg', 'none')
call s:bind('FoldColumn', 'grey', 'bg', 'none')

" ------------------------------------------------------------------------------
" Status line
"
"   StatusLine     => status line of the current window
"   StatusLineNC   => status lines of not-current windows
" ------------------------------------------------------------------------------

"hi StatusLine    cterm=bold,reverse gui=bold,reverse
"hi StatusLineNC  cterm=reverse gui=reverse

" ------------------------------------------------------------------------------
" Visual mode
"
"   Visual         => visual mode selection
"   VisualNOS      => visual mode selection when vim is not owning the selection
" ------------------------------------------------------------------------------

call s:bind('Visual',    '', 'dark_grey', '')
call s:bind('VisualNOS', '', 'dark_grey', '')

" ------------------------------------------------------------------------------
" Tabs line
"
"   TabLine        => tab pages line, not active tab page label
"   TabLineFill    => tab pages line, where there are no labels
"   TabLineSel     => tab pages line, active tab page label
" ------------------------------------------------------------------------------

call s:bind('TabLine',     'grey', 'bg', 'none')
call s:bind('TabLineFill', 'fg',   'bg', 'none')
call s:bind('TabLineSel',  'fg',   'bg', 'none')

" ------------------------------------------------------------------------------
" Syntax > Global
"
"   Comment => comments
" ------------------------------------------------------------------------------

call s:bind('Comment', 'dark_yellow', 'bg', 'none')

" ------------------------------------------------------------------------------
" Syntax > Constant
"
"   Constant   => true, false, integers, ...
"   String     => strings
"   Character  => characters
"   Number     => 13, 0xFF, ...
"   Boolean    => true/false
"   Float      => floating number (2.3)
" ------------------------------------------------------------------------------

call s:bind('Constant',  'fg',           'bg', 'none')
call s:bind('String',    'light_yellow', 'bg', 'none')
call s:bind('Character', 'light_yellow', 'bg', 'none')
call s:bind('Number',    'purple',       'bg', 'none')
call s:bind('Boolean',   'purple',       'bg', 'none')
call s:bind('Float',     'purple',       'bg', 'none')

" ------------------------------------------------------------------------------
" Syntax > Identifier
"
"   Identifier => variable names
"   Function   => functions or class methods
" ------------------------------------------------------------------------------

call s:bind('Identifier', 'fg', 'bg', 'none')
call s:bind('Function',   'fg', 'bg', 'none')

" ------------------------------------------------------------------------------
" Syntax > Statement
"
"   Statement
"   Conditionnal  => if, else, ...
"   Repeat        => for, do, while, ...
"   Label         => case, default, ...
"   Operator      => sizeof, ...
"   Keyword       => any other keyword
"   Exception     => try, catch, throw
" ------------------------------------------------------------------------------

call s:bind('Statement',    'pink',        'bg', 'none')
call s:bind('Conditionnal', 'pink',        'bg', 'none')
call s:bind('Repeat',       'pink',        'bg', 'none')
call s:bind('Label',        'pink',        'bg', 'none')
call s:bind('Operator',     'light_green', 'bg', 'none')
call s:bind('Keyword',      'pink',        'bg', 'none')
call s:bind('Exception',    'pink',        'bg', 'none')

" ------------------------------------------------------------------------------
" Syntax > PreProc
"
"   PreProc    => #include, #define, macros, ...
"   Include    => #include
"   Define     => #define
"   Macro      => macros
"   PreCondit  => #if, #else, #endif
" ------------------------------------------------------------------------------

call s:bind('PreProc',   'orange', 'bg', 'none')
call s:bind('Include',   'orange', 'bg', 'none')
call s:bind('Define',    'orange', 'bg', 'none')
call s:bind('Macro',     'orange', 'bg', 'none')
call s:bind('PreCondit', 'orange', 'bg', 'none')

" ------------------------------------------------------------------------------
" Syntax > Type
"
"   Type          => int, enum, class, struct, typedef, ...
"   StorageClass  => static, register, volatile, ...
"   Structure     => struct, union, enum, ...
"   Typedef       => typedef
" ------------------------------------------------------------------------------

call s:bind('Type',         'blue', 'bg', 'none')
call s:bind('StorageClass', 'pink', 'bg', 'none')
call s:bind('Structure',    'blue', 'bg', 'none')
call s:bind('Typedef',      'blue', 'bg', 'none')

" ------------------------------------------------------------------------------
" Syntax > Special
"
"   Special          => any special symbol
"   SpecialChar      => special caracter in a constant (%s, \n, ...)
"   Tag              => you can use CTRL-] on this
"   Delimiter        => character that needs attention
"   SpecialComment   => special things inside a comment
"   Debug            => debugging statements
" ------------------------------------------------------------------------------

call s:bind('Special',        'fg',         'bg', 'none')
call s:bind('SpecialChar',    'light_pink', 'bg', 'none')
call s:bind('Tag',            'red',        'green', 'none')
call s:bind('Delimiter',      'fg',         'bg', 'none')
call s:bind('SpecialComment', 'red',        'green', 'none')
call s:bind('Debug',          'red',        'green', 'none')

" ------------------------------------------------------------------------------
" C specific highligh groups
"
"   cStatement         => goto, break, return, continue, ...
"   cFormat            => %... in strings
"   cCppString         => strings
"   cCommentL          => comments starting by //
"   cCommentStart      => /* */
"   cLabel             => case, default, ...
"   cUserLabel         => ?
"   cConditional       => if, else, ...
"   cRepeat            => for, while, ...
"   cCharacter         => a character
"   cSpecialCharacter  => \n, ...
"   cNumber            => number
"   cOctal             => octal number
"   cOctalZero         => ?
"   cFloat             => float
"   cOctalError        => ?
"   cParenError        => parenthesis error
"   cErrInParen        => ?
"   cErrInBracket      => ?
"   cCommentError      => ?
"   cCommentStartError => ?
"   cSpaceError        => ?
"   cSpecialError      => ?
"   cCurlyError        => ?
"   cOperator          => sizeof, ...
"   cStructure         => struct, union, enum, ...
"   cStorageClass      => static, register, volatile, ...
"   cInclude           => #include
"   cPreProc           => #ifdef, ...
"   cDefine            => #define
"   cIncluded          => file path included
"   cError             => errors
"   cCppInWrapper      => ?
"   cCppOutWrapper     => ?
"   cPreConditMatch    => ?
"   cPreCondit         => ?
"   cType              => int, enum, class, struct, typedef, ...
"   cConstant          => ?
"   cCommentString     => ?
"   cComment2String    => ?
"   cCommentSkip       => ?
"   cString            => strings
"   cComment           => comments
"   cSpecial           => ?
"   cTodo              => TODO
"   cBadContinuation   => ?
"   cCppOutSkip        => ?
"   cCppInElse2        => ?
"   cCppOutIf2         => ?
"   cCppOut            => ?
" ------------------------------------------------------------------------------

call s:bind('cStatement',        'light_green',  'bg',     'bold')
call s:bind('cFormat',           'light_pink',   'bg',     'none')
call s:bind('cCppString',        'light_yellow', 'bg',     'none')
call s:bind('cCommentL',         'dark_yellow',  'bg',     'none')
call s:bind('cCommentStart',     'dark_yellow',  'bg',     'none')
call s:bind('cLabel',            'pink',         'bg',     'bold')
call s:bind('cConditional',      'pink',         'bg',     'bold')
call s:bind('cRepeat',           'pink',         'bg',     'bold')
call s:bind('cCharacter',        'light_yellow', 'bg',     'bold')
call s:bind('cSpecialCharacter', 'light_pink',   'bg',     'none')
call s:bind('cNumber',           'purple',       'bg',     'none')
call s:bind('cOctal',            'purple',       'bg',     'none')
call s:bind('cFloat',            'purple',       'bg',     'none')
call s:bind('cParenError',       'fg',           'pink',   'none')
call s:bind('cOperator',         'pink',         'bg',     'bold')
call s:bind('cStructure',        'blue',         'bg',     'bold')
call s:bind('cStorageClass',     'pink',         'bg',     'bold')
call s:bind('cInclude',          'orange',       'bg',     'none')
call s:bind('cPreProc',          'orange',       'bg',     'none')
call s:bind('cDefine',           'orange',       'bg',     'none')
call s:bind('cIncluded',         'light_yellow', 'bg',     'none')
call s:bind('cError',            'fg',           'pink',   'none')
call s:bind('cType',             'blue',         'bg',     'bold')
call s:bind('cString',           'light_yellow', 'bg',     'none')
call s:bind('cComment',          'dark_yellow',  'bg',     'none')
call s:bind('cTodo',             'bg',           'orange', 'bold')

" ------------------------------------------------------------------------------
" C++ specific highligh groups
"
"   cppStatement     => new, delete, ...
"   cppAccess        => public, private, ...
"   cppModifier      => inline, virtual, ...
"   cppType          => bool, wchart_t, nullptr_t, auto
"   cppExceptions    => try, catch, noexcept, throw
"   cppOperator      => operator, typeid, ...
"   cppCast          => const_cast, dynamic_cast, ...
"   cppStorageClass  => mutable, constexpr decltype thread_local
"   cppStructure     => class, typename, template, namespace
"   cppBoolean       => true, false
"   cppConstant      => __cplusplus, nullptr
"
"   cppModifier      => override, final
"   cppRawString     => raw string
"
"   cppMinMax        => <, >
" ------------------------------------------------------------------------------

call s:bind('cppStatement', 'light_green', 'bg', 'bold')
call s:bind('cppAccess',    'pink',        'bg', 'bold')
call s:bind('cppModifier',  'blue',        'bg', 'bold')
call s:bind('cppType',      'blue',        'bg', 'bold')
call s:bind('cppBoolean',   'blue',        'bg', 'bold')
call s:bind('cppStructure', 'blue',        'bg', 'bold')

" ------------------------------------------------------------------------------
" CSS specific highligh groups
"
"   cssString         => strings
"   cssComment        => comments
"   cssTagName        => adiv, td, table, ...
"   cssSelector       => ?
"   cssBackgroundProp => background-*
"   cssTableProp      => border-collapse, border-spacing
"   cssBorderProp     => border-color, border-style, ...
"   cssFontProp       => font-*
"   cssColorProp      => color, opacity, color-profile
"   cssBoxProp        => margin-*, padding-*, ...
"   cssTextProp       => text-align, letter-spacing, ...
"   cssListProp       => list-style-*
"   cssVisualProp     => display, position, top, ...
"   cssAdvancedProp   => appearance, azimuth, ...
"   cssCommonProp     => content, quotes, ...
"   cssSpecialProp    => -webkit*, ...
"   cssImportant      => !important
"   cssRuleProp       => @media, ...
"   cssPseudo         => :link, :visited, ...
"   cssColorVal       => ?
"   cssCommonVal      => inherit, auto, both, hidden, none, ...
"   cssFontVal        => ?
"   cssListVal        => ?
"   cssTextVal        => ?
"   cssVisualVal      => ?
"   cssBorderVal      => ?
"   cssBackgroundVal  => ?
"   cssFuncVal        => ?
"   cssAdvancedVal    => ?
"   cssValueLength    => 1px, ...
"   cssValueInteger   => ?
"   cssValueNumber    => numbers
"   cssValueAngle     => ?
"   cssValueTime      => ?
"   cssValueFrequency => ?
" ------------------------------------------------------------------------------

call s:bind('cssString',         'red',         'green',    'none')
call s:bind('cssComment',        'dark_yellow', 'bg',       'none')
call s:bind('cssTagName',        'light_pink',  'bg',       'bold')
call s:bind('cssSelector',       'red',         'green',    'none')
call s:bind('cssBackgroundProp', 'red',         'green',    'none')
call s:bind('cssTableProp',      'pink',        'bg',       'none')
call s:bind('cssFontProp',       'pink',        'bg',       'none')
call s:bind('cssColorProp',      'pink',        'bg',       'none')
call s:bind('cssBoxProp',        'pink',        'bg',       'none')
call s:bind('cssTextProp',       'pink',        'bg',       'none')
call s:bind('cssListProp',       'pink',        'bg',       'none')
call s:bind('cssVisualProp',     'pink',        'bg',       'none')
call s:bind('cssAdvancedProp',   'pink',        'bg',       'none')
call s:bind('cssCommonProp',     'pink',        'bg',       'none')
call s:bind('cssSpecialProp',    'pink',        'bg',       'none')
call s:bind('cssImportant',      'fg',          'dark_red', 'bold')
call s:bind('cssRuleProp',       'pink',        'bg',       'none')
call s:bind('cssPseudo',         'red',         'green',    'none')
call s:bind('cssColorVal',       'red',         'green',    'none')
call s:bind('cssCommonVal',      'red',         'green',    'none')
call s:bind('cssFontVal',        'red',         'green',    'none')
call s:bind('cssListVal',        'red',         'green',    'none')
call s:bind('cssTextVal',        'red',         'green',    'none')
call s:bind('cssVisualVal',      'red',         'green',    'none')
call s:bind('cssBorderVal',      'red',         'green',    'none')
call s:bind('cssBackgroundVal',  'red',         'green',    'none')
call s:bind('cssFuncVal',        'red',         'green',    'none')
call s:bind('cssAdvancedVal',    'red',         'green',    'none')
call s:bind('cssValueLength',    'purple',      'bg',       'none')
call s:bind('cssValueInteger',   'purple',      'bg',       'none')
call s:bind('cssValueNumber',    'purple',      'bg',       'none')
call s:bind('cssValueAngle',     'purple',      'bg',       'none')
call s:bind('cssValueTime',      'purple',      'bg',       'none')
call s:bind('cssValueFrequency', 'purple',      'bg',       'none')

" ------------------------------------------------------------------------------
" JSON specific highligh groups
"
"   jsonKeyword            => left part
"   jsonString             => right part string
"   jsonNumber             => number
"   jsonBoolean            => boolean
"   jsonNoQuotesError      => missing quotes
"   jsonTripleQuotesError  => triple quotes
"   jsonMissingCommaError  => missing comma
"   jsonNumError           => number format error
"   jsonSemicolonError     => semicolon is not allowed
"   jsonCommentError       => no C/C++ comments
"   jsonTrailingCommaError => no trailing comma at end of array
"   jsonStringSQError      => no strings with single quotes
" ------------------------------------------------------------------------------

call s:bind('jsonKeyword',            'blue',        'bg',          'none')
call s:bind('jsonString',             'light_pink',  'bg',          'none')
call s:bind('jsonNumber',             'light_green', 'bg',          'none')
call s:bind('jsonBoolean',            'purple',      'bg',          'none')
call s:bind('jsonNoQuotesError',      'bg',          'blue',        'bold')
call s:bind('jsonTripleQuotesError',  'bg',          'fg',          'bold')
call s:bind('jsonMissingCommaError',  'fg',          'pink',        'bold')
call s:bind('jsonNumError',           'bg',          'light_green', 'bold')
call s:bind('jsonSemicolonError',     'bg',          'red',         'bold')
call s:bind('jsonCommentError',       'bg',          'orange',      'bold')
call s:bind('jsonTrailingCommaError', 'bg',          'red',         'bold')
call s:bind('jsonStringSQError',      'bg',          'light_pink',  'bold')

" ------------------------------------------------------------------------------
" Git specific highligh groups
"
"   gitconfigComment    => comment
"   gitconfigSection    => section
"   gitconfigVariable   => variable
"   gitconfigBoolean    => boolean
"   gitconfigNumber     => number
"   gitconfigString     => string
"   gitconfigDelim      => delimiter
"   gitconfigEscape     => escape character
"   gitconfigError      => Error
" ------------------------------------------------------------------------------

call s:bind('gitconfigVariable', 'blue', 'bg', 'none')

" ------------------------------------------------------------------------------
" CMake specific highligh groups
"
"   cmakeCommand                    => commands (include_directories, set, ...)
"   cmakeKWcmake_minimum_required   => keyword into cmake_minimum_required
"   cmakeCommandConditional         => if, else, ...
"   cmakeCommandRepeat              => while, foreach, ...
"   cmakeCommandDeprecated          => deprecated commands (make_directory,
"                                      install_files, ...)
"   cmakeComment                    => comments
"   cmakeEnvironment                => $ENV{...}
"   cmakeEscaped                    => \n, ...
"   cmakeModule                     => ExternalProject
"   cmakeProperty                   => ?
"   cmakeString                     => Stringѕ
"   cmakeTodo                       => TODO
"   cmakeVariableValue              => ${VAR}
"   cmakeVariable                   => CMAKE_CXX_FLAGS, ...
" ------------------------------------------------------------------------------

call s:bind('cmakeCommand',                  'pink',         'bg',     'bold')
call s:bind('cmakeKWcmake_minimum_required', 'blue',         'bg',     'none')
call s:bind('cmakeCommandConditional',       'pink',         'bg',     'bold')
call s:bind('cmakeCommandRepeat',            'pink',         'bg',     'bold')
call s:bind('cmakeCommandDeprecated',        'fg',           'pink',   'none')
call s:bind('cmakeComment',                  'dark_yellow',  'bg',     'none')
call s:bind('cmakeEnvironment',              'light_pink',   'bg',     'none')
call s:bind('cmakeEscaped',                  'grey',         'bg',     'none')
call s:bind('cmakeModule',                   'fg',           'bg',     'none')
call s:bind('cmakeProperty',                 'fg',           'bg',     'none')
call s:bind('cmakeString',                   'light_yellow', 'bg',     'none')
call s:bind('cmakeTodo',                     'bg',           'orange', 'none')
call s:bind('cmakeVariableValue',            'light_green',  'bg',     'none')
call s:bind('cmakeVariable',                 'purple',       'bg',     'none')

" ------------------------------------------------------------------------------
" Python specific highligh groups
"
"   pythonStatement           => break, continue, return, pass, ...
"   pythonRaiseFromStatement  => ?
"   pythonImport              => import
"   pythonFunction            => function declaration
"   pythonConditional         => if, else, ...
"   pythonRepeat              => for, while, ...
"   pythonException           => try, catch, ....
"   pythonOperator            => and, is, not, +, =, ==, ...
"   pythonDecorator           => @
"   pythonDottedName          => @...
"   pythonDot                 => '.'
"   pythonComment             => comments
"   pythonTodo                => TODO
"   pythonError               => ?
"   pythonIndentError         => ?
"   pythonSpaceError          => ?
"   pythonString              => strings
"   pythonRawString           => raw strings
"   pythonRawEscape           => \', \˝
"   pythonUniEscape           => ?
"   pythonUniEscapeError      => ?
"   pythonUniString           => unicode strings
"   pythonUniRawString        => unicode raw strings
"   pythonUniRawEscape        => unicode raw escape
"   pythonUniRawEscapeError   => ?
"   pythonBytes               => ?
"   pythonRawBytes            => ?
"   pythonBytesContent        => ?
"   pythonBytesError          => ?
"   pythonBytesEscape         => \', \", \n, ...
"   pythonBytesEscapeError    => \x
"   pythonFString             => ?
"   pythonRawFString          => ?
"   pythonStrInterpRegion     => ?
"   pythonStrFormatting       => string formatting using '%'
"   pythonStrFormat           => string formatting placeholders: {0}, {1}, ...
"   pythonStrTemplate         => ?
"   pythonDocTest             => tests syntax in comments (>>>)
"   pythonDocTest2            => tests syntax in comments (>>>)
"   pythonNumber              => number
"   pythonHexNumber           => hexadecimal number
"   pythonOctNumber           => octal number
"   pythonBinNumber           => binary number
"   pythonFloat               => float number
"   pythonNumberError         => number error
"   pythonOctError            => octal number error
"   pythonHexError            => hexadecimal number error
"   pythonBinError            => binary number error
"   pythonBoolean             => boolean
"   pythonNone                => 'None'
"   pythonBuiltinObj          => ?
"   pythonBuiltinFunc         => isinstance, hasattr, ...
"   pythonExClass             => TypeError, Exception, ...
"   pythonClassVar            => self
" ------------------------------------------------------------------------------

call s:bind('pythonStatement',          'pink',          'bg',           'bold')
call s:bind('pythonRaiseFromStatement', 'green',         'red',          'none')
call s:bind('pythonImport',             'light_green',   'bg',           'none')
call s:bind('pythonFunction',           'light_pink',    'bg',           'bold')
call s:bind('pythonConditional',        'pink',          'bg',           'bold')
call s:bind('pythonRepeat',             'pink',          'bg',           'bold')
call s:bind('pythonException',          'pink',          'bg',           'bold')
call s:bind('pythonOperator',           'light_green',   'bg',           'none')
call s:bind('pythonDecorator',          'bg',            'light_yellow', 'none')
call s:bind('pythonDottedName',         'bg',            'light_yellow', 'none')
call s:bind('pythonDot',                'fg',            'bg',           'none')
call s:bind('pythonComment',            'dark_yellow',   'bg',           'none')
call s:bind('pythonTodo',               'bg',            'orange',       'bold')
call s:bind('pythonError',              'green',         'red',          'none')
call s:bind('pythonIndentError',        'green',         'red',          'none')
call s:bind('pythonSpaceError',         'green',         'red',          'none')
call s:bind('pythonString',             'light_yellow',  'bg',           'none')
call s:bind('pythonRawString',          'light_yellow',  'bg',           'none')
call s:bind('pythonRawEscape',          'grey',          'bg',           'none')
call s:bind('pythonUniEscape',          'green',         'red',          'none')
call s:bind('pythonUniEscapeError',     'green',         'red',          'none')
call s:bind('pythonUniString',          'green',         'red',          'none')
call s:bind('pythonUniRawString',       'green',         'red',          'none')
call s:bind('pythonUniRawEscape',       'green',         'red',          'none')
call s:bind('pythonUniRawEscapeError',  'green',         'red',          'none')
call s:bind('pythonBytes',              'green',         'red',          'none')
call s:bind('pythonRawBytes',           'green',         'red',          'none')
call s:bind('pythonBytesContent',       'green',         'red',          'none')
call s:bind('pythonBytesError',         'green',         'red',          'none')
call s:bind('pythonBytesEscape',        'grey',          'bg',           'none')
call s:bind('pythonBytesEscapeError',   'fg',            'pink',         'none')
call s:bind('pythonFString',            'green',         'red',          'none')
call s:bind('pythonRawFString',         'green',         'red',          'none')
call s:bind('pythonStrInterpRegion',    'green',         'red',          'none')
call s:bind('pythonStrFormatting',      'fg',            'bg',           'none')
call s:bind('pythonStrFormat',          'blue',          'bg',           'none')
call s:bind('pythonStrTemplate',        'green',         'red',          'none')
call s:bind('pythonDocTest',            'light_yellow',  'bg',           'underline')
call s:bind('pythonDocTest2',           'light_yellow',  'bg',           'underline')
call s:bind('pythonNumber',             'purple',        'bg',           'none')
call s:bind('pythonHexNumber',          'purple',        'bg',           'none')
call s:bind('pythonOctNumber',          'purple',        'bg',           'none')
call s:bind('pythonBinNumber',          'purple',        'bg',           'none')
call s:bind('pythonFloat',              'purple',        'bg',           'none')
call s:bind('pythonNumberError',        'bg',            'purple',       'none')
call s:bind('pythonOctError',           'bg',            'purple',       'none')
call s:bind('pythonHexError',           'bg',            'purple',       'none')
call s:bind('pythonBinError',           'bg',            'purple',       'none')
call s:bind('pythonBoolean',            'purple',        'bg',           'none')
call s:bind('pythonNone',               'purple',        'bg',           'none')
call s:bind('pythonBuiltinObj',         'fg',            'bg',           'none')
call s:bind('pythonBuiltinFunc',        'fg',            'bg',           'none')
call s:bind('pythonExClass',            'blue',          'bg',           'none')
call s:bind('pythonClassVar',           'blue',          'bg',           'none')

" ------------------------------------------------------------------------------
" Javascript specific highligh groups
"
"   jsComment                              => ?
"   jsEnvComment                           => ?
"   jsParensIfElse                         => ?
"   jsParensRepeat                         => ?
"   jsParensSwitch                         => ?
"   jsParensCatch                          => ?
"   jsCommentTodo                          => ?
"   jsString                               => ?
"   jsObjectKeyString                      => ?
"   jsTemplateString                       => ?
"   jsObjectStringKey                      => ?
"   jsClassStringKey                       => ?
"   jsTaggedTemplate                       => ?
"   jsTernaryIfOperator                    => ?
"   jsRegexpString                         => ?
"   jsRegexpBoundary                       => ?
"   jsRegexpQuantifier                     => ?
"   jsRegexpOr                             => ?
"   jsRegexpMod                            => ?
"   jsRegexpBackRef                        => ?
"   jsRegexpGroup                          => ?
"   jsRegexpCharClass                      => ?
"   jsCharacter                            => ?
"   jsPrototype                            => ?
"   jsConditional                          => ?
"   jsBranch                               => ?
"   jsLabel                                => ?
"   jsReturn                               => ?
"   jsRepeat                               => ?
"   jsDo                                   => ?
"   jsStatement                            => ?
"   jsException                            => ?
"   jsTry                                  => ?
"   jsFinally                              => ?
"   jsCatch                                => ?
"   jsAsyncKeyword                         => ?
"   jsForAwait                             => ?
"   jsArrowFunction                        => ?
"   jsFunction                             => ?
"   jsGenerator                            => ?
"   jsArrowFuncArgs                        => ?
"   jsFuncName                             => ?
"   jsFuncCall                             => ?
"   jsClassFuncName                        => ?
"   jsObjectFuncName                       => ?
"   jsArguments                            => ?
"   jsError                                => ?
"   jsParensError                          => ?
"   jsOperatorKeyword                      => ?
"   jsOperator                             => ?
"   jsOf                                   => ?
"   jsStorageClass                         => ?
"   jsClassKeyword                         => ?
"   jsExtendsKeyword                       => ?
"   jsThis                                 => ?
"   jsSuper                                => ?
"   jsNan                                  => ?
"   jsNull                                 => ?
"   jsUndefined                            => ?
"   jsNumber                               => ?
"   jsFloat                                => ?
"   jsBooleanTrue                          => ?
"   jsBooleanFalse                         => ?
"   jsObjectColon                          => ?
"   jsNoise                                => ?
"   jsDot                                  => ?
"   jsBrackets                             => ?
"   jsParens                               => ?
"   jsBraces                               => ?
"   jsFuncBraces                           => ?
"   jsFuncParens                           => ?
"   jsClassBraces                          => ?
"   jsClassNoise                           => ?
"   jsIfElseBraces                         => ?
"   jsTryCatchBraces                       => ?
"   jsModuleBraces                         => ?
"   jsObjectBraces                         => ?
"   jsObjectSeparator                      => ?
"   jsFinallyBraces                        => ?
"   jsRepeatBraces                         => ?
"   jsSwitchBraces                         => ?
"   jsSpecial                              => ?
"   jsTemplateBraces                       => ?
"   jsGlobalObjects                        => ?
"   jsGlobalNodeObjects                    => ?
"   jsExceptions                           => ?
"   jsBuiltins                             => ?
"   jsImport                               => ?
"   jsExport                               => ?
"   jsExportDefault                        => ?
"   jsExportDefaultGroup                   => ?
"   jsModuleAs                             => ?
"   jsModuleComma                          => ?
"   jsModuleAsterisk                       => ?
"   jsFrom                                 => ?
"   jsDecorator                            => ?
"   jsDecoratorFunction                    => ?
"   jsParensDecorator                      => ?
"   jsFuncArgOperator                      => ?
"   jsClassProperty                        => ?
"   jsObjectShorthandProp                  => ?
"   jsSpreadOperator                       => ?
"   jsRestOperator                         => ?
"   jsRestExpression                       => ?
"   jsSwitchColon                          => ?
"   jsClassMethodType                      => ?
"   jsObjectMethodType                     => ?
"   jsClassDefinition                      => ?
"   jsBlockLabel                           => ?
"   jsBlockLabelKey                        => ?
"   jsDestructuringBraces                  => ?
"   jsDestructuringProperty                => ?
"   jsDestructuringAssignment              => ?
"   jsDestructuringNoise                   => ?
"   jsCommentFunction                      => ?
"   jsCommentClass                         => ?
"   jsCommentIfElse                        => ?
"   jsCommentRepeat                        => ?
"   jsDomErrNo                             => ?
"   jsDomNodeConsts                        => ?
"   jsDomElemAttrs                         => ?
"   jsDomElemFuncs                         => ?
"   jsHtmlEvents                           => ?
"   jsHtmlElemAttrs                        => ?
"   jsHtmlElemFuncs                        => ?
"   jsCssStyles                            => ?
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" ProtoBuf specific highligh groups
"
"   pbTodo      => TODO
"   pbSyntax    => syntax, import, option
"   pbStructure => package, message, group, oneof
"   pbRepeat    => optional, required, repeated
"   pbDefault   => default
"   pbExtend    => extend, extensions, to, max, reserved
"   pbRPC       => service, rpc, returns
"   pbStream    => stream
"   pbType      => int32, int64, uint32, uint64, sint32, sint64, fixed32,
"                  fixed64, sfixed32, sfixed64, float, double, bool, string,
"                  bytes
"   pbTypedef   => enum
"   pbBool      => true, false
"   pbInt       => integer
"   pbFloat     => float
"   pbComment   => comments
"   pbString    => strings
" ------------------------------------------------------------------------------

call s:bind('pbTodo',      'bg',           'orange',       'bold')
call s:bind('pbSyntax',    'light_green',  'bg',           'bold')
call s:bind('pbStructure', 'pink',         'bg',           'bold')
call s:bind('pbRepeat',    'bg',           'light_yellow', 'bold')
call s:bind('pbDefault',   'pink',         'bg',           'underline')
call s:bind('pbExtend',    'fg',           'bg',           'bold')
call s:bind('pbRPC',       'fg',           'bg',           'bold')
call s:bind('pbStream',    'fg',           'bg',           'bold')
call s:bind('pbType',      'blue',         'bg',           'bold')
call s:bind('pbTypedef',   'blue',         'bg',           'bold')
call s:bind('pbBool',      'purple',       'bg',           'none')
call s:bind('pbInt',       'purple',       'bg',           'none')
call s:bind('pbFloat',     'purple',       'bg',           'none')
call s:bind('pbComment',   'dark_yellow',  'bg',           'none')
call s:bind('pbString',    'light_yellow', 'bg',           'none')

" ------------------------------------------------------------------------------
" Rust
" ------------------------------------------------------------------------------

call s:bind('rustCommentLine', 'dark_yellow', 'bg', 'none')
call s:bind('rustCommentLineDoc', 'bg', 'very_light_blue', 'none')

" ------------------------------------------------------------------------------
" CtrlP specific highligh groups
"
"   CtrlPNoEntries   => the message when no match is found (Error)
"   CtrlPMatch       => the matched pattern (Identifier)
"   CtrlPLinePre     => the line prefix '>' in the match window
"   CtrlPPrtBase     => the prompt's base (Comment)
"   CtrlPPrtText     => the prompt's text (|hl-Normal|)
"   CtrlPPrtCursor   => the prompt's cursor when moving over the text (Constant)
" ------------------------------------------------------------------------------

call s:bind('CtrlPNoEntries', 'bg',          'light_pink', 'none')
call s:bind('CtrlPMatch',     'bg',          'blue',       'none')
call s:bind('CtrlPPrtBase',   'light_green', 'bg',         'none')

" ------------------------------------------------------------------------------
" Any-jump specific highlight groups
"
" - AnyjumpPlainText      : Default text
" - AnyjumpPreview        : In preview: the normal text
" - AnyjumpPreviewKeyword : In preview: the keyword searched
" - AnyjumpHeadingText    : In heading section: the text
" - AnyjumpHeadingKeyword : In heading section: the keywork searched
" - AnyjumpGroupText      : In group mode: the arrow symbol at the beginning
" - AnyjumpGroupName      : In group mode: the path of the file
" - AnyjumpMoreButton     : Button used to show more entries
" - AnyjumpMoreExplain    : Text explaining how to show more entries
" - AnyjumpLineNumber     : Line number
" - AnyjumpResultText     : Line of code where the symbol appears
" - AnyjumpResultPath     : In normal mode: the path of the file
" - AnyjumpHelp           : Help text at the end
" ------------------------------------------------------------------------------

call s:bind('AnyjumpPlainText',      'fg',          'very_dark_grey', 'none')
call s:bind('AnyjumpPreview',        'light_grey',  'bg',             'none')
call s:bind('AnyjumpPreviewKeyword', 'orange',      'bg',             'bold')
call s:bind('AnyjumpHeadingText',    'purple',      'very_dark_grey', 'bold')
call s:bind('AnyjumpHeadingKeyword', 'purple',      'very_dark_grey', 'bold')
call s:bind('AnyjumpGroupText',      'light_pink',  'very_dark_grey', 'bold')
call s:bind('AnyjumpGroupName',      'light_pink',  'very_dark_grey', 'bold')
call s:bind('AnyjumpMoreButton',     'light_green', 'very_dark_grey', 'bold')
call s:bind('AnyjumpMoreExplain',    'light_green', 'very_dark_grey', 'none')
call s:bind('AnyjumpLineNumber',     'light_green', 'very_dark_grey', 'bold')
call s:bind('AnyjumpResultText',     'fg',          'very_dark_grey', 'none')
call s:bind('AnyjumpResultPath',     'light_pink',  'very_dark_grey', 'bold')
call s:bind('AnyjumpHelp',           'orange',      'very_dark_grey', 'none')

" ------------------------------------------------------------------------------
" COC
" ------------------------------------------------------------------------------

call s:bind('CocFloating', 'fg', 'very_dark_grey', 'none')
call s:bind('CocMenuSel', 'bg', 'light_green', 'none')
call s:bind('CocSearch', 'bg', 'light_yellow', 'none')

"CocWarningHighlight xxx cterm=underline ctermfg=3 gui=undercurl guifg=#EBCB8B
"CocErrorHighlight xxx cterm=underline ctermfg=1 gui=undercurl guifg=#BF616A
"CocWarningSign xxx ctermfg=3 guifg=#d08770
"CocErrorSign   xxx ctermfg=1 guifg=#bf616a
"CocInfoSign    xxx ctermfg=6 guifg=#88C0D0
"CocHintSign    xxx ctermfg=12 guifg=#5E81AC
"
"CocHighlightText xxx guifg=#d8dee9 guibg=#516f7a
"CocFadeOut     xxx links to Comment
"
"CocErrorVirtualText xxx guifg=#bf616a
"CocWarningVirtualText xxx guifg=#d08770
"
"CocMenuSel     xxx ctermbg=8 guibg=#4C566A
"CocListLine    xxx ctermbg=17 guibg=#3e434e
"CocTreeSelected xxx links to CursorLine
"CocSelectedText xxx ctermfg=12 guifg=#fb4934
"CocCodeLens    xxx ctermfg=7 guifg=#999999
"CocUnderline   xxx term=underline cterm=underline gui=underline guisp=#ebdbb2
"CocBold        xxx term=bold cterm=bold gui=bold
"CocItalic      xxx term=italic cterm=italic gui=italic
"CocStrikeThrough xxx term=strikethrough cterm=strikethrough gui=strikethrough
"CocMarkdownLink xxx ctermfg=9 guifg=#15aabf
"CocDisabled    xxx ctermfg=7 guifg=#999999
"CocSearch      xxx ctermfg=9 guifg=#15aabf
"CocLink        xxx term=underline cterm=underline gui=underline guisp=#15aabf
"CocFloating    xxx links to Pmenu
"CocFloatThumb  xxx links to PmenuThumb
"CocFloatSbar   xxx links to PmenuSbar
"CocFloatActive xxx links to CocSearch
"CocMarkdownCode xxx links to markdownCode
"CocMarkdownHeader xxx links to markdownH1
"CocDeprecatedHighlight xxx links to CocStrikeThrough
"CocUnusedHighlight xxx links to CocFadeOut
"CocListSearch  xxx links to CocSearch
"CocListMode    xxx links to ModeMsg
"CocListPath    xxx links to Comment
"CocHoverRange  xxx links to Search
"CocCursorRange xxx links to Search
"CocLinkedEditing xxx links to CocCursorRange
"CocHighlightRead xxx links to CocHighlightText
"CocHighlightWrite xxx links to CocHighlightText
"CocNotificationProgress xxx ctermfg=9 guifg=#15aabf
"CocNotificationButton xxx links to CocUnderline
"CocNotificationError xxx links to CocErrorFloat
"CocErrorFloat  xxx ctermfg=1 ctermbg=0 guifg=#bf616a guibg=#434C5E
"CocNotificationWarning xxx links to CocWarningFloat
"CocWarningFloat xxx ctermfg=3 ctermbg=0 guifg=#d08770 guibg=#434C5E
"CocNotificationInfo xxx links to CocInfoFloat
"CocInfoFloat   xxx ctermfg=6 ctermbg=0 guifg=#88C0D0 guibg=#434C5E
"CocSnippetVisual xxx links to Visual
"CocTreeTitle   xxx links to Title
"CocTreeDescription xxx links to Comment
"CocTreeOpenClose xxx links to CocBold
"CocSelectedRange xxx links to CocHighlightText
"CocSymbolDefault xxx links to MoreMsg
"CocPumSearch   xxx links to CocSearch
"CocPumDetail   xxx links to Comment
"CocPumMenu     xxx links to CocFloating
"CocPumShortcut xxx links to Comment
"CocPumDeprecated xxx links to CocStrikeThrough
"CocVirtualText xxx ctermfg=12 guifg=#504945
"CocPumVirtualText xxx links to CocVirtualText
"CocInputBoxVirtualText xxx links to CocVirtualText
"CocFloatDividingLine xxx links to CocVirtualText
"CocInfoHighlight xxx links to CocUnderline
"CocInfoVirtualText xxx ctermfg=6 ctermbg=16 guifg=#88C0D0 guibg=#2E3440
"CocHintHighlight xxx links to CocUnderline
"CocHintVirtualText xxx ctermfg=12 ctermbg=16 guifg=#5E81AC guibg=#2E3440
"CocHintFloat   xxx ctermfg=12 ctermbg=0 guifg=#5E81AC guibg=#434C5E
"CocInlayHint   xxx ctermfg=12 ctermbg=16 guifg=#5E81AC guibg=#2E3440
"CocInlayHintParameter xxx links to CocInlayHint
"CocInlayHintType xxx links to CocInlayHint
"CocListBlackBlack xxx guifg=#3B4252 guibg=#3B4252
"CocListBlackBlue xxx guifg=#3B4252 guibg=#81A1C1
"CocListBlackGreen xxx guifg=#3B4252 guibg=#A3BE8C
"CocListBlackGrey xxx guifg=#3B4252 guibg=#4C566A
"CocListBlackWhite xxx guifg=#3B4252 guibg=#E5E9F0
"CocListBlackCyan xxx guifg=#3B4252 guibg=#88C0D0
"CocListBlackYellow xxx guifg=#3B4252 guibg=#EBCB8B
"CocListBlackMagenta xxx guifg=#3B4252 guibg=#B48EAD
"CocListBlackRed xxx guifg=#3B4252 guibg=#BF616A
"CocListFgBlack xxx ctermfg=0 guifg=#3B4252
"CocListBgBlack xxx ctermbg=0 guibg=#3B4252
"CocListBlueBlack xxx guifg=#81A1C1 guibg=#3B4252
"CocListBlueBlue xxx guifg=#81A1C1 guibg=#81A1C1
"CocListBlueGreen xxx guifg=#81A1C1 guibg=#A3BE8C
"CocListBlueGrey xxx guifg=#81A1C1 guibg=#4C566A
"CocListBlueWhite xxx guifg=#81A1C1 guibg=#E5E9F0
"CocListBlueCyan xxx guifg=#81A1C1 guibg=#88C0D0
"CocListBlueYellow xxx guifg=#81A1C1 guibg=#EBCB8B
"CocListBlueMagenta xxx guifg=#81A1C1 guibg=#B48EAD
"CocListBlueRed xxx guifg=#81A1C1 guibg=#BF616A
"CocListFgBlue  xxx ctermfg=9 guifg=#81A1C1
"CocListBgBlue  xxx ctermbg=9 guibg=#81A1C1
"CocListGreenBlack xxx guifg=#A3BE8C guibg=#3B4252
"CocListGreenBlue xxx guifg=#A3BE8C guibg=#81A1C1
"CocListGreenGreen xxx guifg=#A3BE8C guibg=#A3BE8C
"CocListGreenGrey xxx guifg=#A3BE8C guibg=#4C566A
"CocListGreenWhite xxx guifg=#A3BE8C guibg=#E5E9F0
"CocListGreenCyan xxx guifg=#A3BE8C guibg=#88C0D0
"CocListGreenYellow xxx guifg=#A3BE8C guibg=#EBCB8B
"CocListGreenMagenta xxx guifg=#A3BE8C guibg=#B48EAD
"CocListGreenRed xxx guifg=#A3BE8C guibg=#BF616A
"CocListFgGreen xxx ctermfg=10 guifg=#A3BE8C
"CocListBgGreen xxx ctermbg=10 guibg=#A3BE8C
"CocListGreyBlack xxx guifg=#4C566A guibg=#3B4252
"CocListGreyBlue xxx guifg=#4C566A guibg=#81A1C1
"CocListGreyGreen xxx guifg=#4C566A guibg=#A3BE8C
"CocListGreyGrey xxx guifg=#4C566A guibg=#4C566A
"CocListGreyWhite xxx guifg=#4C566A guibg=#E5E9F0
"CocListGreyCyan xxx guifg=#4C566A guibg=#88C0D0
"CocListGreyYellow xxx guifg=#4C566A guibg=#EBCB8B
"CocListGreyMagenta xxx guifg=#4C566A guibg=#B48EAD
"CocListGreyRed xxx guifg=#4C566A guibg=#BF616A
"CocListFgGrey  xxx ctermfg=7 guifg=#4C566A
"CocListBgGrey  xxx ctermbg=7 guibg=#4C566A
"CocListWhiteBlack xxx guifg=#E5E9F0 guibg=#3B4252
"CocListWhiteBlue xxx guifg=#E5E9F0 guibg=#81A1C1
"CocListWhiteGreen xxx guifg=#E5E9F0 guibg=#A3BE8C
"CocListWhiteGrey xxx guifg=#E5E9F0 guibg=#4C566A
"CocListWhiteWhite xxx guifg=#E5E9F0 guibg=#E5E9F0
"CocListWhiteCyan xxx guifg=#E5E9F0 guibg=#88C0D0
"CocListWhiteYellow xxx guifg=#E5E9F0 guibg=#EBCB8B
"CocListWhiteMagenta xxx guifg=#E5E9F0 guibg=#B48EAD
"CocListWhiteRed xxx guifg=#E5E9F0 guibg=#BF616A
"CocListFgWhite xxx ctermfg=15 guifg=#E5E9F0
"CocListBgWhite xxx ctermbg=15 guibg=#E5E9F0
"CocListCyanBlack xxx guifg=#88C0D0 guibg=#3B4252
"CocListCyanBlue xxx guifg=#88C0D0 guibg=#81A1C1
"CocListCyanGreen xxx guifg=#88C0D0 guibg=#A3BE8C
"CocListCyanGrey xxx guifg=#88C0D0 guibg=#4C566A
"CocListCyanWhite xxx guifg=#88C0D0 guibg=#E5E9F0
"CocListCyanCyan xxx guifg=#88C0D0 guibg=#88C0D0
"CocListCyanYellow xxx guifg=#88C0D0 guibg=#EBCB8B
"CocListCyanMagenta xxx guifg=#88C0D0 guibg=#B48EAD
"CocListCyanRed xxx guifg=#88C0D0 guibg=#BF616A
"CocListFgCyan  xxx ctermfg=11 guifg=#88C0D0
"CocListBgCyan  xxx ctermbg=11 guibg=#88C0D0
"CocListYellowBlack xxx guifg=#EBCB8B guibg=#3B4252
"CocListYellowBlue xxx guifg=#EBCB8B guibg=#81A1C1
"CocListYellowGreen xxx guifg=#EBCB8B guibg=#A3BE8C
"CocListYellowGrey xxx guifg=#EBCB8B guibg=#4C566A
"CocListYellowWhite xxx guifg=#EBCB8B guibg=#E5E9F0
"CocListYellowCyan xxx guifg=#EBCB8B guibg=#88C0D0
"CocListYellowYellow xxx guifg=#EBCB8B guibg=#EBCB8B
"CocListYellowMagenta xxx guifg=#EBCB8B guibg=#B48EAD
"CocListYellowRed xxx guifg=#EBCB8B guibg=#BF616A
"CocListFgYellow xxx ctermfg=14 guifg=#EBCB8B
"CocListBgYellow xxx ctermbg=14 guibg=#EBCB8B
"CocListMagentaBlack xxx guifg=#B48EAD guibg=#3B4252
"CocListMagentaBlue xxx guifg=#B48EAD guibg=#81A1C1
"CocListMagentaGreen xxx guifg=#B48EAD guibg=#A3BE8C
"CocListMagentaGrey xxx guifg=#B48EAD guibg=#4C566A
"CocListMagentaWhite xxx guifg=#B48EAD guibg=#E5E9F0
"CocListMagentaCyan xxx guifg=#B48EAD guibg=#88C0D0
"CocListMagentaYellow xxx guifg=#B48EAD guibg=#EBCB8B
"CocListMagentaMagenta xxx guifg=#B48EAD guibg=#B48EAD
"CocListMagentaRed xxx guifg=#B48EAD guibg=#BF616A
"CocListFgMagenta xxx ctermfg=13 guifg=#B48EAD
"CocListBgMagenta xxx ctermbg=13 guibg=#B48EAD
"CocListRedBlack xxx guifg=#BF616A guibg=#3B4252
"CocListRedBlue xxx guifg=#BF616A guibg=#81A1C1
"CocListRedGreen xxx guifg=#BF616A guibg=#A3BE8C
"CocListRedGrey xxx guifg=#BF616A guibg=#4C566A
"CocListRedWhite xxx guifg=#BF616A guibg=#E5E9F0
"CocListRedCyan xxx guifg=#BF616A guibg=#88C0D0
"CocListRedYellow xxx guifg=#BF616A guibg=#EBCB8B
"CocListRedMagenta xxx guifg=#BF616A guibg=#B48EAD
"CocListRedRed  xxx guifg=#BF616A guibg=#BF616A
"CocListFgRed   xxx ctermfg=12 guifg=#BF616A
"CocListBgRed   xxx ctermbg=12 guibg=#BF616A
"CocSemNumber   xxx links to Number
"CocSemFunction xxx links to Function
"CocSemKeyword  xxx links to Keyword
"CocSemParameter xxx links to Identifier
"CocSemEvent    xxx links to Keyword
"CocSemModifier xxx links to StorageClass
"CocSemMacro    xxx links to Define
"CocSemDeprecated xxx links to CocDeprecatedHighlight
"CocSemClass    xxx links to Special
"CocSemDecorator xxx links to Identifier
"CocSemOperator xxx links to Operator
"CocSemStruct   xxx links to Identifier
"CocSemRegexp   xxx links to String
"CocSemMethod   xxx links to Function
"CocSemComment  xxx links to Comment
"CocSemEnum     xxx links to Type
"CocSemInterface xxx links to Type
"CocSemType     xxx links to Type
"CocSemProperty xxx links to Identifier
"CocSemTypeParameter xxx links to Identifier
"CocSemEnumMember xxx links to Constant
"CocSemBoolean  xxx links to Boolean
"CocSemNamespace xxx links to Include
"CocSemString   xxx links to String
"CocSemVariable xxx links to Identifier
"CocSymbolUnit  xxx ctermfg=6 guifg=#88C0D0
"CocSymbolNumber xxx ctermfg=5 guifg=#B48EAD
"CocSymbolFunction xxx ctermfg=6 guifg=#88C0D0
"CocSymbolKey   xxx ctermfg=223 guifg=#D8DEE9
"CocSymbolKeyword xxx ctermfg=4 guifg=#81A1C1
"CocSymbolReference xxx ctermfg=223 guifg=#D8DEE9
"CocSymbolFolder xxx ctermfg=6 guifg=#88C0D0
"CocSymbolVariable xxx ctermfg=223 guifg=#D8DEE9
"CocSymbolNull  xxx ctermfg=4 guifg=#81A1C1
"CocSymbolValue xxx ctermfg=6 guifg=#88C0D0
"CocSymbolConstant xxx ctermfg=223 guifg=#D8DEE9
"CocSymbolText  xxx ctermfg=6 guifg=#88C0D0
"CocSymbolModule xxx ctermfg=4 guifg=#81A1C1
"CocSymbolPackage xxx ctermfg=4 guifg=#81A1C1
"CocSymbolClass xxx ctermfg=223 guifg=#D8DEE9
"CocSymbolOperator xxx ctermfg=4 guifg=#81A1C1
"CocSymbolStruct xxx ctermfg=4 guifg=#81A1C1
"CocSymbolObject xxx ctermfg=6 guifg=#88C0D0
"CocSymbolMethod xxx ctermfg=6 guifg=#88C0D0
"CocSymbolArray xxx ctermfg=6 guifg=#88C0D0
"CocSymbolEnum  xxx ctermfg=6 guifg=#88C0D0
"CocSymbolField xxx ctermfg=223 guifg=#D8DEE9
"CocSymbolInterface xxx ctermfg=6 guifg=#88C0D0
"CocSymbolProperty xxx ctermfg=223 guifg=#D8DEE9
"CocSymbolColor xxx ctermfg=5 guifg=#B48EAD
"CocSymbolFile  xxx ctermfg=4 guifg=#81A1C1
"CocSymbolEvent xxx ctermfg=223 guifg=#D8DEE9
"CocSymbolTypeParameter xxx ctermfg=223 guifg=#D8DEE9
"CocSymbolConstructor xxx ctermfg=223 guifg=#D8DEE9
"CocSymbolSnippet xxx ctermfg=6 guifg=#88C0D0
"CocSymbolBoolean xxx ctermfg=4 guifg=#81A1C1
"CocSymbolNamespace xxx ctermfg=4 guifg=#81A1C1
"CocSymbolString xxx ctermfg=2 guifg=#A3BE8C
"CocSymbolEnumMember xxx ctermfg=223 guifg=#D8DEE9
"CocSelectedLine xxx cleared
"CocErrorLine   xxx cleared
"CocWarningLine xxx cleared
"CocInfoLine    xxx cleared
"CocHintLine    xxx cleared

" ------------------------------------------------------------------------------
" Xterm colors:
"
" 0    Black   (SYSTEM)  #000000
" 1    Maroon  (SYSTEM)  #800000
" 2    Green   (SYSTEM)  #008000
" 3    Olive   (SYSTEM)  #808000
" 4    Navy    (SYSTEM)  #000080
" 5    Purple  (SYSTEM)  #800080
" 6    Teal    (SYSTEM)  #008080
" 7    Silver  (SYSTEM)  #c0c0c0
" 8    Grey    (SYSTEM)  #808080
" 9    Red     (SYSTEM)  #ff0000
" 10   Lime    (SYSTEM)  #00ff00
" 11   Yellow  (SYSTEM)  #ffff00
" 12   Blue    (SYSTEM)  #0000ff
" 13   Fuchsia (SYSTEM)  #ff00ff
" 14   Aqua    (SYSTEM)  #00ffff
" 15   White   (SYSTEM)  #ffffff
" 16   Grey0             #000000
" 17   NavyBlue          #00005f
" 18   DarkBlue          #000087
" 19   Blue3             #0000af
" 20   Blue3             #0000d7
" 21   Blue1             #0000ff
" 22   DarkGreen         #005f00
" 23   DeepSkyBlue4      #005f5f
" 24   DeepSkyBlue4      #005f87
" 25   DeepSkyBlue4      #005faf
" 26   DodgerBlue3       #005fd7
" 27   DodgerBlue2       #005fff
" 28   Green4            #008700
" 29   SpringGreen4      #00875f
" 30   Turquoise4        #008787
" 31   DeepSkyBlue3      #0087af
" 32   DeepSkyBlue3      #0087d7
" 33   DodgerBlue1       #0087ff
" 34   Green3            #00af00
" 35   SpringGreen3      #00af5f
" 36   DarkCyan          #00af87
" 37   LightSeaGreen     #00afaf
" 38   DeepSkyBlue2      #00afd7
" 39   DeepSkyBlue1      #00afff
" 40   Green3            #00d700
" 41   SpringGreen3      #00d75f
" 42   SpringGreen2      #00d787
" 43   Cyan3             #00d7af
" 44   DarkTurquoise     #00d7d7
" 45   Turquoise2        #00d7ff
" 46   Green1            #00ff00
" 47   SpringGreen2      #00ff5f
" 48   SpringGreen1      #00ff87
" 49   MediumSpringGreen #00ffaf
" 50   Cyan2             #00ffd7
" 51   Cyan1             #00ffff
" 52   DarkRed           #5f0000
" 53   DeepPink4         #5f005f
" 54   Purple4           #5f0087
" 55   Purple4           #5f00af
" 56   Purple3           #5f00d7
" 57   BlueViolet        #5f00ff
" 58   Orange4           #5f5f00
" 59   Grey37            #5f5f5f
" 60   MediumPurple4     #5f5f87
" 61   SlateBlue3        #5f5faf
" 62   SlateBlue3        #5f5fd7
" 63   RoyalBlue1        #5f5fff
" 64   Chartreuse4       #5f8700
" 65   DarkSeaGreen4     #5f875f
" 66   PaleTurquoise4    #5f8787
" 67   SteelBlue         #5f87af
" 68   SteelBlue3        #5f87d7
" 69   CornflowerBlue    #5f87ff
" 70   Chartreuse3       #5faf00
" 71   DarkSeaGreen4     #5faf5f
" 72   CadetBlue         #5faf87
" 73   CadetBlue         #5fafaf
" 74   SkyBlue3          #5fafd7
" 75   SteelBlue1        #5fafff
" 76   Chartreuse3       #5fd700
" 77   PaleGreen3        #5fd75f
" 78   SeaGreen3         #5fd787
" 79   Aquamarine3       #5fd7af
" 80   MediumTurquoise   #5fd7d7
" 81   SteelBlue1        #5fd7ff
" 82   Chartreuse2       #5fff00
" 83   SeaGreen2         #5fff5f
" 84   SeaGreen1         #5fff87
" 85   SeaGreen1         #5fffaf
" 86   Aquamarine1       #5fffd7
" 87   DarkSlateGray2    #5fffff
" 88   DarkRed           #870000
" 89   DeepPink4         #87005f
" 90   DarkMagenta       #870087
" 91   DarkMagenta       #8700af
" 92   DarkViolet        #8700d7
" 93   Purple            #8700ff
" 94   Orange4           #875f00
" 95   LightPink4        #875f5f
" 96   Plum4             #875f87
" 97   MediumPurple3     #875faf
" 98   MediumPurple3     #875fd7
" 99   SlateBlue1        #875fff
" 100  Yellow4           #878700
" 101  Wheat4            #87875f
" 102  Grey53            #878787
" 103  LightSlateGrey    #8787af
" 104  MediumPurple      #8787d7
" 105  LightSlateBlue    #8787ff
" 106  Yellow4           #87af00
" 107  DarkOliveGreen3   #87af5f
" 108  DarkSeaGreen      #87af87
" 109  LightSkyBlue3     #87afaf
" 110  LightSkyBlue3     #87afd7
" 111  SkyBlue2          #87afff
" 112  Chartreuse2       #87d700
" 113  DarkOliveGreen3   #87d75f
" 114  PaleGreen3        #87d787
" 115  DarkSeaGreen3     #87d7af
" 116  DarkSlateGray3    #87d7d7
" 117  SkyBlue1          #87d7ff
" 118  Chartreuse1       #87ff00
" 119  LightGreen        #87ff5f
" 120  LightGreen        #87ff87
" 121  PaleGreen1        #87ffaf
" 122  Aquamarine1       #87ffd7
" 123  DarkSlateGray1    #87ffff
" 124  Red3              #af0000
" 125  DeepPink4         #af005f
" 126  MediumVioletRed   #af0087
" 127  Magenta3          #af00af
" 128  DarkViolet        #af00d7
" 129  Purple            #af00ff
" 130  DarkOrange3       #af5f00
" 131  IndianRed         #af5f5f
" 132  HotPink3          #af5f87
" 133  MediumOrchid3     #af5faf
" 134  MediumOrchid      #af5fd7
" 135  MediumPurple2     #af5fff
" 136  DarkGoldenrod     #af8700
" 137  LightSalmon3      #af875f
" 138  RosyBrown         #af8787
" 139  Grey63            #af87af
" 140  MediumPurple2     #af87d7
" 141  MediumPurple1     #af87ff
" 142  Gold3             #afaf00
" 143  DarkKhaki         #afaf5f
" 144  NavajoWhite3      #afaf87
" 145  Grey69            #afafaf
" 146  LightSteelBlue3   #afafd7
" 147  LightSteelBlue    #afafff
" 148  Yellow3           #afd700
" 149  DarkOliveGreen3   #afd75f
" 150  DarkSeaGreen3     #afd787
" 151  DarkSeaGreen2     #afd7af
" 152  LightCyan3        #afd7d7
" 153  LightSkyBlue1     #afd7ff
" 154  GreenYellow       #afff00
" 155  DarkOliveGreen2   #afff5f
" 156  PaleGreen1        #afff87
" 157  DarkSeaGreen2     #afffaf
" 158  DarkSeaGreen1     #afffd7
" 159  PaleTurquoise1    #afffff
" 160  Red3              #d70000
" 161  DeepPink3         #d7005f
" 162  DeepPink3         #d70087
" 163  Magenta3          #d700af
" 164  Magenta3          #d700d7
" 165  Magenta2          #d700ff
" 166  DarkOrange3       #d75f00
" 167  IndianRed         #d75f5f
" 168  HotPink3          #d75f87
" 169  HotPink2          #d75faf
" 170  Orchid            #d75fd7
" 171  MediumOrchid1     #d75fff
" 172  Orange3           #d78700
" 173  LightSalmon3      #d7875f
" 174  LightPink3        #d78787
" 175  Pink3             #d787af
" 176  Plum3             #d787d7
" 177  Violet            #d787ff
" 178  Gold3             #d7af00
" 179  LightGoldenrod3   #d7af5f
" 180  Tan               #d7af87
" 181  MistyRose3        #d7afaf
" 182  Thistle3          #d7afd7
" 183  Plum2             #d7afff
" 184  Yellow3           #d7d700
" 185  Khaki3            #d7d75f
" 186  LightGoldenrod2   #d7d787
" 187  LightYellow3      #d7d7af
" 188  Grey84            #d7d7d7
" 189  LightSteelBlue1   #d7d7ff
" 190  Yellow2           #d7ff00
" 191  DarkOliveGreen1   #d7ff5f
" 192  DarkOliveGreen1   #d7ff87
" 193  DarkSeaGreen1     #d7ffaf
" 194  Honeydew2         #d7ffd7
" 195  LightCyan1        #d7ffff
" 196  Red1              #ff0000
" 197  DeepPink2         #ff005f
" 198  DeepPink1         #ff0087
" 199  DeepPink1         #ff00af
" 200  Magenta2          #ff00d7
" 201  Magenta1          #ff00ff
" 202  OrangeRed1        #ff5f00
" 203  IndianRed1        #ff5f5f
" 204  IndianRed1        #ff5f87
" 205  HotPink           #ff5faf
" 206  HotPink           #ff5fd7
" 207  MediumOrchid1     #ff5fff
" 208  DarkOrange        #ff8700
" 209  Salmon1           #ff875f
" 210  LightCoral        #ff8787
" 211  PaleVioletRed1    #ff87af
" 212  Orchid2           #ff87d7
" 213  Orchid1           #ff87ff
" 214  Orange1           #ffaf00
" 215  SandyBrown        #ffaf5f
" 216  LightSalmon1      #ffaf87
" 217  LightPink1        #ffafaf
" 218  Pink1             #ffafd7
" 219  Plum1             #ffafff
" 220  Gold1             #ffd700
" 221  LightGoldenrod2   #ffd75f
" 222  LightGoldenrod2   #ffd787
" 223  NavajoWhite1      #ffd7af
" 224  MistyRose1        #ffd7d7
" 225  Thistle1          #ffd7ff
" 226  Yellow1           #ffff00
" 227  LightGoldenrod1   #ffff5f
" 228  Khaki1            #ffff87
" 229  Wheat1            #ffffaf
" 230  Cornsilk1         #ffffd7
" 231  Grey100           #ffffff
" 232  Grey3             #080808
" 233  Grey7             #121212
" 234  Grey11            #1c1c1c
" 235  Grey15            #262626
" 236  Grey19            #303030
" 237  Grey23            #3a3a3a
" 238  Grey27            #444444
" 239  Grey30            #4e4e4e
" 240  Grey35            #585858
" 241  Grey39            #626262
" 242  Grey42            #6c6c6c
" 243  Grey46            #767676
" 244  Grey50            #808080
" 245  Grey54            #8a8a8a
" 246  Grey58            #949494
" 247  Grey62            #9e9e9e
" 248  Grey66            #a8a8a8
" 249  Grey70            #b2b2b2
" 250  Grey74            #bcbcbc
" 251  Grey78            #c6c6c6
" 252  Grey82            #d0d0d0
" 253  Grey85            #dadada
" 254  Grey89            #e4e4e4
" 255  Grey93            #eeeeee
" ------------------------------------------------------------------------------
