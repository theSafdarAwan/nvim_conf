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
				on_load = {
					config = function()
						require("safdar.setup.others.undotree.maps")
					end,
				},
			}
			require("lazy-loader").load(undotree)
		end,
	})
end

return { install = plugin }
