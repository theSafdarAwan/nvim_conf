local function plugin(install)
	install({
		"tzachar/cmp-tabnine",
		event = "InsertEnter",
		build = "./install.sh",
		config = function()
			require("safdar.setup.completion.cmp-tabnine.config").config()
		end,
	})
end

return { install = plugin }
