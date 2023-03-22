local function plugin(install)
	install({
		"iamcco/markdown-preview.nvim",
		config = function()
			require("safdar.setup.writing.markdown-preview.config").config()
		end,
		ft = "markdown",
		keys = { "<leader>mp" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	})
end

return { install = plugin }
