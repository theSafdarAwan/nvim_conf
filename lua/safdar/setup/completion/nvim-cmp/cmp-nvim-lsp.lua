local config = function()
	local capabilities = require("safdar.setup.lsp.utils").capabilities
	require("cmp_nvim_lsp").default_capabilities(capabilities)
end

return { config = config }
