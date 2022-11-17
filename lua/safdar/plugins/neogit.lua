local neogit = require("neogit")
local status_maps = require("safdar.plugins.plugins_mappings.neogit_map").status
require("safdar.plugins.plugins_mappings.neogit_map").mappings()

neogit.setup({
    -- should the commit popup appear in insert mode or normal mode
    disable_insert_on_commit = true,
    -- The time after which an output console is shown for slow running commands
    console_timeout = 2000,
    status = {
        recent_commit_count = 5,
    },
    disable_signs = false,
    disable_hint = true,
    disable_context_highlighting = false,
    disable_commit_confirmation = false,
    -- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size.
    -- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
    auto_refresh = true,
    disable_builtin_notifications = false,
    use_magit_keybindings = false,
    -- Change the default way of opening neogit
    kind = "split",
    -- Change the default way of opening the commit popup
    commit_popup = {
        kind = "split", -- tab | split
    },
    -- Change the default way of opening popups
    popup = {
        kind = "split", -- tab | split
    },
    -- customize displayed signs
    signs = {
        -- { CLOSED, OPENED }
        section = { ">", "v" },
        item = { ">", "v" },
        hunk = { "", "" },
    },
    integrations = {
        diffview = true,
    },
    -- Setting any section to `false` will make the section not render at all
    sections = {
        untracked = {
            folded = false,
        },
        unstaged = {
            folded = false,
        },
        staged = {
            folded = true,
        },
        stashes = {
            folded = true,
        },
        unpulled = {
            folded = true,
        },
        unmerged = {
            folded = false,
        },
        recent = {
            folded = true,
        },
    },
    -- override/add mappings
    mappings = {
        status = status_maps,
    },
})

local utils = require("safdar.core.utils")
local optl = utils.optl
local api = utils.api

local function neogitUI()
    optl.statusline = " "
end

api.nvim_create_autocmd({ "FileType" }, {
    pattern = {
        "NeogitStatus",
        "NeogitPopup",
        "NeogitCommitMessage",
    },
    callback = neogitUI,
})
