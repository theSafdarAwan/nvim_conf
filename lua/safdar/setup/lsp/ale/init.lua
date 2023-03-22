local function plugin(install)
	install({
		"dense-analysis/ale",
		config = function()
			require("safdar.setup.lsp.ale.config").config()
		end,
		event = "BufReadPost",
		ft = "html",
	})
end

return { install = plugin }
