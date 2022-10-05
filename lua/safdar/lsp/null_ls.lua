local vim = vim
local on_attach = require(require("genearl").lsp_loc() .. ".lsp_util").on_attach
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
    builtins.diagnostics.chktex,
	builtins.formatting.prettier_d_slim.with({
		-- filetypes = { "html", "json", "css", "scss", "less", "yaml", "markdown" },
		filetypes = { "html", "json", "yaml", "markdown" },
	}),

	-- builtins.code_actions.gitsigns,
}
null_ls.setup({
	debug = true,
	sources = sources,
	on_attach = on_attach,
})
