local function plugin(install)
	install({
		"rcarriga/nvim-notify",
		lazy = false,
		setup = function ()
			require("safdar.utils").fused("nvim-notify")
		end
	})
end
return { install = plugin }
