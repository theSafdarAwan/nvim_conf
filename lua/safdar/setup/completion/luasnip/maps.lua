local utils = require("safdar.utils")
local map = utils.set_map

local ls = require("luasnip")

-- <c-j> is my expansion key
-- this will expand the current item or jump to the next item within the snippet.
map({ "i", "s" }, "<c-j>", function()
	-- if ls.expand_or_jumpable() then
	if ls.expand_or_locally_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })

-- <c-k> is my jump backwards key.
-- this always moves to the previous item within the snippet
map({ "i", "s" }, "<c-k>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })

-- <c-l> is selecting within a list of options.
-- This is useful for choice nodes
map("i", "<c-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)

map("i", "<c-s>", require("luasnip.extras.select_choice"))
