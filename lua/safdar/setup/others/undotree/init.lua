local function plugin(install)
	install({
		"mbbill/undotree",
		opt = true,
		setup = function()
			local undotree = {
				name = "undotree",
				keymap = {
					keys = {
						"<leader>u",
					},
				},
			}
			require("lazy-loader").load(undotree)
		end,
		config = function()
			require("safdar.setup.others.undotree.maps")
		end,
	})
end

return { install = plugin }
