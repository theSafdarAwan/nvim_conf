local map = require("core.utils").map
-- TODO create custom mappings
--> Goto Preview
map("n", "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", { noremap = true, silent = true })
map("n", "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", {
	noremap = true,
	silent = true,
})
map("n", "gpx", "<cmd>lua require('goto-preview').close_all_win()<CR>", { noremap = true, silent = true })
-- Only set if you have telescope installed
map("n", "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", { noremap = true, silent = true })
