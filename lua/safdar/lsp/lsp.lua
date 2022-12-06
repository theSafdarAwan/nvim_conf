local utils = require("safdar.core.utils")
local vim = utils.vim
local api = vim.api
local lsp_util = require("safdar.lsp.lsp_util")
local on_attach = lsp_util.on_attach
local capabilities = lsp_util.capabilities
-- suppress error messages from lang servers
vim.notify = function(msg, log_level, opts)
	if msg:match("exit code") then
		return
	end
	if log_level == vim.log.levels.ERROR then
		api.nvim_err_writeln(msg)
	else
		api.nvim_echo({ { msg } }, true, {})
	end
end

--|||||||||||||||||||||||||||||||||||||||||||||||||||||||
--                      lsp general
--|||||||||||||||||||||||||||||||||||||||||||||||||||||||
local nvim_lsp = require("lspconfig")

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- enable lang_servers with same configs alll in one
local servers = {
	--love
	"cssls",
	"tailwindcss",
	"tsserver",
	"emmet_ls",

	-- crush
	"rust_analyzer",
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
	})
end

--=======================================================
--     require lang modules with additional configs
--=======================================================
-- names of the files should be the name of the servers and the append _lsp at
-- the end even if the lsp names exits with the server name
local langs_conf_files = {
	"sumneko_lua_lsp",
	"jsonls_lsp",
	"clangd_lsp",
	"html_lsp",
	"stylelint_lsp_lsp",
}
for _, file in ipairs(langs_conf_files) do
	require("safdar.lsp.langs." .. file)
end

-- to change the ui
require("safdar.lsp.lsp-ui")

-- add the mappings
require("safdar.plugins.plugins_mappings.lsp_map")

--=======================================================
--     messing with the lsp servers
--=======================================================
-- NOTE: if you format the file and find some unwanted behaviour then that maybe
-- caused because of the two lsps trying to format one file. In my case the file
-- text was deleted and i couldn't figure out why.
local lsp_conf_augroup = api.nvim_create_augroup("lsp_conf", { clear = true })
-- disable the default server formatting instead use null-ls

-- copying the clients names tbl
local client_names = vim.deepcopy(servers)
-- add the langs_conf_files servers names
for _, str_key in pairs(langs_conf_files) do
	local tbl_len = #client_names
	-- trim the last _lsp part from the file name string
	local new_str = string.sub(str_key, 1, #str_key - 4)
	client_names[tbl_len + 1] = new_str
end

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
			end
		end
	end,
})
