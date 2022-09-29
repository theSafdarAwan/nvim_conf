local colors = require("safdar.lush_theme.dracula-pallete")
local lush = require("lush")
-- local hsl = lush.hsl

-- LSP/Linters mistakenly show `undefined global` errors in the spec, they may
-- support an annotation like the following. Consult your server documentation.
---@diagnostic disable: undefined-global
local theme = lush(function()
	return {

        -- nvim looks
        -->>>
		Comment({ fg = colors.color_9 }), -- any comment
		ColorColumn({ bg = colors.dark_blue }), -- used for the columns set with 'colorcolumn'
		Conceal({ fg = colors.color_22 }), -- placeholder characters substituted for concealed text (see 'conceallevel')
		-- TODO:	 play with cursor colors
		Cursor({ fg = colors.color_1, bg = colors.bg }), -- character under the cursor
		lCursor({ fg = colors.color_14, bg = colors.color_5 }), -- the character under the cursor when |language-mapping| is used (see 'guicursor')
		CursorIM({ fg = colors.color_1, bg = colors.bg }), -- like Cursor, but used when in IME mode |CursorIM|
		CursorColumn({ bg = colors.color_2 }), -- Screen-column at the cursor, when 'cursorcolumn' is set.
		CursorLine({ bg = colors.color_2 }), -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
		Directory({ fg = color.color_15 }), -- directory names (and other special names in listings)
		DiffAdd({ fg = colors.vc_add, bg = colors.vc_text_bg }), -- diff mode: Added line |diff.txt|
		DiffChange({ fg = colors.vc_change, bg = colors.vc_text_bg, gui = "underline" }), -- diff mode: Changed line |diff.txt|
		DiffDelete({ fg = colors.vc_remove, bg = colors.vc_text_bg }), -- diff mode: Deleted line |diff.txt|
		-- DiffText     { }, -- diff mode: Changed text within a changed line |diff.txt|
		EndOfBuffer({ fg = colors.color_3 }), -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
		TermCursor({ fg = colors.fg, bg = colors.fg }), -- cursor in a focused terminal
		TermCursorNC({ fg = colors.fg, bg = colors.fg }), -- cursor in an unfocused terminal
		ErrorMsg({ fg = colors.error_red, bg = colors.bg, gui = "bold" }), -- error messages on the command line
		VertSplit({ fg = colors.color_13 }), -- the column separating vertically split windows
		Folded({ fg = colors.color_8, bg = colors.color_1 }), -- line used for closed folds
		FoldColumn({ fg = colors.color_8, bg = colors.color_1 }), -- 'foldcolumn'
		SignColumn({ bg = colors.bg }), -- column where |signs| are displayed
		IncSearch({ bg = colors.color_4 }), -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
		-- Substitute({ fg = colors.light_gray, bg = colors.search_orange }), -- |:substitute| replacement text highlighting
		LineNr({ fg = colors.color_8 }), -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
		CursorLineNr({ fg = colors.color_20, gui = "bold" }), -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
		MatchParen({ fg = colors.color_14, bg = colors.color_6, gui = "bold, underline" }), -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
		ModeMsg({ fg = colors.fg, bg = colors.bg }), -- 'showmode' message (e.g., "-- INSERT -- ")
		MsgArea({ fg = colors.color_5, bg = Config.transparent_background and "NONE" or colors.bg }), -- Area for messages and cmdline
		MsgSeparator({ fg = colors.fg, bg = colors.bg }), -- Separator for scrolled messages, `msgsep` flag of 'display'
		MoreMsg({ fg = colors.fg, bg = colors.bg }), -- |more-prompt|
		NonText({ fg = colors.color_9 }), -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
		Normal({ fg = colors.fg, bg = Config.transparent_background and "NONE" or colors.bg }), -- normal text
		NormalFloat({ fg = colors.string, bg = colors.bg }), -- Normal text in floating windows.
		-- NormalNC({ fg = colors.fg, bg = Config.transparent_background and "NONE" or colors.bg }), -- normal text in non-current windows
		Pmenu({ fg = colors.color_25, bg = colors.bg }), -- Popup menu: normal item.
		PmenuSel({ bg = colors.color_2 }), -- Popup menu: selected item.
		PmenuSbar({ bg = colors.color_8 }), -- Popup menu: scrollbar.
		PmenuThumb({ bg = colors.color_21 }), -- Popup menu: Thumb of the scrollbar.
		Question({ fg = colors.color_20 }), -- |hit-enter| prompt and yes/no questions
		QuickFixLine({ bg = colors.color_5 }), -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
		Search({ bg = colors.color_4 }), -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
		SpecialKey({ fg = color.color_23, gui = "bold" }), -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
		SpellBad({ fg = colors.error_red, gui = "underline" }), -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
		SpellCap({ fg = colors.color_18, gui = "underline" }), -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
		SpellLocal({ fg = colors.color_23, gui = "underline" }), -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
		SpellRare({ fg = colors.color_16, gui = "underline" }), -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
		StatusLine({ bg = colors.bg }), -- status line of current window
		StatusLineNC({ bg = colors.color_2 }), -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
		TabLine({ fg = colors.color_8, bg = colors.color_1 }), -- tab pages line, not active tab page label
		TabLineFill({ fg = colors.fg, bg = colors.color_4 }), -- tab pages line, where there are no labels
		TabLineSel({ fg = colors.fg, bg = colors.color_4 }), -- tab pages line, active tab page label
		Title({ fg = colors.color_21, style = "bold" }), -- titles for output from ":set all", ":autocmd" etc.
		Visual({ bg = colors.color_6 }), -- Visual mode selection
		VisualNOS({ bg = colors.color_3 }), -- Visual mode selection when vim is "Not Owning the Selection".
		WarningMsg({ fg = colors.error_red, bg = colors.color_5 }), -- warning messages
		Whitespace({ fg = colors.color_3 }), -- "nbsp", "space", "tab" and "trail" in 'listchars'
		WildMenu({ fg = colors.color_7, bg = colors.color_16 }), -- current match in 'wildmenu' completion
        --<<<

		-- These groups are not listed as default vim groups,
		-- but they are defacto standard group names for syntax highlighting.
		-- commented out groups should chain up to their "preferred" group by
		-- default,
		-- Uncomment and edit if you want more specific syntax highlighting.
        -->>>
		Constant({ fg = colors.color_17 }), -- (preferred) any constant
		String({ fg = colors.string }), --   a string constant: "this is a string"
		Character({ fg = colors.color_14 }), --  a character constant: 'c', '\n'
		Number({ fg = colors.color_20 }), --   a number constant: 234, 0xff
		Boolean({ fg = colors.color_20 }), --  a boolean constant: TRUE, false
		Float({ fg = colors.color_20 }), --    a floating point constant: 2.3e10
        --
		Identifier({ fg = colors.color_21 }), -- (preferred) any variable name
		Function({ fg = colors.color_14 }), -- function name (also: methods for classes)
        --
		Statement({ fg = colors.color_23 }), -- (preferred) any statement
		Conditional({ fg = colors.color_23 }), --  if, then, else, endif, switch, etc.
		Repeat({ fg = colors.color_23 }), --   for, do, while, etc.
		Label({ fg = colors.color_27 }), --    case, default, etc.
		Operator({ fg = colors.color_27 }), -- "sizeof", "+", "*", etc.
		Keyword({ fg = colors.color_24 }), --  any other keyword
		Exception({ fg = colors.color_23 }), --  try, catch, throw
        --
		PreProc({ fg = colors.color_27 }), -- (preferred) generic Preprocessor
		Include({ fg = colors.color_23 }), --  preprocessor #include
		Define({ fg = colors.color_23 }), --   preprocessor #define
		Macro({ fg = colors.color_23 }), --    same as Define
		PreCondit({ fg = colors.color_23 }), --  preprocessor #if, #else, #endif, etc.
        --
		Type({ fg = colors.color_18 }), -- (preferred) int, long, char, etc.
		StorageClass({ fg = colors.color_21 }), -- static, register, volatile, etc.
		Structure({ fg = colors.color_23 }), --  struct, union, enum, etc.
		Typedef({ fg = colors.color_23 }), --  A typedef
        --
		Special({ fg = colors.color_23 }), -- (preferred) any special symbol
		SpecialChar({ fg = colors.color_15 }), --  special character in a constant
		Tag({ fg = colors.color_22 }), --    you can use CTRL-] on this
		Delimiter({ fg = colors.color_16 }), --  character that needs attention
		SpecialComment({ fg = colors.color_5 }), -- special things inside a comment
		Debug({ fg = colors.color_22 }), --    debugging statements
        --
		Underlined({ gui = "underline" }), -- (preferred) text that stands out, HTML links
		Bold({ gui = "bold" }),
		Italic({ gui = "italic" }),
        --<<<

		-- ("Ignore", below, may be invisible...)
		-- Ignore         { }, -- (preferred) left blank, hidden  |hl-Ignore|

		Error({ fg = colors.error_red, bg = colors.bg, gui = "bold" }), -- (preferred) any erroneous construct

		Todo({ fg = colors.color_20, bg = colors.bg, gui = "bold" }), -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX

		-- These groups are for the native LSP client. Some other LSP clients may
		-- use these groups, or use their own. Consult your LSP client's
		-- documentation.
        -->>>
		LspReferenceText({ bg = colors.color_7, gui = "bold" }), -- used for highlighting "text" references
		LspReferenceRead({ bg = colors.color_7, gui = "bold" }), -- used for highlighting "read" references
		LspReferenceWrite({ bg = colors.color_7, gui = "bold" }), -- used for highlighting "write" references
        --
		LspDiagnosticsDefaultError({ fg = colors.error_red }), -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
		LspDiagnosticsDefaultWarning({ fg = colors.color_20 }), -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
		LspDiagnosticsDefaultInformation({ fg = colors.color_21 }), -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
		LspDiagnosticsDefaultHint({ fg = colors.color_14 }), -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
        --
		LspDiagnosticsVirtualTextError({ fg = colors.error_red }), -- Used for "Error" diagnostic virtual text
		LspDiagnosticsVirtualTextWarning({ fg = colors.color_20 }), -- Used for "Warning" diagnostic virtual text
		LspDiagnosticsVirtualTextInformation({ fg = colors.color_21 }), -- Used for "Information" diagnostic virtual text
		LspDiagnosticsVirtualTextHint({ fg = colors.color_14 }), -- Used for "Hint" diagnostic virtual text
        --
		LspDiagnosticsUnderlineError({ gui = "underline" }), -- Used to underline "Error" diagnostics
		LspDiagnosticsUnderlineWarning({ gui = "underline" }), -- Used to underline "Warning" diagnostics
		LspDiagnosticsUnderlineInformation({ gui = "underline" }), -- Used to underline "Information" diagnostics
		LspDiagnosticsUnderlineHint({ gui = "underline" }), -- Used to underline "Hint" diagnostics
        --
		LspDiagnosticsFloatingError({ fg = colors.error_red }), -- Used to color "Error" diagnostic messages in diagnostics float
		LspDiagnosticsFloatingWarning({ fg = colors.color_20 }), -- Used to color "Warning" diagnostic messages in diagnostics float
		LspDiagnosticsFloatingInformation({ fg = colors.color_21 }), -- Used to color "Information" diagnostic messages in diagnostics float
		LspDiagnosticsFloatingHint({ fg = colors.color_14 }), -- Used to color "Hint" diagnostic messages in diagnostics float
        --
		LspDiagnosticsSignError({ fg = colors.error_red }), -- Used for "Error" signs in sign column
		LspDiagnosticsSignWarning({ fg = colors.color_20 }), -- Used for "Warning" signs in sign column
		LspDiagnosticsSignInformation({ fg = colors.color_21 }), -- Used for "Information" signs in sign column
		LspDiagnosticsSignHint({ fg = colors.color_14 }), -- Used for "Hint" signs in sign column
        --
		-- LspCodeLens                          { }, -- Used to color the virtual text of the codelens
        --
		-- These groups are for the neovim tree-sitter highlights.
		-- As of writing, tree-sitter support is a WIP, group names may change.
		-- By default, most of these groups link to an appropriate Vim group,
		-- TSError -> Error for example, so you do not have to define these unless
		-- you explicitly want to support Treesitter's improved syntax awareness.
        --
		TSAnnotation({ fg = colors.color_15 }), -- For C++/Dart attributes, annotations that can be attached to the code to denote some kind of meta information.
		TSAttribute({ fg = colors.color_21 }), -- (unstable) TODO: docs
		TSBoolean({ fg = colors.color_20 }), -- For booleans.
		TSCharacter({ fg = colors.color_15 }), -- For characters.
		TSComment({ fg = colors.color_5 }), -- For comment blocks.
		TSConstructor({ fg = colors.color_18 }), -- For constructor calls and definitions: ` { }` in Lua, and Java constructors.
		TSConditional({ fg = colors.color_20 }), -- For keywords related to conditionnals.
		TSConstant({ fg = colors.color_17 }), -- For constants
		TSConstBuiltin({ fg = colors.color_18 }), -- For constant that are built in the language: `nil` in Lua.
		TSConstMacro({ fg = colors.color_21 }), -- For constants that are defined by macros: `NULL` in C.
		TSError({ fg = colors.error_red }), -- For syntax/parser errors.
		TSException({ fg = colors.color_20 }), -- For exception related keywords.
		TSField({ fg = colors.color_21 }), -- For fields.
		TSFloat({ fg = colors.color_20 }), -- For floats.
		TSFunction({ fg = colors.color_16 }), -- For function (calls and definitions).
		TSFuncBuiltin({ fg = colors.color_14 }), -- For builtin functions: `table.insert` in Lua.
		TSFuncMacro({ fg = colors.color_27 }), -- For macro defined fuctions (calls and definitions): each `macro_rules` in Rust.
		TSInclude({ fg = colors.color_14 }), -- For includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.
		TSKeyword({ fg = colors.color_24 }), -- For keywords that don't fall in previous categories.
		TSKeywordFunction({ fg = colors.color_22, gui = "bold" }), -- For keywords used to define a fuction.
		TSKeywordOperator({ fg = colors.color_24 }), -- For keywords used to define a fuction.
		TSKeywordReturn({ fg = colors.color_22 }), -- For keywords used to define a fuction.
		TSLabel({ fg = colors.color_22 }), -- For labels: `label:` in C and `:label:` in Lua.
		TSMethod({ fg = colors.color_15 }), -- For method calls and definitions.
		TSNamespace({ fg = colors.color_24 }), -- For identifiers referring to modules and namespaces.
		TSNone({ fg = colors.fg }), -- TODO: docs
		TSNumber({ fg = colors.color_18 }), -- For all numbers
		TSOperator({ fg = colors.color_27 }), -- For any operator: `+`, but also `->` and `*` in C.
		TSParameter({ fg = colors.color_20 }), -- For parameters of a function.
		TSParameterReference({ fg = colors.color_20 }), -- For references to parameters of a function.
		TSProperty({ fg = colors.color_29 }), -- Same as `TSField`.
		TSPunctDelimiter({ fg = colors.fg }), -- For delimiters ie: `.`
		TSPunctBracket({ fg = colors.fg }), -- For brackets and parens.
		TSPunctSpecial({ fg = colors.color_23 }), -- For special punctutation that does not fall in the catagories before.
		TSRepeat({ fg = colors.color_23 }), -- For keywords related to loops.
		TSString({ fg = colors.string }), -- For strings.
		TSStringRegex({ fg = colors.color_14 }), -- For regexes.
		TSStringEscape({ fg = colors.color_22 }), -- For escape characters within a string.
		TSSymbol({ fg = colors.color_21 }), -- For identifiers referring to symbols or atoms.
		TSType({ fg = colors.color_17 }), -- For types.
		TSTypeBuiltin({ fg = colors.color_17 }), -- For builtin types.
		TSVariable({ fg = colors.fg }), -- Any variable name that does not have another highlight.
		TSVariableBuiltin({ fg = colors.color_23 }), -- Variable names that are defined by the languages, like `this` or `self`.
        --
		TSTag({ fg = colors.color_22 }), -- Tags like html tag names.
		TSTagAttribute({ fg = colors.color_20 }), -- Tags like html tag names.
		TSTagDelimiter({ fg = colors.color_9 }), -- Tag delimiter like `<` `>` `/`
		TSText({ fg = colors.fg }), -- For strings considered text in a markup language.
		TSEmphasis({ gui = "italic" }), -- For text to be represented with emphasis.
		TSUnderline({ gui = "underline" }), -- For text to be represented with an underline.
		-- TSStrike             {};    -- For strikethrough text.
		TSTitle({ fg = colors.color_14, gui = "bold" }), -- Text that is part of a title.
		TSLiteral({ fg = colors.color_26 }), -- Literal text.
		TSURI({ fg = colors.color_28, gui = "underline" }), -- Any URI like a link or email.
-- <<<

		--> CSS
		-->>>
		cssTsProperty({ fg = colors.color_27 }),
		cssTsOperator({ fg = colors.color_14 }),
		-- <<<

		--> (Telescope)
		-->>>
		TelescopeSelection({ bg = colors.color_4, fg = colors.color_26, gui = "bold" }),
		TelescopeSelectionCaret({ fg = colors.color_20 }),
		TelescopeMultiSelection({ fg = colors.color_8 }),
		TelescopeMatching({ fg = colors.color_14 }),
		TelescopePromptPrefix({ fg = colors.color_18 }),
		TelescopeBorder({ fg = colors.color_3 }),
		TelescopePromptBorder({ fg = colors.color_3 }),
		TelescopeResultsBorder({ fg = colors.color_3 }),
		TelescopePreviewBorder({ fg = colors.color_3 }),
		TelescopeTitle({ fg = colors.color_23, gui = "bold" }),
		TelescopePromptTitle({ fg = colors.color_18, gui = "bold" }),
		TelescopeResultsTitle({ fg = colors.color_15, gui = "bold" }),
		TelescopePreviewTitle({ fg = colors.color_23, gui = "bold" }),
		-- <<<

		-- (NvimTree)
		-- >>>
		NvimTreeGitDirty({ fg = colors.fl_color_13 }),
		NvimTreeGitStaged({ fg = colors.fl_color_1 }),
		NvimTreeGitNew({ fg = colors.fl_color_13 }),
		NvimTreeGitDeleted({ fg = colors.fl_color_13 }),
		NvimTreeRootFolder({ fg = colors.fl_color_7 }),
		NvimTreeIndentMarker({ fg = colors.fl_color_10 }),
		-- NvimTreeSymlink
		-- NvimTreeFolderName
		-- NvimTreeFolderIcon
		-- NvimTreeEmptyFolderName
		-- NvimTreeOpenedFolderName
		-- NvimTreeExecFile
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
		-- NvimTreeGitMerge
		-- NvimTreeGitRenamed
		-- NvimTreeFileDirty
		-- NvimTreeFileStaged
		-- NvimTreeFileMerge
		-- NvimTreeFileRenamed
		-- NvimTreeFileNew
		-- NvimTreeFileDeleted
		--<<<

		--> TODO:(Trouble)
		-- >>>
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
		--<<<

		--> (cmp)
		-- >>>
		-- TODO: CmpItemKind%
		--> Cmp
		CmpItemAbbr({ fg = colors.color_25 }),
		CmpItemAbbrDeprecated({ fg = colors.color_9 }),
		CmpItemAbbrMatch({ fg = colors.color_14 }),
		CmpItemAbbrMatchFuzzy({ fg = colors.color_20 }),
		CmpItemMenu({ fg = colors.color_8 }),
		CmpItemKindSnippet({ fg = colors.vc_add }),
		CmpItemKindText({ fg = colors.color_23 }),
		-- CmpItemKind({ fg = colors.color_22 }),
		-- <<<

	}
end)

-- return our parsed theme for extension or use else where.
return theme

-- vi:nowrap
