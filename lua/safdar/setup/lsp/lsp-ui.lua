local icons = require("safdar.setup.ui.icons")

local signs = {
	Error = icons.diagnostics.BoldError,
	Warn = icons.diagnostics.BoldWarning,
	Info = icons.diagnostics.BoldInformation,
	Hint = icons.diagnostics.BoldHint,
}

local sign_config_tbl = {
	text = {
		[1] = signs.Error,
		[2] = signs.Warn,
		[3] = signs.Info,
		[4] = signs.Hint,
	},
	texthl = {
		[1] = "DiagnosticError",
		[2] = "DiagnosticWarn",
		[3] = "DiagnosticInfo",
		[4] = "DiagnosticHint",
	},
	...,
}
vim.diagnostic.config({ signs = sign_config_tbl })

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
-- 	virtual_text = {
-- 		prefix = "",
-- 		spacing = 0,
-- 	},
-- 	signs = true,
-- 	underline = true,
-- 	update_in_insert = true, -- update diagnostics insert mode
-- })

-- vim.diagnostic.config({
-- 	virtual_text = {
-- 		-- source = "always",  -- Or "if_many"
-- 		prefix = "●", -- Could be '■', '▎', 'x'
-- 	},
-- 	severity_sort = true,
-- 	float = {
-- 		source = "always", -- Or "if_many"
-- 	},
-- })

--     ["bold"] = {
--       {"┏", "FloatBorder"},
--       {"─", "FloatBorder"},
--       {"┓", "FloatBorder"},
--       {"│", "FloatBorder"},
--       {"┛", "FloatBorder"},
--       {"─", "FloatBorder"},
--       {"┗", "FloatBorder"},
--       {"│", "FloatBorder"}

--       { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" },

--       { "╭", "FloatBorder" },
--       { "─", "FloatBorder" },
--       { "╮", "FloatBorder" },
--       { "│", "FloatBorder" },
--       { "╯", "FloatBorder" },
--       { "─", "FloatBorder" },
--       { "╰", "FloatBorder" },
--       { "│", "FloatBorder" },
local border = {
	{ "┌", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "┐", "FloatBorder" },
	{ "│", "FloatBorder" },
	{ "┘", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "└", "FloatBorder" },
	{ "│", "FloatBorder" },
}

-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
-- 	border = border,
-- })
vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "single",
})
