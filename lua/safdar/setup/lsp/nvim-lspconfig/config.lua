local config = function()
	local utils = require("safdar.setup.lsp.utils")
	local on_attach = utils.on_attach
	local capabilities = utils.capabilities
	-- -- suppress error messages from lang servers
	-- vim.notify = function(msg, log_level, opts)
	-- 	if msg:match("exit code") then
	-- 		return
	-- 	end
	-- 	if log_level == vim.log.levels.ERROR then
	-- 		api.nvim_err_writeln(msg)
	-- 	else
	-- 		api.nvim_echo({ { msg } }, true, {})
	-- 	end
	-- end

	--|||||||||||||||||||||||||||||||||||||||||||||||||||||||
	--                      lsp general
	--|||||||||||||||||||||||||||||||||||||||||||||||||||||||
	local nvim_lsp = require("lspconfig")

	-- enable lang_servers with same configs alll in one
	local servers = {
		--love
		"cssls",
		"tailwindcss",
		"tsserver",
		"emmet_ls",

		-- crush
		"rust_analyzer",
		"fennel_ls",
		"gopls",
		"bashls",
		"pyright",
		"vimls",
	}
	for _, lsp in ipairs(servers) do
		nvim_lsp[lsp].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			autostart = true,
			flags = {
				debounce_text_changes = 150,
			},
			-- handlers = {
			-- 	["textDocument/formatting"] = false,
			-- 	["textDocument/rangeformatting"] = false,
			-- },
		})
	end

	--=======================================================
	--     require lang modules with additional configs
	--=======================================================
	-- names of the files should be the name of the servers and the append _lsp at
	-- the end even if the lsp names exits with the server name
	local langs_conf_files = {
    "lua_lsp",
		"jsonls_lsp",
		"ltex_lsp",
		"clangd_lsp",
		"html_lsp",
		"stylelint_lsp_lsp",
	}
	for _, lang in ipairs(langs_conf_files) do
		require("safdar.setup.lsp.nvim-lspconfig.langs." .. lang)
	end

	require("safdar.setup.lsp.lsp-ui")

	-- add the mappings
	require("safdar.setup.lsp.nvim-lspconfig.maps")

	-- now this is done in on_attach function
	--[[ --=======================================================
	--     messing with the lsp servers
	--=======================================================
	-- NOTE: if you format the file and find some unwanted behaviour then that maybe
	-- caused because of the two lsps trying to format one file. In my case the file
	-- text was deleted and i couldn't figure out why.
	local lsp_conf_augroup = api.nvim_create_augroup("lsp_conf", { clear = true })

	local lspconfig_util = require("lspconfig.util")
	local client_names = lspconfig_util.available_servers()
	-- disable the default server formatting instead use null-ls
	-- setting the formatting to false
	api.nvim_create_autocmd("LspAttach", {
	group = lsp_conf_augroup,
	callback = function(args)
	-- get client tbl
	local client = vim.lsp.get_client_by_id(args.data.client_id)

	for _, server in pairs(client_names) do
	if client.name == server then
	if client.server_capabilities.documentFormattingProvider then
	client.server_capabilities.documentFormattingProvider = false
	end
	if client.server_capabilities.documentRangeFormattingProvider then
	client.server_capabilities.documentRangeFormattingProvider = false
	end
	end
	end
	end,
	}) ]]
end

return { config = config }
