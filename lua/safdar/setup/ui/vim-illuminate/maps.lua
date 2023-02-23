local set_map = require("safdar.utils").set_map
local map_opts = require("safdar.utils").map_options
set_map(
	"n",
	"<leader>in",
	"<cmd>lua require('illuminate').goto_next_reference(false)<CR>",
	map_opts:new():silent():noremap():desc("Illuminate: go to next reference")
)
set_map(
	"n",
	"<leader>ip",
	"<cmd>lua require('illuminate').goto_prev_reference(false)<CR>",
	map_opts:new():silent():noremap():desc("Illuminate: go to previous reference")
)
