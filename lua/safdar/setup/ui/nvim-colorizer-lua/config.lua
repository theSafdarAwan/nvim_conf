local function config()
	-- Use the `default_options` as the second parameter, which uses
	-- `foreground` for every mode. This is the inverse of the previous
	-- setup configuration.
	require("colorizer").setup({
		filetypes = {
			"*", -- Highlight all files, but customize some others.
			css = {
				css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				-- RGB = true, -- #000 hex codes
				-- RRGGBB = true, -- #RRGGBB hex codes
				-- names = true, -- "Name" codes like Blue
				-- RRGGBBAA = true, -- #RRGGBBAA hex codes
				-- rgb_fn = true, -- CSS rgb(1,3,101) and rgba() functions
				-- hsl_fn = true, -- CSS hsl() and hsla() functions
				-- css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
			}, -- Enable parsing rgb(...) functions in css.
			html = { names = false }, -- Disable parsing "names" like Blue or Gray
			cmp_docs = { always_update = true },
			"!prompt",
			"!popup",
		},
	})
end

return { config = config }
