local maps = function()
	local set_map = require("safdar.utils").set_map
	set_map("n", "<leader>cl", '<cmd>lua require("nvim-comment-frame").add_comment()<cr>')
	set_map("n", "<leader>cm", '<cmd>lua require("nvim-comment-frame").add_multiline_comment()<cr>')
end

return { maps = maps }
