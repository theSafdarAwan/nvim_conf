local function plugins(install)
	local Plugins = {
		"nvim-ts-autotag",
		"nvim-treesitter-textobjects",
		"treesj",
		"iswap-nvim",
		"nvim-ts-context-commentstring",
		"nvim-ts-rainbow2",
	}
	for _, plugin in ipairs(Plugins) do
		require("safdar.setup.ui.nvim-treesitter.ts-plugins." .. plugin).install(install)
	end
end

return { install = plugins }
