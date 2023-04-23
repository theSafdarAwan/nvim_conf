local function config()
	local color_settings = {
		filetypes = {
			"*",
			css = {
				-- css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				-- RGB = true, -- #000 hex codes
				-- RRGGBB = true, -- #RRGGBB hex codes
				-- names = true, -- "Name" codes like Blue
				-- RRGGBBAA = true, -- #RRGGBBAA hex codes
				-- rgb_fn = true, -- CSS rgb(1,3,101) and rgba() functions
				-- hsl_fn = true, -- CSS hsl() and hsla() functions
				-- css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
				names = true, -- "Name" codes like Blue or blue
			},
			cmp_docs = {
				always_update = true,
				names = true,
			},
		},
		user_default_options = {
			css = true,
			names = false,
			-- tailwind = true, -- Enable tailwind colors
		},
	}
	-- Use the `default_options` as the second parameter, which uses
	-- `foreground` for every mode. This is the inverse of the previous
	-- setup configuration.
	require("colorizer").setup(color_settings)
	vim.api.nvim_create_autocmd({ "BufWinEnter", "BufNew", "BufRead" }, {
		group = vim.api.nvim_create_augroup("attaching nvim-colorizer.lua", { clear = true }),
		command = "ColorizerAttachToBuffer",
	})
end

return { config = config }
