require("neorg").setup({
    load = {
        ["core.defaults"] = {},
        ["core.norg.esupports.metagen"] = {
            config = {
                type = "auto",
            },
        },
        ["core.integrations.nvim-cmp"] = {},
    },
})
