local vim = vim
local color = require("after.plugin.dracula-refined.dracula-pallete")
-- TODO: lsp utilities borders

function Theme()
	vim.opt.background = "dark"

	local hl = function(thing, opts)
		vim.api.nvim_set_hl(0, thing, opts)
	end

	hl("guibg", {
		bg = "None",
	})

	hl("netrwDir", {
		fg = "#5eacd3",
	})
	-- nvim theme
	-- ++>
	hl("Comment", { fg = color.color_9 }) -- any comment
	hl("ColorColumn", { bg = color.dark_blue }) -- used for the columns set with 'colorcolumn'
	hl("Conceal", { fg = color.color_22_one }) -- placeholder characters substituted for concealed text (see 'conceallevel')
	-- TODO:	 play with cursor color
	hl("Cursor", { fg = color.color_1, bg = color.bg }) -- character under the cursor
	hl("lCursor", { fg = color.color_14_drac, bg = color.color_5 }) -- the character under the cursor when |language-mapping| is used (see 'guicursor')
	hl("CursorIM", { fg = color.color_1, bg = color.bg }) -- like Cursor, but used when in IME mode |CursorIM|
	hl("CursorColumn", { bg = color.color_2 }) -- Screen-column at the cursor, when 'cursorcolumn' is set.
	hl("CursorLine", { bg = color.color_2 }) -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
	hl("Directory", { fg = color.color_15 }) -- directory names (and other special names in listings)
	hl("DiffAdd", { fg = color.vc_add, bg = color.vc_text_bg }) -- diff mode: Added line |diff.txt|
	hl("DiffChange", { fg = color.vc_change, bg = color.vc_text_bg, underline = true }) -- diff mode: Changed line |diff.txt|
	hl("DiffDelete", { fg = color.vc_remove, bg = color.vc_text_bg }) -- diff mode: Deleted line |diff.txt|
	-- DiffText     { }, -- diff mode: Changed text within a changed line |diff.txt|
	hl("EndOfBuffer", { fg = color.color_3 }) -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
	hl("TermCursor", { fg = color.fg, bg = color.fg }) -- cursor in a focused terminal
	hl("TermCursorNC", { fg = color.fg, bg = color.fg }) -- cursor in an unfocused terminal
	hl("ErrorMsg", { fg = color.error_red, bg = color.bg, bold = true }) -- error messages on the command line
	hl("VertSplit", { fg = color.color_13 }) -- the column separating vertically split windows
	hl("Folded", { fg = color.color_8, bg = color.color_1 }) -- line used for closed folds
	hl("FoldColumn", { fg = color.color_8, bg = color.color_1 }) -- 'foldcolumn'
	hl("SignColumn", { bg = color.bg }) -- column where |signs| are displayed
	hl("IncSearch", { bg = color.color_4 }) -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
	hl("Substitute", { fg = color.error_red, bg = color.color_2, underline = true }) -- |:substitute| replacement text highlighting
	hl("LineNr", { fg = color.color_8 }) -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
	hl("CursorLineNr", { fg = color.color_20, bold = true }) -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
	hl("MatchParen", { bg = color.color_2, bold = true, underline = true }) -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
	hl("ModeMsg", { fg = color.fg, bg = color.bg }) -- 'showmode' message (e.g., "-- INSERT -- ")
	hl("MsgArea", { fg = color.color_5, bg = color.transparent and "NONE" or color.bg }) -- Area for messages and cmdline
	hl("MsgSeparator", { fg = color.fg, bg = color.bg }) -- Separator for scrolled messages, `msgsep` flag of 'display'
	hl("MoreMsg", { fg = color.fg, bg = color.bg }) -- |more-prompt|
	hl("NonText", { fg = color.color_9 }) -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
	hl("Normal", { fg = color.fg, bg = color.transparent and "NONE" or color.bg }) -- normal text
	hl("NormalFloat", { fg = color.string, bg = color.bg }) -- Normal text in floating windows.
	hl("FloatBorder", { fg = color.color_2 })
	hl("NormalBorder", { fg = color.string, bg = color.bg }) -- Normal text in floating windows.
	-- NormalNC({ fg = color.fg, bg = Config.transparent_background and "NONE" or color.bg }), -- normal text in non-current windows
	hl("Pmenu", { fg = color.color_25, bg = color.bg }) -- Popup menu: normal item.
	hl("PmenuSel", { bg = color.color_2 }) -- Popup menu: selected item.
	hl("PmenuSbar", { bg = color.color_8 }) -- Popup menu: scrollbar.
	hl("PmenuThumb", { bg = color.color_20 }) -- Popup menu: Thumb of the scrollbar.
	hl("Question", { fg = color.color_20 }) -- |hit-enter| prompt and yes/no questions
	hl("QuickFixLine", { bg = color.color_5 }) -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
	hl("Search", { bg = color.color_4 }) -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
	hl("SpecialKey", { fg = color.color_23, bold = true }) -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
	hl("SpellBad", { fg = color.error_red, underline = true }) -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
	hl("SpellCap", { fg = color.color_18, underline = true }) -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
	hl("SpellLocal", { fg = color.color_23, underline = true }) -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
	hl("SpellRare", { fg = color.color_16, underline = true }) -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
	hl("StatusLine", { bg = color.bg }) -- status line of current window
	hl("StatusLineNC", { bg = color.color_2 }) -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
	hl("TabLine", { fg = color.color_8, bg = color.color_1 }) -- tab pages line, not active tab page label
	hl("TabLineFill", { fg = color.fg, bg = color.color_4 }) -- tab pages line, where there are no labels
	hl("TabLineSel", { fg = color.fg, bg = color.color_4 }) -- tab pages line, active tab page label
	hl("Title", { fg = color.color_21, bold = true }) -- titles for output from ":set all", ":autocmd" etc.
	hl("Visual", { bg = color.color_2 }) -- Visual mode selection
	hl("VisualNOS", { bg = color.error_red }) -- Visual mode selection when vim is "Not Owning the Selection".
	hl("WarningMsg", { fg = color.error_red, bg = color.color_5 }) -- warning messages
	hl("Whitespace", { fg = color.color_3 }) -- "nbsp", "space", "tab" and "trail" in 'listchars'
	hl("WildMenu", { fg = color.color_7, bg = color.color_16 }) -- current match in 'wildmenu' completion
	-- custom
	hl("DamianConway", { bg = color.color_2 }) -- this is a custom highlight group
	-- <++

	-- These groups are not listed as default vim groups,
	-- but they are defacto standard group names for syntax highlighting.
	-- commented out groups should chain up to their "preferred" group by
	-- default,
	-- Uncomment and edit if you want more specific syntax highlighting.
	-- ++>
	hl("Constant", { fg = color.color_17 }) -- (preferred) any constant
	hl("String", { fg = color.string_color }) --   a string constant: "this is a string"
	hl("Character", { fg = color.color_14_drac }) --  a character constant: 'c', '\n'
	hl("Number", { fg = color.color_20 }) --   a number constant: 234, 0xff
	hl("Boolean", { fg = color.color_20 }) --  a boolean constant: TRUE, false
	hl("Float", { fg = color.color_20 }) --    a floating point constant: 2.3e10
	--
	hl("Identifier", { fg = color.color_21 }) -- (preferred) any variable name
	hl("Function", { fg = color.color_14_drac }) -- function name (also: methods for classes)
	--
	hl("Statement", { fg = color.color_23 }) -- (preferred) any statement
	hl("Conditional", { fg = color.color_23 }) --  if, then, else, endif, switch, etc.
	hl("Repeat", { fg = color.color_23 }) --   for, do, while, etc.
	hl("Label", { fg = color.color_27 }) --    case, default, etc.
	hl("Operator", { fg = color.color_27 }) -- "sizeof", "+", "*", etc.
	hl("Keyword", { fg = color.color_24 }) --  any other keyword
	hl("Exception", { fg = color.color_23 }) --  try, catch, throw
	--
	hl("PreProc", { fg = color.color_27 }) -- (preferred) generic Preprocessor
	hl("Include", { fg = color.color_23 }) --  preprocessor #include
	hl("Define", { fg = color.color_23 }) --   preprocessor #define
	hl("Macro", { fg = color.color_23 }) --    same as Define
	hl("PreCondit", { fg = color.color_23 }) --  preprocessor #if, #else, #endif, etc.
	--
	hl("Type", { fg = color.color_18 }) -- (preferred) int, long, char, etc.
	hl("StorageClass", { fg = color.color_21 }) -- static, register, volatile, etc.
	hl("Structure", { fg = color.color_23 }) --  struct, union, enum, etc.
	hl("Typedef", { fg = color.color_23 }) --  A typedef
	--
	hl("Special", { fg = color.color_23 }) -- (preferred) any special symbol
	hl("SpecialChar", { fg = color.color_15 }) --  special character in a constant
	hl("Tag", { fg = color.color_22_one }) --    you can use CTRL-] on this
	hl("Delimiter", { fg = color.color_16 }) --  character that needs attention
	hl("SpecialComment", { fg = color.color_5 }) -- special things inside a comment
	hl("Debug", { fg = color.color_22_one }) --    debugging statements
	--
	hl("Underlined", { underline = true }) -- (preferred) text that stands out, HTML links
	hl("Bold", { bold = true })
	hl("Italic", { italic = true })
	-- <++

	-- ("Ignore", below, may be invisible...)
	-- Ignore         { }, -- (preferred) left blank, hidden  |hl-Ignore|

	hl("Error", { fg = color.error_red, bg = color.bg, bold = true }) -- (preferred) any erroneous construct

	hl("Todo", { fg = color.color_20, bg = color.bg, bold = true }) -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX

	-- These groups are for the native LSP client. Some other LSP clients may
	-- use these groups, or use their own. Consult your LSP client's
	-- documentation.
	-- ++>
	hl("LspReferenceText", { bg = color.color_7, bold = true }) -- used for highlighting "text" references
	hl("LspReferenceRead", { bg = color.color_7, bold = true }) -- used for highlighting "read" references
	hl("LspReferenceWrite", { bg = color.color_7, bold = true }) -- used for highlighting "write" references
	--
	hl("LspDiagnosticsDefaultError", { fg = color.error_red }) -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
	hl("LspDiagnosticsDefaultWarning", { fg = color.color_20 }) -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
	hl("LspDiagnosticsDefaultInformation", { fg = color.color_21 }) -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
	hl("LspDiagnosticsDefaultHint", { fg = color.color_14_drac }) -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
	--
	hl("LspDiagnosticsVirtualTextError", { fg = color.error_red }) -- Used for "Error" diagnostic virtual text
	hl("LspDiagnosticsVirtualTextWarning", { fg = color.color_20 }) -- Used for "Warning" diagnostic virtual text
	hl("LspDiagnosticsVirtualTextInformation", { fg = color.color_21 }) -- Used for "Information" diagnostic virtual text
	hl("LspDiagnosticsVirtualTextHint", { fg = color.color_14_drac }) -- Used for "Hint" diagnostic virtual text
	--
	hl("LspDiagnosticsUnderlineError", { underline = true }) -- Used to underline "Error" diagnostics
	hl("LspDiagnosticsUnderlineWarning", { underline = true }) -- Used to underline "Warning" diagnostics
	hl("LspDiagnosticsUnderlineInformation", { underline = true }) -- Used to underline "Information" diagnostics
	hl("LspDiagnosticsUnderlineHint", { underline = true }) -- Used to underline "Hint" diagnostics
	--
	hl("LspDiagnosticsFloatingError", { fg = color.error_red }) -- Used to color "Error" diagnostic messages in diagnostics float
	hl("LspDiagnosticsFloatingWarning", { fg = color.color_20 }) -- Used to color "Warning" diagnostic messages in diagnostics float
	hl("LspDiagnosticsFloatingInformation", { fg = color.color_21 }) -- Used to color "Information" diagnostic messages in diagnostics float
	hl("LspDiagnosticsFloatingHint", { fg = color.color_14_drac }) -- Used to color "Hint" diagnostic messages in diagnostics float
	--
	hl("LspDiagnosticsSignError", { fg = color.error_red }) -- Used for "Error" signs in sign column
	hl("LspDiagnosticsSignWarning", { fg = color.color_20 }) -- Used for "Warning" signs in sign column
	hl("LspDiagnosticsSignInformation", { fg = color.color_21 }) -- Used for "Information" signs in sign column
	hl("LspDiagnosticsSignHint", { fg = color.color_14_drac }) -- Used for "Hint" signs in sign column
	--
	-- LspCodeLens                          { }, -- Used to color the virtual text of the codelens
	--
	-- These groups are for the neovim tree-sitter highlights.
	-- As of writing, tree-sitter support is a WIP, group names may change.
	-- By default, most of these groups link to an appropriate Vim group,
	-- TSError -> Error for example, so you do not have to define these unless
	-- you explicitly want to support Treesitter's improved syntax awareness.
	--
	hl("TSAnnotation", { fg = color.color_15 }) -- For C++/Dart attributes, annotations that can be attached to the code to denote some kind of meta information.
	hl("TSAttribute", { fg = color.color_21 }) -- (unstable) TODO: docs
	hl("TSBoolean", { fg = color.color_20 }) -- For booleans.
	hl("TSCharacter", { fg = color.color_15 }) -- For characters.
	hl("TSComment", { fg = color.color_5 }) -- For comment blocks.
	hl("TSConstructor", { fg = color.color_18 }) -- For constructor calls and definitions: ` { }` in Lua, and Java constructors.
	hl("TSConditional", { fg = color.color_20 }) -- For keywords related to conditionnals.
	hl("TSConstant", { fg = color.color_17 }) -- For constants
	hl("TSConstBuiltin", { fg = color.color_18 }) -- For constant that are built in the language: `nil` in Lua.
	hl("TSConstMacro", { fg = color.color_21 }) -- For constants that are defined by macros: `NULL` in C.
	hl("TSError", { fg = color.error_red }) -- For syntax/parser errors.
	hl("TSException", { fg = color.color_20 }) -- For exception related keywords.
	hl("TSField", { fg = color.color_21 }) -- For fields.
	hl("TSFloat", { fg = color.color_20 }) -- For floats.
	hl("TSFunction", { fg = color.color_16 }) -- For function (calls and definitions).
	hl("TSFuncBuiltin", { fg = color.color_14_one }) -- For builtin functions: `table.insert` in Lua.
	hl("TSFuncMacro", { fg = color.color_27 }) -- For macro defined fuctions (calls and definitions): each `macro_rules` in Rust.
	hl("TSInclude", { fg = color.color_14_drac }) -- For includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.
	hl("TSKeyword", { fg = color.color_24 }) -- For keywords that don't fall in previous categories.
	hl("TSKeywordFunction", { fg = color.color_22_one, bold = true }) -- For keywords used to define a fuction.
	hl("TSKeywordOperator", { fg = color.color_24 }) -- For keywords used to define a fuction.
	hl("TSKeywordReturn", { fg = color.color_22_drac, bold = true }) -- For keywords used to define a fuction.
	hl("TSLabel", { fg = color.color_22_one }) -- For labels: `label:` in C and `:label:` in Lua.
	hl("TSMethod", { fg = color.color_15 }) -- For method calls and definitions.
	hl("TSNamespace", { fg = color.color_24 }) -- For identifiers referring to modules and namespaces.
	hl("TSNone", { fg = color.fg }) -- TODO: docs
	hl("TSNumber", { fg = color.color_18 }) -- For all numbers
	hl("TSOperator", { fg = color.color_27 }) -- For any operator: `+`, but also `->` and `*` in C.
	hl("TSParameter", { fg = color.color_20 }) -- For parameters of a function.
	hl("TSParameterReference", { fg = color.color_20 }) -- For references to parameters of a function.
	hl("TSProperty", { fg = color.color_29 }) -- Same as `TSField`.
	hl("TSPunctDelimiter", { fg = color.fg }) -- For delimiters ie: `.`
	hl("TSPunctBracket", { fg = color.fg }) -- For brackets and parens.
	hl("TSPunctSpecial", { fg = color.color_23 }) -- For special punctutation that does not fall in the catagories before.
	hl("TSRepeat", { fg = color.color_23 }) -- For keywords related to loops.
	hl("TSString", { fg = color.string_color }) -- For strings.
	hl("TSStringRegex", { fg = color.color_14_drac }) -- For regexes.
	hl("TSStringEscape", { fg = color.color_22_one }) -- For escape characters within a string.
	hl("TSSymbol", { fg = color.color_21 }) -- For identifiers referring to symbols or atoms.
	hl("TSType", { fg = color.color_17 }) -- For types.
	hl("TSTypeBuiltin", { fg = color.color_17 }) -- For builtin types.
	hl("TSVariable", { fg = color.fg }) -- Any variable name that does not have another highlight.
	hl("TSVariableBuiltin", { fg = color.color_23 }) -- Variable names that are defined by the languages, like `this` or `self`.
	--
	hl("TSTag", { fg = color.color_22_one }) -- Tags like html tag names.
	hl("TSTagAttribute", { fg = color.color_20 }) -- Tags like html tag names.
	hl("TSTagDelimiter", { fg = color.color_9 }) -- Tag delimiter like `<` `>` `/`
	hl("TSText", { fg = color.fg }) -- For strings considered text in a markup language.
	hl("TSEmphasis", { italic = true }) -- For text to be represented with emphasis.
	hl("TSUnderline", { underline = true }) -- For text to be represented with an underline.
	-- TSStrike             {};    -- For strikethrough text.
	hl("TSTitle", { fg = color.color_14_drac, bold = true }) -- Text that is part of a title.
	hl("TSLiteral", { fg = color.color_26 }) -- Literal text.
	hl("TSURI", { fg = color.color_28, underline = true }) -- Any URI like a link or email.
	-- <++

	--> CSS
	-- ++>
	hl("cssTsProperty", { fg = color.color_27 })
	hl("cssTsOperator", { fg = color.color_14_drac })
	-- <++

	--> (Telescope)
	-- ++>
	hl("TelescopeSelection", { bg = color.color_2, bold = true })
	hl("TelescopeSelectionCaret", { fg = color.color_20 })
	hl("TelescopeMultiSelection", { fg = color.color_8 })
	hl("TelescopeMatching", { fg = color.color_14_drac })
	hl("TelescopePromptPrefix", { fg = color.color_18 })
	hl("TelescopeBorder", { fg = color.color_3 })
	hl("TelescopePromptBorder", { fg = color.color_3 })
	hl("TelescopeResultsBorder", { fg = color.color_3 })
	hl("TelescopePreviewBorder", { fg = color.color_3 })
	hl("TelescopeTitle", { fg = color.color_23, bold = true })
	hl("TelescopePromptTitle", { fg = color.color_18, bold = true })
	hl("TelescopeResultsTitle", { fg = color.color_15, bold = true })
	hl("TelescopePreviewTitle", { fg = color.color_23, bold = true })
	-- <++

	-- (NvimTree)
	-- ++>
	hl("NvimTreeGitDirty", { fg = color.fl_color_13 })
	hl("NvimTreeGitStaged", { fg = color.fl_color_1 })
	hl("NvimTreeGitNew", { fg = color.fl_color_13 })
	hl("NvimTreeGitDeleted", { fg = color.fl_color_13 })
	hl("NvimTreeRootFolder", { fg = color.fl_color_7 })
	hl("NvimTreeIndentMarker", { fg = color.fl_color_10 })
	hl("NvimTreeSymlink", { fg = color.color_28 })
	hl("NvimTreeFolderName", { fg = color.fl_color_12 })
	hl("NvimTreeFolderIcon", { link = "NvimTreeFolderName" })
	hl("NvimTreeEmptyFolderName", { fg = color.color_25 })
	hl("NvimTreeOpenedFolderName", { link = "NvimTreeFolderName" })
	hl("NvimTreeExecFile", { fg = color.color_14_drac })
	hl("NvimtreeFileStaged", { fg = color.color_14_drac })
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
	hl("CmpItemAbbr", { fg = color.color_25 })
	hl("CmpItemAbbrDeprecated", { fg = color.color_9 })
	hl("CmpItemAbbrMatch", { fg = color.color_14_drac })
	hl("CmpItemAbbrMatchFuzzy", { fg = color.color_20 })
	hl("CmpItemMenu", { fg = color.color_8 })
	hl("CmpItemKindSnippet", { fg = color.vc_add })
	hl("CmpItemKindText", { fg = color.color_23 })
	-- CmpItemKind({ fg = color.color_22 }),
	-- <++

	--> (IndentBlankline)
	-- ++>
	hl("IndentBlanklineChar", { fg = color.color_2 })
	hl("IndentBlanklineSpaceChar", { fg = color.error_red })
	hl("IndentBlanklineSpaceCharBlankline", { fg = color.error_red })
	hl("IndentBlanklineContextChar", { fg = color.color_5 })
	hl("IndentBlanklineContextSpaceChar", { fg = color.error_red })
	hl("IndentBlanklineContextStart", { fg = color.error_red })
	-- <++
end

Theme()
