local function plugin(install)
	install({
		"ziontee113/neo-minimap",
		ft = { "html", "css", "javascript", "go", "lua", "python", "c", "markdown", "rust" },
		config = function()
			require("safdar.setup.others.neo-minimap.config").config()
			require("fused").load_plugin("neo-minimap")
		end,
	})
end

return { install = plugin }
