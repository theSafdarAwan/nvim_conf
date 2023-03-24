--- This Plugins module includes plugins related to debugging.

---@table Plugins
---@field nvim_dap Plugin adds debugging capability for neovim.
---@field nvim_dap_ui Plugin Adds beautiful UI to the dap.nvim.
---@field nvim_dap_virtual_text Plugin adds virtual text for nvim.dap.

local function get_plugins(install)
	local Plugins = {
		"nvim-dap",
	}

	for _, plugin in pairs(Plugins) do
		require("safdar.setup.debugging." .. plugin).install(install)
	end
end

return { get_plugins = get_plugins }
