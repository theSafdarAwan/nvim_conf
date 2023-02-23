local function config()
	local icons = vim.deepcopy(require("safdar.setup.ui.lspkind").icons)
	for icon_name, icon in pairs(icons) do
		icons[icon_name] = icon .. " "
	end

	require("nvim-navic").setup({
		icons = icons,
		highlight = true,
		separator = " > ",
		depth_limit = 0,
		depth_limit_indicator = "..",
		safe_output = true,
	})

	local create_autocmd = vim.api.nvim_create_autocmd
	local autocmds_augroup = vim.api.nvim_create_augroup("navic navbar config", { clear = true })

	local optl = vim.opt_local
	local function navic_navbar()
		optl.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
	end

	create_autocmd({ "LspAttach" }, {
		group = autocmds_augroup,
		callback = navic_navbar,
	})
end

return { config = config }
