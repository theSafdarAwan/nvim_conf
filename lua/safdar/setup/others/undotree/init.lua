local function plugin(install)
	install({
		"mbbill/undotree",
		keys = {
			"<leader>u",
		},
		config = function()
			require("safdar.setup.others.undotree.maps")
		end,
	})
end

return { install = plugin }
