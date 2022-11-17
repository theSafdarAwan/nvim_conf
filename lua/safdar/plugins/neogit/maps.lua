local M = {}

M.mappings = function()
    local map = require("safdar.core.utils").map
    map("n", "ygc", ":Neogit commit<cr>", { noremap = true, silent = true })
    map("n", "ygo", ":Neogit<cr>", { noremap = true, silent = true })
end

M.status = { -- modify status buffer mappings
    ["<space>x"] = "Close",
    ["1"] = "Depth1",
    ["2"] = "Depth2",
    ["3"] = "Depth3",
    ["4"] = "Depth4",
    ["<TAB>"] = "Toggle",
    ["x"] = "Discard",
    ["s"] = "Stage",
    ["S"] = "StageUnstaged",
    ["<c-s>"] = "StageAll",
    ["u"] = "Unstage",
    ["U"] = "UnstageStaged",
    ["d"] = "DiffAtFile",
    ["$"] = "CommandHistory",
    ["#"] = "Console",
    ["<c-r>"] = "RefreshBuffer",
    ["o"] = "GoToFile",
    ["<c-v>"] = "VSplitOpen",
    ["<c-x>"] = "SplitOpen",
    ["<c-t>"] = "TabOpen",
    ["?"] = "HelpPopup",
    ["D"] = "DiffPopup",
    ["p"] = "PullPopup",
    ["r"] = "RebasePopup",
    ["P"] = "PushPopup",
    ["c"] = "CommitPopup",
    ["L"] = "LogPopup",
    ["Z"] = "StashPopup",
    ["b"] = "BranchPopup",
}

return M
