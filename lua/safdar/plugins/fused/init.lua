-- @colors require the fused color pallete
local cp = require("fused.pallets.dark").pallete

require("fused").setup({
	-- flavour = "dark",
	flavour = "catppuccin",
	-- flavour = "aquarium",
	-- flavour = "onedark",
	plugins_integration = {},
	custom = {
		DamianConway = { bg = cp.cp0 },
	},
})
