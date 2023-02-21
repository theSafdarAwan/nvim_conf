local set_map = require("safdar.utils").set_map
local map_opts = require("safdar.utils").map_options
set_map(
	"n",
	"=r",
	":lua require('spectre').open()<CR>",
	map_opts:new():silent():noremap():desc("Open spectre in a new buffer")
)
set_map(
	"v",
	"=r",
	":lua require('spectre').open_visual()<CR>",
	map_opts:new():silent():noremap():desc("Open spectre in visual mode in new buffer")
)
set_map(
	"n",
	"=u",
	":lua require('spectre').open_visual({select_word=true})<CR>",
	map_opts:new():silent():noremap():desc("Open spectre with current word under cursor as pattern")
)
set_map(
	"n",
	"=f",
	":lua require('spectre').open_file_search()<CR>",
	map_opts:new():silent():noremap():desc("Open spectre with constraint to current file only")
)
