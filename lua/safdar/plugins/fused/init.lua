-- @colors require the fused color pallete
local cp = require("fused.pallets.dark").pallete

require("fused").setup({
    flavour = "dark",
    plugins_integration = {
        -- @names of the plguins
        cmp = true,
        diffview = true,
        harpoon = true,
        indentblankline = true,
        lspsaga = true,
        neorg = true,
        nvimtree = true,
        telescope = true,
        todocomments = true,
        trouble = true,
        tsrainbow = true,
    },
    custom = {
        DamianConway = { bg = cp.cp0 },
    },
})
