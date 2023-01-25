local function plugin(install)
	install({
		opt = true,
		"AckslD/nvim-FeMaco.lua",
		setup = function()
			local femaco = {
				name = "nvim-FeMaco.lua",
				autocmd = {
					ft_ext = { "md", "norg" },
				},
				on_load = {
					config = function()
						require("femaco").setup()
						require("safdar.setup.lsp.femaco.maps")
					end,
				},
			}
			require("lazy-loader").load(femaco)
		end,
	})
end

return { install = plugin }
