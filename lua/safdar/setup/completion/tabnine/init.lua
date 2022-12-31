local function plugin(install)
	install({
		"tzachar/cmp-tabnine",
		opt = true,
		run = "./install.sh",
		setup = function()
			local tabnine = {
				name = "cmp-tabnine",
				autocmd = {
					events = "InsertEnter",
				},
			}
			require("lazy-loader").load(tabnine)
		end,
		config = function()
			require("safdar.setup.completion.tabnine.config").config()
		end,
	})
end

return { install = plugin }
