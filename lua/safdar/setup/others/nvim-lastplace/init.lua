local function plugin(install)
	install({
		"ethanholz/nvim-lastplace",
		event = "BufRead",
		config = function()
			require("nvim-lastplace").setup({
				lastplace_ignore_filetype = { "gitcommit" },
			})
		end,
	})
end

return { install = plugin }
