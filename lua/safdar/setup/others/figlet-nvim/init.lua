local function plugin(install)
	install({
		"pavanbhat1999/figlet.nvim",
		config = function()
			require("figlet").Config({ font = "3d" })
		end,
	})
end

return { install = plugin }
