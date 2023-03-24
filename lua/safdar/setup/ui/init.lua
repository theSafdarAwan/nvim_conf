--- This Plugins module includes plugins related to UI.

---@table Plugins
---@field fused string color scheme.
---@field feline string status line.
---@field nvim_web_devicons string nice icons for file types.
---@field nvim_treesitter string better syntax highlights for files.
---@field nvim_colorizer_lua string colorize the colors in your editor.
---@field vim_illuminate string Highlight word under the cursor and generate movement text-objects.
---@field indent_blankline_nvim string adds context line for the indentations.

local function plugins(install)
	local Plugins = {
		"fused",
		"feline",
		"nvim-web-devicons",
		"nvim-treesitter",
		"playground",
		"nvim-colorizer-lua",
		"vim-illuminate",
		"indent-blankline-nvim",
	}

	local temp_plugins = {
		"monokai-pro",
		"themes",
	}
	for _, plugin in ipairs(temp_plugins) do
		table.insert(Plugins, plugin)
	end

	for _, plugin in pairs(Plugins) do
		require("safdar.setup.ui." .. plugin).install(install)
	end
end

return { get_plugins = plugins }
