local vim = vim
Colors = require("safdar.plugins.personal.fused-nvim.pallete")
-- TODO: lsp utilities borders

function FusedNvim()
    vim.opt.background = "dark"

    local hl = function(highlightGroup, opts)
        vim.api.nvim_set_hl(0, highlightGroup, opts)
    end

    hl("guibg", {
        bg = "None",
    })

    hl("netrwDir", {
        fg = "#5eacd3",
    })
    -- nvim theme
    -- ++>
    hl("Comment", { fg = Colors.color_9 }) -- any comment
    hl("ColorColumn", { bg = Colors.dark_blue }) -- used for the columns set with 'colorcolumn'
    hl("Conceal", { fg = Colors.color_22_one }) -- placeholder characters substituted for concealed text (see 'conceallevel')
    -- TODO:	 play with cursor color
    hl("Cursor", { fg = Colors.color_1, bg = Colors.bg }) -- character under the cursor
    hl("lCursor", { fg = Colors.color_14_drac, bg = Colors.color_5 }) -- the character under the cursor when |language-mapping| is used (see 'guicursor')
    hl("CursorIM", { fg = Colors.color_1, bg = Colors.bg }) -- like Cursor, but used when in IME mode |CursorIM|
    hl("CursorColumn", { bg = Colors.color_2 }) -- Screen-column at the cursor, when 'cursorcolumn' is set.
    hl("CursorLine", { bg = Colors.color_2 }) -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
    hl("Directory", { fg = Colors.color_15 }) -- directory names (and other special names in listings)
    hl("DiffAdd", { fg = Colors.vc_add, bg = Colors.vc_text_bg }) -- diff mode: Added line |diff.txt|
    hl("DiffChange", { fg = Colors.vc_change, bg = Colors.vc_text_bg, underline = true }) -- diff mode: Changed line |diff.txt|
    hl("DiffDelete", { fg = Colors.vc_remove, bg = Colors.vc_text_bg }) -- diff mode: Deleted line |diff.txt|
    -- DiffText     { }, -- diff mode: Changed text within a changed line |diff.txt|
    hl("EndOfBuffer", { fg = Colors.color_3 }) -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
    hl("TermCursor", { fg = Colors.fg, bg = Colors.fg }) -- cursor in a focused terminal
    hl("TermCursorNC", { fg = Colors.fg, bg = Colors.fg }) -- cursor in an unfocused terminal
    hl("ErrorMsg", { fg = Colors.error_red, bg = Colors.bg, bold = true }) -- error messages on the command line
    hl("VertSplit", { fg = Colors.color_13 }) -- the column separating vertically split windows
    hl("Folded", { fg = Colors.color_8, bg = Colors.color_1 }) -- line used for closed folds
    hl("FoldColumn", { fg = Colors.color_8, bg = Colors.color_1 }) -- 'foldcolumn'
    hl("SignColumn", { bg = Colors.bg }) -- column where |signs| are displayed
    hl("IncSearch", { bg = Colors.color_4 }) -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    hl("Substitute", { fg = Colors.error_red, bg = Colors.color_2, underline = true }) -- |:substitute| replacement text highlighting
    hl("LineNr", { fg = Colors.color_8 }) -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    hl("CursorLineNr", { fg = Colors.color_20, bold = true }) -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    hl("MatchParen", { bg = Colors.color_2, bold = true, underline = true }) -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    hl("ModeMsg", { fg = Colors.fg, bg = Colors.bg }) -- 'showmode' message (e.g., "-- INSERT -- ")
    hl("MsgArea", { fg = Colors.color_5, bg = Colors.transparent and "NONE" or Colors.bg }) -- Area for messages and cmdline
    hl("MsgSeparator", { fg = Colors.fg, bg = Colors.bg }) -- Separator for scrolled messages, `msgsep` flag of 'display'
    hl("MoreMsg", { fg = Colors.fg, bg = Colors.bg }) -- |more-prompt|
    hl("NonText", { fg = Colors.color_9 }) -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    hl("Normal", { fg = Colors.fg, bg = Colors.transparent and "NONE" or Colors.bg }) -- normal text
    hl("NormalFloat", { fg = Colors.string, bg = Colors.bg }) -- Normal text in floating windows.
    hl("FloatBorder", { fg = Colors.color_2 })
    hl("NormalBorder", { fg = Colors.string, bg = Colors.bg }) -- Normal text in floating windows.
    -- NormalNC({ fg = color.fg, bg = Config.transparent_background and "NONE" or color.bg }), -- normal text in non-current windows
    hl("Pmenu", { fg = Colors.color_25, bg = Colors.bg }) -- Popup menu: normal item.
    hl("PmenuSel", { bg = Colors.color_2 }) -- Popup menu: selected item.
    hl("PmenuSbar", { bg = Colors.color_8 }) -- Popup menu: scrollbar.
    hl("PmenuThumb", { bg = Colors.color_20 }) -- Popup menu: Thumb of the scrollbar.
    hl("Question", { fg = Colors.color_20 }) -- |hit-enter| prompt and yes/no questions
    hl("QuickFixLine", { bg = Colors.color_5 }) -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    hl("Search", { bg = Colors.color_4 }) -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
    hl("SpecialKey", { fg = Colors.color_23, bold = true }) -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
    hl("SpellBad", { fg = Colors.error_red, underline = true }) -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    hl("SpellCap", { fg = Colors.color_18, underline = true }) -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    hl("SpellLocal", { fg = Colors.color_23, underline = true }) -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    hl("SpellRare", { fg = Colors.color_16, underline = true }) -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
    hl("StatusLine", { bg = Colors.bg }) -- status line of current window
    hl("StatusLineNC", { bg = Colors.color_2 }) -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    hl("TabLine", { fg = Colors.color_8, bg = Colors.color_1 }) -- tab pages line, not active tab page label
    hl("TabLineFill", { fg = Colors.fg, bg = Colors.color_4 }) -- tab pages line, where there are no labels
    hl("TabLineSel", { fg = Colors.fg, bg = Colors.color_4 }) -- tab pages line, active tab page label
    hl("Title", { fg = Colors.color_21, bold = true }) -- titles for output from ":set all", ":autocmd" etc.
    hl("Visual", { bg = Colors.color_2 }) -- Visual mode selection
    hl("VisualNOS", { bg = Colors.error_red }) -- Visual mode selection when vim is "Not Owning the Selection".
    hl("WarningMsg", { fg = Colors.error_red, bg = Colors.color_5 }) -- warning messages
    hl("Whitespace", { fg = Colors.color_3 }) -- "nbsp", "space", "tab" and "trail" in 'listchars'
    hl("WildMenu", { fg = Colors.color_7, bg = Colors.color_16 }) -- current match in 'wildmenu' completion
    -- custom
    hl("DamianConway", { bg = Colors.color_2 }) -- this is a custom highlight group
    -- <++

    -- These groups are not listed as default vim groups,
    -- but they are defacto standard group names for syntax highlighting.
    -- commented out groups should chain up to their "preferred" group by
    -- default,
    -- Uncomment and edit if you want more specific syntax highlighting.
    -- Nvim Syntax Highlights
    -- ++>
    hl("Constant", { link = "TSConstant" }) -- (preferred) any constant
    hl("String", { link = "TSString" }) --   a string constant: "this is a string"
    hl("Character", { link = "TSCharacter" }) --  a character constant: 'c', '\n'
    hl("Number", { link = "TSNumber" }) --   a number constant: 234, 0xff
    hl("Boolean", { link = "TSBoolean" }) --  a boolean constant: TRUE, false
    hl("Float", { link = "TSFloat" }) --    a floating point constant: 2.3e10
    --
    hl("Identifier", { fg = Colors.color_21 }) -- (preferred) any variable name
    hl("Function", { link = "TSFunction" }) -- function name (also: methods for classes)
    --
    hl("Statement", { fg = Colors.color_23 }) -- (preferred) any statement
    hl("Conditional", { fg = Colors.color_23 }) --  if, then, else, endif, switch, etc.
    hl("Repeat", { fg = Colors.color_23 }) --   for, do, while, etc.
    hl("Label", { link = "TSLabel" }) --    case, default, etc.
    hl("Operator", { link = "TSOperator" }) -- "sizeof", "+", "*", etc.
    hl("Keyword", { link = "TSKeyword" }) --  any other keyword
    hl("Exception", { link = "TSException" }) --  try, catch, throw
    --
    hl("PreProc", { fg = Colors.color_27 }) -- (preferred) generic Preprocessor
    hl("Include", { fg = Colors.color_23 }) --  preprocessor #include
    hl("Define", { fg = Colors.color_23 }) --   preprocessor #define
    hl("Macro", { fg = Colors.color_23 }) --    same as Define
    hl("PreCondit", { link = "TSConditional" }) --  preprocessor #if, #else, #endif, etc.
    --
    hl("Type", { link = "TSType" }) -- (preferred) int, long, char, etc.
    hl("StorageClass", { fg = Colors.color_21 }) -- static, register, volatile, etc.
    hl("Structure", { fg = Colors.color_23 }) --  struct, union, enum, etc.
    hl("Typedef", { fg = Colors.color_23 }) --  A typedef
    --
    hl("Special", { fg = Colors.color_23 }) -- (preferred) any special symbol
    hl("SpecialChar", { fg = Colors.color_15 }) --  special character in a constant
    hl("Tag", { fg = Colors.color_22_one }) --    you can use CTRL-] on this
    hl("Delimiter", { fg = Colors.color_16 }) --  character that needs attention
    hl("SpecialComment", { fg = Colors.color_5 }) -- special things inside a comment
    hl("Debug", { fg = Colors.color_22_one }) --    debugging statements
    -- <++

    -- ("Ignore", below, may be invisible...)
    -- Ignore         { }, -- (preferred) left blank, hidden  |hl-Ignore|

    hl("Error", { fg = Colors.error_red, bg = Colors.bg, bold = true }) -- (preferred) any erroneous construct

    hl("Todo", { fg = Colors.color_20, bg = Colors.bg, bold = true }) -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    -- These groups are for the native LSP client. Some other LSP clients may
    -- use these groups, or use their own. Consult your LSP client's
    -- documentation.
    -- Lsp Conf
    -- ++>
    hl("LspReferenceText", { bg = Colors.color_22_one, bold = true }) -- used for highlighting "text" references
    hl("LspReferenceRead", { bg = Colors.color_22_one, bold = true }) -- used for highlighting "read" references
    hl("LspReferenceWrite", { bg = Colors.color_22_one, bold = true }) -- used for highlighting "write" references
    --
    hl("LspDiagnosticsDefaultError", { link = "TSError" }) -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
    hl("LspDiagnosticsDefaultWarning", { link = "TSWarning" }) -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
    hl("LspDiagnosticsDefaultInformation", { fg = Colors.color_21 }) -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
    hl("LspDiagnosticsDefaultHint", { fg = Colors.color_14_drac }) -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
    --
    hl("LspDiagnosticsVirtualTextError", { link = "TSError" }) -- Used for "Error" diagnostic virtual text
    hl("LspDiagnosticsVirtualTextWarning", { link = "TSWarning" }) -- Used for "Warning" diagnostic virtual text
    hl("LspDiagnosticsVirtualTextInformation", { link = "LspDiagnosticsDefaultInformation" }) -- Used for "Information" diagnostic virtual text
    hl("LspDiagnosticsVirtualTextHint", { link = "LspDiagnosticsDefaultHint" }) -- Used for "Hint" diagnostic virtual text
    --
    hl("LspDiagnosticsUnderlineError", { underline = true }) -- Used to underline "Error" diagnostics
    hl("LspDiagnosticsUnderlineWarning", { underline = true }) -- Used to underline "Warning" diagnostics
    hl("LspDiagnosticsUnderlineInformation", { underline = true }) -- Used to underline "Information" diagnostics
    hl("LspDiagnosticsUnderlineHint", { underline = true }) -- Used to underline "Hint" diagnostics
    --
    hl("LspDiagnosticsFloatingError", { link = "TSError" }) -- Used to color "Error" diagnostic messages in diagnostics float
    hl("LspDiagnosticsFloatingWarning", { link = "TSWarning" }) -- Used to color "Warning" diagnostic messages in diagnostics float
    hl("LspDiagnosticsFloatingInformation", { link = "LspDiagnosticsDefaultInformation" }) -- Used to color "Information" diagnostic messages in diagnostics float
    hl("LspDiagnosticsFloatingHint", { link = "LspDiagnosticsDefaultHint" }) -- Used to color "Hint" diagnostic messages in diagnostics float
    --
    hl("LspDiagnosticsSignError", { link = "TSError" }) -- Used for "Error" signs in sign column
    hl("LspDiagnosticsSignWarning", { link = "TSWarning" }) -- Used for "Warning" signs in sign column
    hl("LspDiagnosticsSignInformation", { link = "LspDiagnosticsDefaultInformation" }) -- Used for "Information" signs in sign column
    hl("LspDiagnosticsSignHint", { link = "LspDiagnosticsDefaultHint" }) -- Used for "Hint" signs in sign column
    --
    -- LspCodeLens                          { }, -- Used to color the virtual text of the codelens
    --
    -- These groups are for the neovim tree-sitter highlights.
    -- As of writing, tree-sitter support is a WIP, group names may change.
    -- By default, most of these groups link to an appropriate Vim group,
    -- TSError -> Error for example, so you do not have to define these unless
    -- you explicitly want to support Treesitter's improved syntax awareness.
    --
    hl("TSAnnotation", { fg = Colors.color_15 }) -- For C++/Dart attributes, annotations that can be attached to the code to denote some kind of meta information.
    hl("TSAttribute", { fg = Colors.color_21 }) -- (unstable) TODO: docs
    hl("TSBoolean", { fg = Colors.color_20 }) -- For booleans.
    hl("TSCharacter", { fg = Colors.color_15 }) -- For characters.
    hl("TSComment", { fg = Colors.color_5 }) -- For comment blocks.
    hl("TSConstructor", { fg = Colors.color_18 }) -- For constructor calls and definitions: ` { }` in Lua, and Java constructors.
    hl("TSConditional", { fg = Colors.color_20 }) -- For keywords related to conditionnals.
    hl("TSConstant", { fg = Colors.color_17 }) -- For constants
    hl("TSConstBuiltin", { fg = Colors.color_18 }) -- For constant that are built in the language: `nil` in Lua.
    hl("TSConstMacro", { fg = Colors.color_21 }) -- For constants that are defined by macros: `NULL` in C.
    hl("TSError", { fg = Colors.error_red }) -- For syntax/parser errors.
    hl("TSException", { fg = Colors.color_20 }) -- For exception related keywords.
    hl("TSField", { fg = Colors.color_21 }) -- For fields.
    hl("TSFloat", { fg = Colors.color_20 }) -- For floats.
    hl("TSFunction", { fg = Colors.color_16 }) -- For function (calls and definitions).
    hl("TSFuncBuiltin", { fg = Colors.color_14_one }) -- For builtin functions: `table.insert` in Lua.
    hl("TSFuncMacro", { fg = Colors.color_27 }) -- For macro defined fuctions (calls and definitions): each `macro_rules` in Rust.
    hl("TSInclude", { fg = Colors.color_14_drac }) -- For includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.
    hl("TSKeyword", { fg = Colors.color_24 }) -- For keywords that don't fall in previous categories.
    hl("TSKeywordFunction", { fg = Colors.color_22_one, bold = true }) -- For keywords used to define a fuction.
    hl("TSKeywordOperator", { fg = Colors.color_24 }) -- For keywords used to define a fuction.
    hl("TSKeywordReturn", { fg = Colors.color_22_drac, bold = true }) -- For keywords used to define a fuction.
    hl("TSLabel", { fg = Colors.color_22_one }) -- For labels: `label:` in C and `:label:` in Lua.
    hl("TSMethod", { fg = Colors.color_15 }) -- For method calls and definitions.
    hl("TSNamespace", { fg = Colors.color_24 }) -- For identifiers referring to modules and namespaces.
    hl("TSNone", { fg = Colors.fg }) -- TODO: docs
    hl("TSNumber", { fg = Colors.color_18 }) -- For all numbers
    hl("TSOperator", { fg = Colors.color_27 }) -- For any operator: `+`, but also `->` and `*` in C.
    hl("TSParameter", { fg = Colors.color_20 }) -- For parameters of a function.
    hl("TSParameterReference", { fg = Colors.color_20 }) -- For references to parameters of a function.
    hl("TSProperty", { fg = Colors.color_29 }) -- Same as `TSField`.
    hl("TSPunctDelimiter", { fg = Colors.fg }) -- For delimiters ie: `.`
    hl("TSPunctBracket", { fg = Colors.fg }) -- For brackets and parens.
    hl("TSPunctSpecial", { fg = Colors.color_23 }) -- For special punctutation that does not fall in the catagories before.
    hl("TSRepeat", { fg = Colors.color_23 }) -- For keywords related to loops.
    hl("TSString", { fg = Colors.string_color }) -- For strings.
    hl("TSStringRegex", { fg = Colors.color_14_drac }) -- For regexes.
    hl("TSStringEscape", { fg = Colors.color_22_one }) -- For escape characters within a string.
    hl("TSSymbol", { fg = Colors.color_21 }) -- For identifiers referring to symbols or atoms.
    hl("TSType", { fg = Colors.color_17 }) -- For types.
    hl("TSTypeBuiltin", { fg = Colors.color_17 }) -- For builtin types.
    hl("TSVariable", { fg = Colors.fg }) -- Any variable name that does not have another highlight.
    hl("TSVariableBuiltin", { fg = Colors.color_23 }) -- Variable names that are defined by the languages, like `this` or `self`.
    --
    hl("TSTag", { fg = Colors.color_22_one }) -- Tags like html tag names.
    hl("TSTagAttribute", { fg = Colors.color_20 }) -- Tags like html tag names.
    hl("TSTagDelimiter", { fg = Colors.color_9 }) -- Tag delimiter like `<` `>` `/`
    hl("TSText", { fg = Colors.fg }) -- For strings considered text in a markup language.
    hl("TSEmphasis", { italic = true }) -- For text to be represented with emphasis.
    hl("TSUnderline", { underline = true }) -- For text to be represented with an underline.
    -- TSStrike             {};    -- For strikethrough text.
    hl("TSTitle", { fg = Colors.color_14_drac, bold = true }) -- Text that is part of a title.
    hl("TSLiteral", { fg = Colors.color_26 }) -- Literal text.
    hl("TSURI", { fg = Colors.color_28, underline = true }) -- Any URI like a link or email.
    -- <++

    --> CSS
    -- ++>
    hl("cssTsProperty", { fg = Colors.color_27 })
    hl("cssTsOperator", { fg = Colors.color_14_drac })
    -- <++

    --> (Telescope)
    -- ++>
    hl("TelescopeSelection", { bg = Colors.color_2, bold = true })
    hl("TelescopeSelectionCaret", { fg = Colors.color_20 })
    hl("TelescopeMultiSelection", { fg = Colors.color_8 })
    hl("TelescopeMatching", { fg = Colors.color_14_drac })
    hl("TelescopePromptPrefix", { fg = Colors.color_18 })
    hl("TelescopeBorder", { fg = Colors.color_3 })
    hl("TelescopePromptBorder", { fg = Colors.color_3 })
    hl("TelescopeResultsBorder", { fg = Colors.color_3 })
    hl("TelescopePreviewBorder", { fg = Colors.color_3 })
    hl("TelescopeTitle", { fg = Colors.color_23, bold = true })
    hl("TelescopePromptTitle", { fg = Colors.color_18, bold = true })
    hl("TelescopeResultsTitle", { fg = Colors.color_15, bold = true })
    hl("TelescopePreviewTitle", { fg = Colors.color_23, bold = true })
    -- <++

    -- (NvimTree)
    -- ++>
    hl("NvimTreeGitDirty", { fg = Colors.fl_color_13 })
    hl("NvimTreeGitStaged", { fg = Colors.fl_color_1 })
    hl("NvimTreeGitNew", { fg = Colors.fl_color_13 })
    hl("NvimTreeGitDeleted", { fg = Colors.fl_color_13 })
    hl("NvimTreeRootFolder", { fg = Colors.fl_color_7 })
    hl("NvimTreeIndentMarker", { fg = Colors.fl_color_10 })
    hl("NvimTreeSymlink", { fg = Colors.color_28 })
    hl("NvimTreeFolderName", { fg = Colors.fl_color_12 })
    hl("NvimTreeFolderIcon", { link = "NvimTreeFolderName" })
    hl("NvimTreeEmptyFolderName", { fg = Colors.color_25 })
    hl("NvimTreeOpenedFolderName", { link = "NvimTreeFolderName" })
    hl("NvimTreeExecFile", { fg = Colors.color_14_drac })
    hl("NvimtreeFileStaged", { fg = Colors.color_14_drac })
    -- NvimTreeGitMerge
    -- NvimTreeFileDirty
    -- NvimTreeFileStaged
    -- NvimTreeGitRenamed
    -- NvimTreeFileMerge
    -- NvimTreeFileRenamed
    -- NvimTreeFileNew
    -- NvimTreeFileDeleted
    -- NvimTreeOpenedFile
    -- NvimTreeSpecialFile
    -- NvimTreeImageFile
    -- NvimTreeMarkdownFile
    -- NvimTreeLicenseIcon
    -- NvimTreeYamlIcon
    -- NvimTreeTomlIcon
    -- NvimTreeGitignoreIcon
    -- NvimTreeJsonIcon
    -- NvimTreeLuaIcon
    -- NvimTreePythonIcon
    -- NvimTreeShellIcon
    -- NvimTreeJavascriptIcon
    -- NvimTreeCIcon
    -- NvimTreeReactIcon
    -- NvimTreeHtmlIcon
    -- NvimTreeRustIcon
    -- NvimTreeVimIcon
    -- NvimTreeTypescriptIcon
    -- <++

    --> TODO:(Trouble)
    -- ++>
    -- TroubleCount
    -- TroubleError
    -- TroubleNormal
    -- TroubleTextInformation
    -- TroubleSignWarning
    -- TroubleLocation
    -- TroubleWarning
    -- TroublePreview
    -- TroubleTextError
    -- TroubleSignInformation
    -- TroubleIndent
    -- TroubleSource
    -- TroubleSignHint
    -- TroubleSignOther
    -- TroubleFoldIcon
    -- TroubleTextWarning
    -- TroubleCode
    -- TroubleInformation
    -- TroubleSignError
    -- TroubleFile
    -- TroubleHint
    -- TroubleTextHint
    -- TroubleText
    -- <++

    --> (cmp)
    -- ++>
    -- TODO: CmpItemKind%
    --> Cmp
    hl("CmpItemAbbr", { fg = Colors.color_25 })
    hl("CmpItemAbbrDeprecated", { fg = Colors.color_9 })
    hl("CmpItemAbbrMatch", { fg = Colors.color_14_drac })
    hl("CmpItemAbbrMatchFuzzy", { fg = Colors.color_20 })
    hl("CmpItemMenu", { fg = Colors.color_8 })
    hl("CmpItemKindSnippet", { fg = Colors.vc_add })
    -- Item kind
    hl("CmpItemKindText", { link = "TSText" })
    hl("CmpItemKindFunction", { link = "TSFunction" })
    hl("CmpItemKindKeyword", { link = "TSKeyword" })
    hl("CmpItemKindField", { link = "TSField" })
    hl("CmpItemKindVariable", { link = "TSVariable" })
    hl("CmpItemKindEnum", { link = "CmpItemKindText" })
    -- <++

    --> (IndentBlankline)
    -- ++>
    hl("IndentBlanklineChar", { fg = Colors.color_2 })
    hl("IndentBlanklineSpaceChar", { fg = Colors.error_red })
    hl("IndentBlanklineSpaceCharBlankline", { fg = Colors.error_red })
    hl("IndentBlanklineContextChar", { fg = Colors.color_5 })
    hl("IndentBlanklineContextSpaceChar", { fg = Colors.error_red })
    hl("IndentBlanklineContextStart", { fg = Colors.error_red })
    -- <++
end

FusedNvim()
