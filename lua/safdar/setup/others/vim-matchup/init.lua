local function plugin(install)
	install({
		"andymass/vim-matchup",
		setup = function()
			local vm = {
				name = "vim-matchup",
				autocmd = {
					event = "BufEnter",
				},
				on_load = {
					config = function()
						require("safdar.setup.others.vim-matchup.config").config()
					end,
				},
			}
			require("lazy-loader").load(vm)
		end,
	})
end

return { install = plugin }
