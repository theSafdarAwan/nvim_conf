require("neorg").setup({
    load = {
        ["core.defaults"] = {},
        ["core.norg.esupports.metagen"] = {
            config = {
                type = "none", -- "none", "auto" or "empty"
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
            },
        },
        ["core.norg.journal"] = {
            config = {
                workspace = "PM",
                journal_folder = "Personal-Journal",
                strategy = "nested", -- flat or nested
            },
        },
        ["core.norg.dirman"] = {
            config = {
                workspaces = {
                    PM = "~/safdar-local/NOTES/Personal\\-Management/",
                    todo = "~/safdar-local/NOTES/Personal\\-Management/TODO/",
                },
                autochdir = true, -- Automatically change the directory to the current workspace's root every time
                index = "index.norg", -- The name of the main (root) .norg file
            },
        },
        ["core.gtd.base"] = {
            config = {
                workspace = "todo",
                syntax = {
                    context = "#contexts",
                    start = "#time.start",
                    due = "#time.due",
                    waiting = "#waiting.for",
                },
                custom_tag_completion =  true,

            }
        },
        ["core.norg.manoeuvre"] = {},
        ["core.integrations.telescope"] = {},
    },
})
