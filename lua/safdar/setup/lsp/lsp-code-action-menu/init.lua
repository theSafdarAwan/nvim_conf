local function plugin(install)
	install({
		cmd = "CodeActionMenu",
		keys = {
			{ "n", "<C-a>" },
		},
		"weilbith/nvim-code-action-menu",
		config = function()
			require("safdar.setup.lsp.lsp-code-action-menu.maps")
		end,
	})
end

return { install = plugin }
