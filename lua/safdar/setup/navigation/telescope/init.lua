local keys = require("safdar.setup.navigation.telescope.maps").keys
local plugin = function(install)
	install({
		opt = true,
		"nvim-telescope/telescope.nvim",
		keys = keys,
		setup = function()
			require("safdar.utils").fused("telescope")
		end,
		config = function()
			require("safdar.setup.navigation.telescope.config").config()
		end,
	})
	install({
		opt = true,
		after = "telescope.nvim",
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		config = function()
			require("safdar.setup.navigation.telescope.telescope-plugins").fzf()
		end,
	})
	install({
		"LukasPietzschmann/telescope-tabs",
		after = "telescope-fzf-native.nvim",
		config = function()
			require("safdar.setup.navigation.telescope.telescope-plugins").tabs()
		end,
	})
end

return { install = plugin }
