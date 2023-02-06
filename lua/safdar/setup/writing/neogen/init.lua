local function plugin(install)
	install({
		"danymat/neogen",
		opt = true,
		setup = function()
			local lazy_load = {
				name = "neogen",
				keymap = { keys = { "n", "[n" } },
				on_load = {
					config = function()
						require("safdar.setup.writing.neogen.config").config()
						require("safdar.setup.writing.neogen.maps")
					end,
				},
			}
			require("lazy-loader").load(lazy_load)
		end,
	})
end

return { install = plugin }
