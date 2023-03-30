-- undo break points in insert mode
local utils = require("safdar.utils")
local set_map = utils.set_map

local function add_break_points(symbol)
	set_map("i", symbol, symbol .. "<C-g>u")
end

local symbols = {
	"!",
	"`",
	".",
	",",
	"=",
}

for _, symbol in ipairs(symbols) do
	add_break_points(symbol)
end
