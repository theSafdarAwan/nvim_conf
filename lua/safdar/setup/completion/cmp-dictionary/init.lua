local function plugin(install)
	install({
		opt = true,
		"uga-rosa/cmp-dictionary",
		-- event = "InsertEnter",
		-- ft = { "markdown", "norg", "html" },
		setup = function()
			local cmp_dictionary = {
				name = "cmp-dictionary",
				autocmd = {
					ft_ext = { "md", "html", "norg" },
					events = "CursorMoved",
				},
			}
			require("lazy-loader").load(cmp_dictionary)
		end,
		config = function()
			require("safdar.setup.completion.cmp-dictionary.config").config()
		end,
	})
end

return { install = plugin }
