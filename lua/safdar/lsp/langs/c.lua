local vim = vim
local nvim_lsp = require(require("genearl").lsp_loc() .. ".lsp_util").nvim_lsp
--=======================================================
--                  c lang conf
--=======================================================
nvim_lsp.clangd.setup({})
