local function plugin(install)
	install({
		"HiPhish/nvim-ts-rainbow2",
		event = "BufRead",
		init = function()
			require("fused").load_plugin("nvim-ts-rainbow2")
		end,
	})
end
return { install = plugin }
