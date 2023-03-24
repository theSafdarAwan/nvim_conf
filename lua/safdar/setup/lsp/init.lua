--- This Plugins module includes plugins related to Lsp(language server Protocol).

---@table Plugins
---@field nvim_lspocnfig Plugin includes configuration for lsp.
---@field null_ls_nvim Plugin lsp extension for adding formatting and diagnostics.
---@field lsp_signature_nvim Plugin shows docs for Lsp symbols.
---@field trouble_nvim Plugin shows diagnostics for the lsp in a window like vscode.
---@field lspsaga_nvim Plugin shows diagnostics messages in a file.
---@field nvim_code_action_menu Plugin code action utility for lsp.
---@field renamer_nvim Plugin renaming utility for lsp symbols.
---@field ale Plugin linting engine i am only using it for html.
---@field mason_nvim Plugin lsp binary installer.
---@field nvim_navic Plugin shows lsp symbol context in nav bar like vscode.
---@field nvim_femaco_lua Plugin adds capability to edit code in markdown code blocks with
--- lsp and completion for that code block language.

local plugins = function(install)
	local Plugins = {
		"nvim-lspconfig",
		"null-ls-nvim",
		"lsp-signature-nvim",
		"trouble-nvim",
		"lspsaga-nvim",
		"nvim-code-action-menu",
		"renamer-nvim",
		"ale",
		"mason-nvim",
		"nvim-navic",
		"nvim-femaco-lua",
	}

	for _, plugin in pairs(Plugins) do
		require("safdar.setup.lsp." .. plugin).install(install)
	end
end

return { get_plugins = plugins }
