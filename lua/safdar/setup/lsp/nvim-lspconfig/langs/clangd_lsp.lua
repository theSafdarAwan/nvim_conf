local utils = require("safdar.setup.lsp.utils")
local capabilities = utils.capabilities
local on_attach = utils.on_attach
require("lspconfig").clangd.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
