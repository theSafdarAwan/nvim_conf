local function config()
	local nm = require("neo-minimap")

	local winwidth = math.floor(vim.o.columns * 0.75)
	nm.setup_defaults({
		width = winwidth,
		height_toggle = { 12, 36, 48 },
		hl_group = "LineNr",
		open_win_opts = { border = "single" },
		disable_indentation = true,
		win_opts = {
			winhl = "NormalFloat:NormalFloat",
			scrolloff = 2,
			conceallevel = 0,
			concealcursor = "n",
			cursorline = true,
		},
	})
	----------------------------------------------------------------------
	--                               HTML                               --
	----------------------------------------------------------------------
	nm.set({ "zi", "zo" }, "html", {
		query = {
			"",
			"",
		},
		regex = {
			{ "<h[1-7]" },
			{ "<footer>", "<header>", "<section>" },
		},
	})
	----------------------------------------------------------------------
	--                               HTML                               --
	----------------------------------------------------------------------
	nm.set({ "zi", "zo" }, "css", {
		query = {
			[[
				;; query
				((id_selector) @cap)
				((media_statement) @cap)
			]],
			[[
				;; query
				((tag_name) @cap)
				((class_selector) @cap)
			]],
		},
	})
	----------------------------------------------------------------------
	--                            Javascript                            --
	----------------------------------------------------------------------
	nm.set({ "zi", "zo" }, "javascript", {
		query = {
			[[
				;; query for functions/if_statement/class_declaration
				((function_declaration) @cap)
				((if_statement) @cap)
				((class_declaration) @cap)
			]],
			[[
				;; query for comments/expressions which includes function calls
				((comment) @cap)
				((expression_statement) @cap)
			]],
		},
	})

	----------------------------------------------------------------------
	--                               Lua                                --
	----------------------------------------------------------------------
	nm.set({ "zi", "zo", "zu" }, "lua", {
		query = {
			[[
				;; query for functions[declaration|definition]/guard
				 ((function_declaration) @cap)
				 ((function_definition) @cap)
				 ((if_statement) @cap)
			]],
			[[
				;; query
				((identifier) @cap (#eq? @cap "{cursorword}"))
			]],
			[[
				;; query
				((for_statement) @cap)
				((assignment_statement(expression_list((function_definition) @cap))))
				((function_call (identifier)) @cap (#vim-match? @cap "^__*" ))
				((function_call (dot_index_expression) @field (#eq? @field "vim.keymap.set")) @cap)
			]],
		},

		regex = {
			{},
			{ [[^\s*---*\s\+\w\+]], [[--\s*=]] },
			{ [[^\s*---*\s\+\w\+]], [[--\s*=]] },
			{},
		},

		search_patterns = {
			{ "function", "<C-j>", true },
			{ "function", "<C-k>", false },
			{ "keymap", "<A-j>", true },
			{ "keymap", "<A-k>", false },
		},
	})

	----------------------------------------------------------------------
	--                              c/cpp                               --
	----------------------------------------------------------------------
	nm.set({ "zi", "zo", "zu" }, { "c", "cpp" }, {
		query = {
			[[
				;; query for functions/function declarations
				((function_definition) @cap)
				(declaration declarator: (function_declarator)) @cap
			]],
			[[
				;; query
				((identifier) @cap (#eq? @cap "{cursorword}"))
			]],
			[[
				;; query for structs /classes
				((struct_specifier) @cap)
				((class_specifier) @cap)
			]],
			[[
				;; query for function calls
				(call_expression function: (identifier) @cap)
			]],
		},

		search_patterns = {
			{ "void", "<C-j>", true },
			{ "void", "<C-k>", false },
			-- {"keymap", "<A-j>", true}, {"keymap", "<A-k>", false}
		},
	})

	----------------------------------------------------------------------
	--                                Go                                --
	----------------------------------------------------------------------
	nm.set({ "zi", "zo", "zu" }, "go", {
		query = {
			[[
				;; query
				((method_declaration) @cap)
				((function_declaration) @cap)
				(call_expression function: (func_literal) @cap)
				;;(method_declaration name: (field_identifier) @name (#eq? @name "{cursorword}")) @cap
			]],
			[[
				;; query
				((identifier) @cap (#eq? @cap "{cursorword}"))
			]],
			[[
				;; query for structs
				(type_declaration (type_spec name: (type_identifier) @cap type: (struct_type))) 
			]],
			[[
				;; query for function calls
				(call_expression function: (selector_expression) @cap)
			]],
		},

		search_patterns = {
			{ "func", "<C-j>", true },
			{ "func", "<C-k>", false },
		},
	})

	----------------------------------------------------------------------
	--                               Make                               --
	----------------------------------------------------------------------
	nm.set({ "zi", "zo" }, "make", {
		query = {
			[[
				;; query
				(rule (targets (word) @cap))
			]],
			[[
				;; query
				(rule (targets (word) @cap) (#eq? @cap "{cursorword}"))
			]],
		},

		search_patterns = {
			{ "fn", "<C-j>", true },
			{ "fn", "<C-k>", false },
		},

		-- auto_jump = false,

		-- disable_indentation = true
	})

	----------------------------------------------------------------------
	--                               Yaml                               --
	----------------------------------------------------------------------
	nm.set({ "zi", "zo", "zu" }, { "docker-compose*.yml" }, {
		events = { "BufEnter" },

		query = {
			[[
				;; query for finding names of containers
				(
					block_mapping (
						block_mapping_pair
							key: ( flow_node( plain_scalar(string_scalar)))
							value: (block_node(
								block_mapping (
									block_mapping_pair
										key: ( flow_node( plain_scalar(string_scalar) @cap (#not-eq? @cap "build") ))
										value: (block_node(
											block_mapping(block_mapping_pair key: ( flow_node( plain_scalar(string_scalar))))
										)
									)
								)
							)
						)
					)
				)
			]],
			[[
				;; query for functions/function declarations
				((comment) @cap)
			]],
			1,
		},

		-- auto_jump = false,

		disable_indentation = true,
	})

	----------------------------------------------------------------------
	--                             Markdown                             --
	----------------------------------------------------------------------
	nm.set({ "zi", "zo", "zu" }, { "markdown" }, {
		query = {
			[[
				;; query for functions/function declarations
				((atx_heading) @cap)
			]],
			[[
				;; query for functions/function declarations
				((fenced_code_block) @cap)
			]],
			1,
		},

		-- auto_jump = false,

		disable_indentation = true,
	})

	----------------------------------------------------------------------
	--                              Python                              --
	----------------------------------------------------------------------
	nm.set({ "zi", "zo", "zu" }, { "python" }, {
		query = {
			[[
				;; query for functions/function declarations
				((function_definition) @cap)
			]],
			[[
				;; query for comments
				((identifier) @cap (#eq? @cap "{cursorword}"))
			]],
			[[
				;; query for structs /classes
				((class_definition) @cap)
			]],
			[[
				;; query for function calls
				(call function: (identifier) @cap)
			]],
		},
	})

	----------------------------------------------------------------------
	--                               Rust                               --
	----------------------------------------------------------------------
	nm.set({ "zi", "zo" }, "rust", {
		query = {
			[[
				;; query
				 ((function_item) @cap)
			]],
			[[
				;; query
				((identifier) @cap (#eq? @cap "{cursorword}"))
			]],
		},

		search_patterns = {
			{ "fn", "<C-j>", true },
			{ "fn", "<C-k>", false },
		},
	})
end

return { config = config }
