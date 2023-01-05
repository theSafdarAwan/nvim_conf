local function plugin(install)
	install({
		"andymass/vim-matchup",
		setup = function()
			local vm = {
				name = "vim-matchup",
				autocmd = {
					event = "BufEnter",
				},
			}
			require("lazy-loader").load(vm)
		end,
		config = function()
			require("safdar.setup.others.vim-matchup.config").config()
		end,
	})
end

return { install = plugin }
