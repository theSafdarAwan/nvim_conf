local plugin = function(install)
	install({
		"kyazdani42/nvim-tree.lua",
		keys = "<A-e>",
		init = function()
			local api = vim.api
			local fn = vim.fn
			local augroup = api.nvim_create_augroup("nvim-tree open on startup", { clear = true })
			api.nvim_create_autocmd({ "BufWinEnter" }, {
				group = augroup,
				callback = function()
					if #vim.bo.filetype < 1 then
						local path = fn.argv()[1]
						require("nvim-tree.api").tree.open({ path = path })
					end
					api.nvim_del_augroup_by_id(augroup)
				end,
			})
		end,
		dependencies = { "nvim-web-devicons" },
		config = function()
			require("fused").load_plugin("nvim-tree.lua")
			require("safdar.setup.navigation.nvim-tree.config").config()
		end,
	})
end

return { install = plugin }
