-- undo break points
local utils = require("safdar.core.utils")
local map = utils.map
local opts = { noremap = true, silent = true }

local function addBreakPoint(symbol)
	map("i", symbol, symbol .. "<C-g>u", opts)
end

local symbols = {
	"!",
	"`",
	".",
	",",
	"=",
}

for _, symbol in ipairs(symbols) do
	addBreakPoint(symbol)
end
