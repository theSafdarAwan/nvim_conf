require("neorg").setup({
    load = {
        ["core.defaults"] = {},
        ["core.norg.esupports.metagen"] = {
            config = {
                type = "empty", -- "none", "auto" or "empty"
                update_date = true,
            },
        },
        ["core.norg.concealer"] = {
            config = {
                icon_preset = "basic", -- diamond, varied
                -- if you want to dim code blocks
                dim_code_blocks = {
                    enabled = true,
                    content_only = true,
                    width = "content",
                    padding = {
                        left = 0,
                        right = 5,
                    },
                    conceal = false,
                },
                folds = false,
                icons = {
                    todo = {
                        on_hold = {
                            enabled = true,
                            icon = "",
                            query = "(todo_item_on_hold) @icon",
                            extract = function()
                                return 1
                            end,
                        },
                    },
                    markup = {
                        enabled = true,
                        spoiler = {
                            highlight = "TSError",
                        },
                    },
                },
            },
        },
        ["core.norg.journal"] = {
            config = {
                workspace = nil, -- TODO: add your journal workspace
                journal_folder = "Personal-Journal",
                strategy = "flat", -- flat or nested
            },
        },
        ["core.integrations.nvim-cmp"] = {},
        ["core.keybinds"] = {
            config = {
                default_keybinds = false,
            },
        },
        ["core.norg.qol.toc"] = {
            config = {
                close_split_on_jump = true,
                toc_split_placement = "right",
            }
        },
    },
})
