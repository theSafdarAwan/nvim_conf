local set_map = require("safdar.utils").set_map
--- lsp hover doc scrolling
set_map({ "i", "s" }, "<C-d>", function()
	if not require("noice.lsp").scroll(3) then
		return "<C-d>"
	end
end)
set_map({ "i", "s" }, "<C-u>", function()
	if not require("noice.lsp").scroll(-4) then
		return "<C-u>"
	end
end)

set_map({ "i", "n" }, "<C-m>", ":Noice<CR>")
