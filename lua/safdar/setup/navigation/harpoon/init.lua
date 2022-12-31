local maps = require("safdar.setup.navigation.harpoon.maps")

local function plugin(install)
	install({
		opt = true,
		keys = maps.keys,
		"ThePrimeagen/harpoon",
		setup = function()
			require("safdar.utils").fused("harpoon")
		end,
		config = function()
			require("safdar.setup.navigation.harpoon.config").config()
		end,
	})
end
return { install = plugin }
