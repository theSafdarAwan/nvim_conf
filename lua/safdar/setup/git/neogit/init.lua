local function plugin(install)
	install({
		"TimUntersberger/neogit",
		keys = { { "n", "ygo" }, { "n", "ygc" } },
		setup = function()
			require("safdar.utils").fused("neogit")
		end,
		config = function()
			require("safdar.setup.git.neogit.config").config()
		end,
	})
end

return { install = plugin }
