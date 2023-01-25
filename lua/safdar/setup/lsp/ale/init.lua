local function plugin(install)
	install({
		opt = true,
		"dense-analysis/ale",
		setup = function()
			local ale = {
				name = "ale",
				on_load = {
					config = function()
						require("safdar.setup.lsp.ale.config").config()
					end,
				},
				autocmd = {
					event = "BufReadPost",
					ft_ext = "html",
				},
			}
			require("lazy-loader").load(ale)
		end,
	})
end

return { install = plugin }
