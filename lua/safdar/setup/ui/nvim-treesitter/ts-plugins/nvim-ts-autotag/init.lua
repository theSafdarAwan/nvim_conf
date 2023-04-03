local function plugin(install)
	install({
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
		ft = "html",
	})
end
return { install = plugin }
