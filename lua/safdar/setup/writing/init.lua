--- This modules includes plugins related to writing.

--- Plugins included in this module
---@table Plugins
---@field neorg Plugin neorg plugin for taking notes.
---@field markdown_preview Plugin plugin for previewing markdown.
---@field neogen Plugin is annotation toolkit for generating annotations quickly.

---@param install function
local function plugins(install)
	local Plugins = {
		"neorg",
		"markdown-preview",
		"neogen",
	}

	for _, plugin in pairs(Plugins) do
		require("safdar.setup.writing." .. plugin).install(install)
	end
end

return { get_plugins = plugins }
