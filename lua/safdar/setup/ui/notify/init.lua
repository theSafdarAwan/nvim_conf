local function plugin(install)
	install({
		"rcarriga/nvim-notify",
		after = "impatient.nvim",
	})
end
return { install = plugin }
