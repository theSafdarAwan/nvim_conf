local function plugin(install)
	install({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("safdar.setup.git.gitsigns-nvim.config").config()
		end,
		init = function()
			local group = vim.api.nvim_create_augroup("lazy load gitsigns", { clear = true })
			local git_cmd = "git -C " .. vim.fn.expand("%:p:h") .. " rev-parse"
			vim.api.nvim_create_autocmd("BufRead", {
				group = group,
				callback = function()
					vim.api.nvim_create_autocmd("CursorMoved", {
						group = group,
						callback = function()
							vim.fn.system(git_cmd)
							if vim.v.shell_error == 0 then
								vim.api.nvim_del_augroup_by_id(group)
								vim.schedule(function()
									require("lazy").load({
										plugins = { "gitsigns.nvim" },
									})
								end)
							end
						end,
					})
				end,
			})
		end,
	})
end

return { install = plugin }
