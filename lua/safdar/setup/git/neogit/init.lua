local function plugin(install)
	install({
		"TimUntersberger/neogit",
		keys = { "ygn", "ygc" },
		config = function()
			require("fused").load_plugin("neogit")
			require("safdar.setup.git.neogit.config").config()
		end,
	})
end

return { install = plugin }
