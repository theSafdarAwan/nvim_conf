local vim = vim
local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.on_attach = function(c, b)
	require("safdar.plugins.plugins_mappings.lsp_map").on_attach(c, b)
end

return M
