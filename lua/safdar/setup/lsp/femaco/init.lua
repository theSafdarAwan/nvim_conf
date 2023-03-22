local function plugin(install)
	install({
		"AckslD/nvim-FeMaco.lua",
		keys = "<leader>fm",
		ft = { "md", "norg" },
		config = function()
			require("femaco").setup()
			require("safdar.setup.lsp.femaco.maps")
		end,
	})
end

return { install = plugin }
