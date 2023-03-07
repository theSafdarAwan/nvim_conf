local function plugin(install)
	install({
		"rcarriga/nvim-notify",
		after = "impatient.nvim",
		setup = function ()
			require("safdar.utils").fused("nvim-notify")
		end
	})
end
return { install = plugin }
