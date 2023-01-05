local function plugin(install)
	install({
		"tzachar/cmp-tabnine",
		opt = true,
		setup = function()
			local luasnip = {
				name = "cmp-tabnine",
				autocmd = {
					events = "InsertEnter",
				},
			}
			require("lazy-loader").load(luasnip)
		end,
		run = "./install.sh",
		config = function()
			require("safdar.setup.completion.tabnine.config").config()
		end,
	})
end

return { install = plugin }
