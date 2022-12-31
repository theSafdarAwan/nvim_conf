local plugins = function(install)
	local plugin_list = {
		"lspconfig",
		"null-ls"
	}

	for _, plugin in pairs(plugin_list) do
		require("safdar.setup.lsp." .. plugin).install(install)
	end
end

return { get_plugins = plugins }
