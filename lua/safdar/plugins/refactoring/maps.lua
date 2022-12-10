local map = require("safdar.core.utils").set_map
map(
	"v",
	"<Leader>re",
	[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
	{ noremap = true, silent = true, expr = false }
)
map(
	"v",
	"<Leader>rf",
	[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
	{ noremap = true, silent = true, expr = false }
)
map("v", "<Leader>rt", [[ <Esc><Cmd>lua M.refactors()<CR>]], { noremap = true, silent = true, expr = false })

map(
	"v",
	"<Leader>rp",
	[[ <Esc><Cmd>lua require('refactoring').debug.printf({below = true})<CR>]],
	{ noremap = true, silent = true, expr = false }
)
