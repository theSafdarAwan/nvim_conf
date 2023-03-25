local utils = require("safdar.utils")
local map = utils.set_map

local ls = require("luasnip")

-- <c-e> is my expansion key
-- this will expand the current item or jump to the next item within the snippet.
map({ "i", "s" }, "<c-e>", function()
	-- if ls.expand_or_jumpable() then
	if ls.expand_or_locally_jumpable() then
		ls.expand_or_jump()
	end
end)

-- <c-h> is my jump backwards key.
-- this always moves to the previous item within the snippet
map({ "i", "s" }, "<c-h>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end)

-- <c-l> is selecting within a list of options.
-- This is useful for choice nodes
map("i", "<c-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)

map("i", "<c-s>", require("luasnip.extras.select_choice"))
