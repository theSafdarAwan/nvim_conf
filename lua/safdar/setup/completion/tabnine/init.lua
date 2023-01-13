local function plugin(install)
	install({
		"tzachar/cmp-tabnine",
		after = "cmp-buffer",
		run = "./install.sh",
		config = function()
			require("safdar.setup.completion.tabnine.config").config()
		end,
	})
end

return { install = plugin }
