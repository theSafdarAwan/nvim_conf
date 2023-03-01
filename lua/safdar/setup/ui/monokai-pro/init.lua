local function plugin(install)
	install({
		"loctvl842/monokai-pro.nvim",
		config = function()
			require("monokai-pro").setup()
		end,
	})
end

return { install = plugin }
