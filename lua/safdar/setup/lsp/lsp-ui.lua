local icons = require("safdar.setup.ui.icons")

local signs = {
	Error = icons.diagnostics.BoldError,
	Warn = icons.diagnostics.BoldWarning,
	Hint = icons.diagnostics.BoldHint,
	Info = icons.diagnostics.BoldInformation,
	other = icons.misc.ModifiedCircle,
}

for sign, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. sign
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = {
		prefix = "",
		spacing = 0,
	},
	signs = true,
	underline = true,
	update_in_insert = true, -- update diagnostics insert mode
})

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
