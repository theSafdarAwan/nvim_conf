local function plugin(install)
	install({
		opt = true,
		"ThePrimeagen/vim-be-good",
		cmd = "VimBeGood",
		setup = function()
			local vim_be_good = {
				name = "vim-be-good",
				keymap = {
					keys = {
						{ "n", "<leader>gg" },
					},
				},
				on_load = {
					config = function()
						require("safdar.setup.others.vim-be-good.maps")
					end,
				},
			}
			require("lazy-loader").load(vim_be_good)
		end,
	})
end

return { install = plugin }
