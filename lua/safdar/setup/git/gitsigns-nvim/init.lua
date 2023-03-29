local function plugin(install)
	install({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("safdar.setup.git.gitsigns-nvim.config").config()
		end,
		init = function()
			vim.api.nvim_create_autocmd("BufRead", {
				group = vim.api.nvim_create_augroup("lazy load gitsigns", { clear = true }),
				callback = function()
					vim.fn.system("git -C " .. vim.fn.expand("%:p:h") .. " rev-parse")
					if vim.v.shell_error == 0 then
						vim.api.nvim_del_augroup_by_name("lazy load gitsigns")
						vim.schedule(function()
							require("lazy").load({ plugins = { "gitsigns.nvim" } })
						end)
					end
				end,
			})
		end,
	})
end

return { install = plugin }
