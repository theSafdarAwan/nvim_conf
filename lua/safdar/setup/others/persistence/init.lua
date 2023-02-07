local function plugin(install)
	install({
		"folke/persistence.nvim",
		module = "persistence",
		opt = true,
		-- module = "persistence",
		setup = function()
			local persistence = {
				name = "persistence.nvim",
				autocmd = {
					events = { "BufReadPre" }, -- this will only start session saving when an actual file was opened
				},
				on_load = {
					config = function()
						require("persistence").setup()
						require("safdar.setup.others.persistence.maps")
					end,
				},
			}
			require("lazy-loader").load(persistence)
		end,
	})
end

return { install = plugin }
