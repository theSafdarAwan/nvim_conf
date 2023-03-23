local icons = function(install)
	install({
		"kyazdani42/nvim-web-devicons",
		lazy = false,
		init = function()
			require("safdar.utils").fused("nvim-web-devicons")
		end,
	}) -- icons for the nvim
	-- these are extracted from the nvim_chad ui plugin
	local _, devicons = pcall(require, "nvim-web-devicons")
	local custom_dev_icons = {
		default_icon = {
			icon = "",
			name = "Default",
		},

		c = {
			icon = "",
			name = "c",
		},

		css = {
			icon = "",
			name = "css",
		},

		deb = {
			icon = "",
			name = "deb",
		},

		Dockerfile = {
			icon = "",
			name = "Dockerfile",
		},

		html = {
			icon = "",
			name = "html",
		},

		jpeg = {
			icon = "",
			name = "jpeg",
		},

		jpg = {
			icon = "",
			name = "jpg",
		},

		js = {
			icon = "",
			name = "js",
		},

		kt = {
			icon = "󱈙",
			name = "kt",
		},

		lock = {
			icon = "",
			name = "lock",
		},

		lua = {
			icon = "",
			name = "lua",
		},

		mp3 = {
			icon = "",
			name = "mp3",
		},

		mp4 = {
			icon = "",
			name = "mp4",
		},

		out = {
			icon = "",
			name = "out",
		},

		png = {
			icon = "",
			name = "png",
		},

		py = {
			icon = "",
			name = "py",
		},

		["robots.txt"] = {
			icon = "ﮧ",
			name = "robots",
		},

		toml = {
			icon = "",
			name = "toml",
		},

		ts = {
			icon = "ﯤ",
			name = "ts",
		},

		ttf = {
			icon = "",
			name = "TrueTypeFont",
		},

		rb = {
			icon = "",
			name = "rb",
		},

		rpm = {
			icon = "",
			name = "rpm",
		},

		vue = {
			icon = "﵂",
			name = "vue",
		},

		woff = {
			icon = "",
			name = "WebOpenFontFormat",
		},

		woff2 = {
			icon = "",
			name = "WebOpenFontFormat2",
		},

		xz = {
			icon = "",
			name = "xz",
		},

		zip = {
			icon = "",
			name = "zip",
		},
	}

	local setup_config = {
		-- your personnal icons can go here (to override)
		-- you can specify color or cterm_color instead of specifying both of them
		-- DevIcon will be appended to `name`
		override = custom_dev_icons,
		-- globally enable different highlight colors per icon (default to true)
		-- if set to false all icons will have the default icon's color
		color_icons = true,
		-- globally enable default icons (default to false)
		-- will get overriden by `get_icons` option
		default = false,
	}
	pcall(devicons.setup, setup_config)
end

return { install = icons }
