local function plugin(install)
	install({
		"danymat/neogen",
		keys = { "[n" },
		config = function()
			require("safdar.setup.writing.neogen.config").config()
			require("safdar.setup.writing.neogen.maps")
		end,
	})
end

return { install = plugin }
