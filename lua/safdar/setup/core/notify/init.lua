local function plugin(install)
	install({
		"rcarriga/nvim-notify",
		lazy = false,
		config = function()
			require("fused").load_plugin("nvim-notify")
		end,
	})
end
return { install = plugin }
