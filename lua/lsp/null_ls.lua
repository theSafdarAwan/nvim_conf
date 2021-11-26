local vim = vim
local on_attach = require("lsp.lsp_util").on_attach
--=======================================================
--                      null-ls
--=======================================================
local null_ls = require("null-ls")
local builtins = null_ls.builtins
local sources = {
	builtins.formatting.stylua,
	builtins.diagnostics.luacheck,
	builtins.formatting.black.with({ extra_args = { "--fast" } }),
	builtins.diagnostics.flake8,
	builtins.diagnostics.eslint_d.with({
		condition = function(utils)
			return utils.root_has_file(".eslintrc.json")
		end,
	}),
	builtins.formatting.eslint_d,
	builtins.formatting.stylelint,
	builtins.formatting.clang_format,
	builtins.diagnostics.stylelint,
	-- builtins.diagnostics.htmlhint,
	builtins.formatting.prettier_d_slim.with({
		-- filetypes = { "html", "json", "css", "scss", "less", "yaml", "markdown" },
		filetypes = { "html", "json", "yaml", "markdown" },
	}),

	builtins.code_actions.gitsigns,
}
null_ls.config({
	debug = true,
	sources = sources,
})
require("lspconfig")["null-ls"].setup({ on_attach = on_attach, autostart = true })

local helpers = require("null-ls.helpers")

-- local htmlhint = helpers.make_builtin({
-- 	method = null_ls.methods.DIAGNOSTICS,
-- 	filetypes = { "html" },
-- 	generator_opts = {
-- 		command = "htmlhint",
-- 		args = { "--format", "json" },
-- 		to_stdin = true,
-- 		from_stderr = true,
-- 		format = "json",
-- 		-- on_output = function(params)
-- 		-- 	local parser = helpers.diagnostics.from_json({
-- 		-- 		attributes = {
-- 		-- 			severity = "type",
-- 		-- 			code = "source",
-- 		-- 		},
-- 		-- 		severities = {
-- 		-- 			ERROR = helpers.diagnostics.severities["error"],
-- 		-- 			WARNING = helpers.diagnostics.severities["warning"],
-- 		-- 		},
-- 		-- 	})
-- 		-- 	params.messages = params.output
-- 		-- 			and params.output.files
-- 		-- 			and params.output.files["STDIN"]
-- 		-- 			and params.output.files["STDIN"].messages
-- 		-- 		or {}
-- 		--
-- 		-- 	return parser({ output = params.messages })
-- 		-- end,
-- 		on_output = function(params)
-- 			local diagnostics = {}
-- 			local severities = { error = 1, warning = 2, suggestion = 4 }
-- 			for _, diagnostic in ipairs(params.output["stdin." .. vim.fn.fnamemodify(params.bufname, ":e")]) do
-- 				table.insert(diagnostics, {
-- 					row = diagnostic.Line,
-- 					col = diagnostic.Span[1],
-- 					end_col = diagnostic.Span[2] + 1,
-- 					code = diagnostic.Check,
-- 					message = diagnostic.Message,
-- 					severity = severities[diagnostic.Severity],
-- 				})
-- 			end
-- 			return diagnostics
-- 		end,
-- 	},
-- 	factory = helpers.generator_factory,
-- })

-- FIXME: read the htmlhint output json format and compare it to csshint or something like that and
-- figure out how to output the htmlhint json to the lsp client
-- local htmlhint = helpers.make_builtin({
-- 	method = null_ls.methods.DIAGNOSTICS,
-- 	filetypes = { "html" },
-- 	generator_opts = {
-- 		command = "htmlhint",
-- 		args = { "--format", "json" },
-- 		to_stdin = true,
-- 		from_stderr = true,
-- 		format = "json",
-- 		on_output = function(params)
-- 			local diagnostics = {}
-- 			for _, diagnostic in ipairs(params.output[1].messages) do
-- 				--[[
--                 --{
--                   col = 1,
--                   evidence = "<!--comment--><!DOCTYPE html>",
--                   line = 1,
--                   message = "Doctype must be declared first.",
--                   raw = "<!--comment-->",
--                   rule = {
--                     description = "Doctype must be declared first.",
--                     id = "doctype-first",
--                     link = "https://github.com/thedaviddias/HTMLHint/wiki/doctype-first"
--                   },
--                   type = "error"
--                 } --]]
-- 				print(vim.inspect(diagnostic))
-- 			end
-- 			return diagnostics
-- 		end,
-- 	},
-- 	factory = helpers.generator_factory,
-- })

-- return { {
--     row, -- number, optional (defaults to first line)
--     col, -- number, optional (defaults to beginning of line)
--     end_row, -- number, optional (defaults to row)
--     end_col, -- number, optional (defaults to end of line),
--     source, -- string, optional (defaults to "null-ls")
--     code, -- number, optional
--     message, -- string
--     severity, -- 1 (error), 2 (warning), 3 (information), 4 (hint)
-- } }

-- null_ls.register(htmlhint)
