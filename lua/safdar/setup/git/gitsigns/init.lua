local function plugin(install)
	install({
		opt = true,
		"lewis6991/gitsigns.nvim",
		setup = function()
			local gitsigns = {
				name = "gitsigns.nvim",
				on_load = {
					config = function()
						require("safdar.setup.git.gitsigns.config").config()
					end,
				},
				autocmd = {
					event = "BufRead",
					callback = function()
						-- this variable is just for my status line which changes the git
						-- git status
						vim.g.__git_is_ok = false
						-- if this commands returns true the next guard will become true and
						-- the plugin will be loaded
						vim.fn.system("git -C " .. vim.fn.expand("%:p:h") .. " rev-parse")
						if vim.v.shell_error == 0 then
							vim.g.__git_is_ok = true
							return true
						end
					end,
				},
			}
			require("lazy-loader").load(gitsigns)
		end,
	})
end

return { install = plugin }
