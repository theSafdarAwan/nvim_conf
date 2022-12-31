local function plugin(install)
	install({
		"windwp/nvim-autopairs",
		opt = true,
		setup = function()
			local autopairs = {
				name = "nvim-autopairs",
				autocmd = {
					events = { "InsertEnter" },
				},
			}
			require("lazy-loader").load(autopairs)
		end,
		config = function()
			require("safdar.setup.completion.autopairs.config").config()
		end,
	})
end

return { install = plugin }
