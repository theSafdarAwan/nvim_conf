local utils = require("safdar.setup.lsp.utils")
local capabilities = utils.capabilities
require("lspconfig").clangd.setup({ capabilities = capabilities })
