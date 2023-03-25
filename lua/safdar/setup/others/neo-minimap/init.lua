local function plugin(install)
	install({
		"ziontee113/neo-minimap",
		ft = {"html", "javascript", "go", "lua", "python", "c", "markdown", "rust" },
		config = function()
			require("safdar.setup.others.neo-minimap.config").config()
		end,
	})
end

return { install = plugin }
