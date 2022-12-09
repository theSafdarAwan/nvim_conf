local vim = vim

-- local on_attach = require("safdar.lsp.lsp_util").on_attach
--=======================================================
--                      null-ls
--=======================================================
local null_ls = require("null-ls")
local builtins = null_ls.builtins
local sources = {
	builtins.formatting.stylua.with({
		extra_args = { "--config-path", vim.fn.expand("~/.config/stylua.toml") },
	}),
	builtins.diagnostics.luacheck,
	builtins.formatting.black.with({ extra_args = { "--fast" } }),
	builtins.diagnostics.flake8,
	builtins.diagnostics.eslint_d.with({
		condition = function(utls)
			return utls.root_has_file(".eslintrc.json")
		end,
	}),
	builtins.formatting.eslint_d,
	builtins.formatting.stylelint,
	-- builtins.diagnostics.stylelint, -- don't use this using stylelint-lsp server for diagnostics
	builtins.formatting.clang_format,
	builtins.diagnostics.chktex,
	-- builtins.code_actions.gitsigns,
	builtins.formatting.prettierd.with({
		-- { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "css", "scss", "less", "html", "json", "jsonc", "yaml", "markdown", "markdown.mdx", "graphql", "handlebars" }
		filetypes = { "html", "json", "yaml", "markdown" },
	}),
}
null_ls.setup({
	debug = true,
	sources = sources,
	-- on_attach = on_attach,
})
