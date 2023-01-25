local function plugin(install)
	install({
		"windwp/nvim-autopairs",
		opt = true,
		setup = function()
			local autopairs = {
				name = "nvim-autopairs",
				on_load = {
					config = function()
						require("safdar.setup.completion.autopairs.config").config()
					end,
				},
				autocmd = {
					events = { "InsertEnter" },
				},
			}
			require("lazy-loader").load(autopairs)
		end,
	})
end

return { install = plugin }
