local plugins = function(install)
	local plugin_list = {
		"mason",
		"lspconfig",
		"null-ls",
		"lsp-signature",
		"lsp-trouble",
		"lsp-saga",
		"lsp-code-action-menu",
		"renamer",
		"navic",
		"ale",
		"femaco",
	}

	for _, plugin in pairs(plugin_list) do
		require("safdar.setup.lsp." .. plugin).install(install)
	end
end

return { get_plugins = plugins }
