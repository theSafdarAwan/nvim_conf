--- This modules includes plugins related to writing.

---@param install function
local function plugins(install)
	local plugin_list = {
		"neorg",
		"markdown-preview",
		"neogen",
	}

	for _, plugin in pairs(plugin_list) do
		require("safdar.setup.writing." .. plugin).install(install)
	end
end

return { get_plugins = plugins }
