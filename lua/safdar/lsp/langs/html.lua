local vim = vim
local nvim_lsp = require(require("genearl").lsp_loc() .. ".lsp_util").nvim_lsp
local on_attach = require(require("genearl").core_loc() .. ".plugins_mappings.lsp_map").on_attach
local capabilities = require(require("genearl").lsp_loc() .. ".lsp_util").capabilities

--=======================================================
--                      jsonls
--=======================================================
nvim_lsp.html.setup({
    ...,
	capabilities = capabilities,
	on_attach = on_attach,
    init_options = {
      provideFormatter = false,
    },
})
