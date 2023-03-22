local function plugin(install)
	install({
		"TimUntersberger/neogit",
		keys = { "ygn", "ygc" },
		config = function()
			require("safdar.utils").fused("neogit")
			require("safdar.setup.git.neogit.config").config()
		end,
	})
end

return { install = plugin }
