local plugins = function(install)
	local Plugins = {
		"nvim-lspconfig",
		"null-ls-nvim",
		"trouble-nvim",
		"lspsaga-nvim",
		"nvim-code-action-menu",
		"inc-rename-nvim",
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
