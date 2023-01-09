local function plugin(install)
	install({
		"rcarriga/nvim-notify",
		after = "impatient.nvim",
		setup = function ()
			require("safdar.utils").fused("notify")
		end
	})
end
return { install = plugin }
