local lsp_util = require("safdar.lsp.lsp_util")
local capabilities = lsp_util.capabilities
require("lspconfig").clangd.setup({ capabilities = capabilities })
