local function plugin(install)
	install({
		"nvim-neorg/neorg",
		config = function()
			require("safdar.setup.writing.neorg.config").config()
		end,
		ft = "norg",
		build = ":Neorg sync-parsers", -- This is the important bit!
	})
	install({ "nvim-neorg/neorg-telescope", ft = "norg" })
end

return { install = plugin }
