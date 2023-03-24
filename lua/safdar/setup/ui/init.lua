--- This Plugins module includes plugins related to UI.

---@table Plugins
---@field fused string color scheme.
---@field feline string status line.
---@field nvim_web_devicons string nice icons for file types.
---@field nvim_treesitter string highlights for files.

local function plugins(install)
	local Plugins = {
		"fused",
		"feline",
		"nvim-web-devicons",
		"nvim-treesitter",
		"playground",
		"colorizer",
		"vim-illuminate",
		"indent-blank-line",
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
