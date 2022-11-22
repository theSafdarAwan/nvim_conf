-- @colors require the fused color pallete
local cp = require("fused.pallets.dark").pallete

require("fused").setup({
    flavour = "dark",
    plugins_integration = {},
    custom = {
        DamianConway = { bg = cp.cp0 },
        HelpBar = { link = "Normal" },
        HelpStar = { link = "Normal" },
    },
})
