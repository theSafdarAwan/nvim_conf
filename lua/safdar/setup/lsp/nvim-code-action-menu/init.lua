local function plugin(install)
	install({
		cmd = "CodeActionMenu",
		-- keys = { "<C-a>" },
		"weilbith/nvim-code-action-menu",
		config = function()
			require("safdar.setup.lsp.nvim-code-action-menu.maps")
		end,
	})
end

return { install = plugin }
