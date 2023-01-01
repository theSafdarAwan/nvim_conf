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
			}
			require("lazy-loader").load(femaco)
		end,
		config = function()
			require("femaco").setup()
			require("safdar.setup.lsp.femaco.maps")
		end,
	})
end

return { install = plugin }
