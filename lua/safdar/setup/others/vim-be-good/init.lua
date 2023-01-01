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
			}
			require("lazy-loader").load(vim_be_good)
		end,
		config = function()
			require("safdar.setup.others.vim-be-good.maps")
		end,
	})
end

return { install = plugin }
