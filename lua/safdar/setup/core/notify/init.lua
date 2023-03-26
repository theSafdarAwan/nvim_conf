local function plugin(install)
	install({
		"rcarriga/nvim-notify",
		lazy = false,
		config = function()
			vim.keymap.set(
				"n",
				"<C-l>",
				":lua require('notify').dismiss()<CR>",
				{ noremap = true, silent = true }
			)
			require("fused").load_plugin("nvim-notify")
		end,
	})
end
return { install = plugin }
