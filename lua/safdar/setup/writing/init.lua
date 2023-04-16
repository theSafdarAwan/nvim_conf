---@param install function
local function plugins(install)
	local Plugins = {
		"neorg",
		"markdown-preview",
		"neogen",
		-- TODO: write treesitter queries to conceal stuff rather then this
		"tex-conceal-vim",
	}

	for _, plugin in pairs(Plugins) do
		require("safdar.setup.writing." .. plugin).install(install)
	end
end

return { get_plugins = plugins }
