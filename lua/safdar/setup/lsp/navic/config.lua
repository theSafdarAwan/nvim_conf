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

	-- TODO: add this autocmd in on_attach function by getting the file type and
	-- setting this for that file type
	local optl = vim.opt_local
	local function navic_navbar()
		if #vim.bo.buftype > 1 then
			optl.winbar = ""
		else
			optl.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
		end
	end

	create_autocmd({ "BufWinEnter", "BufEnter" }, {
		group = autocmds_augroup,
		callback = navic_navbar,
	})
end

return { config = config }
