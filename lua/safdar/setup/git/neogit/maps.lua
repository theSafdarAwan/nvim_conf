local M = {}

M.mappings = function()
	local map = require("safdar.utils").set_map
	map("n", "ygc", ":Neogit commit<cr>")
	map("n", "ygn", ":Neogit<cr>")
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
