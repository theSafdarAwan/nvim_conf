local luasnip = require("luasnip")
local s = luasnip.snippet
local i = luasnip.insert_node
local fmt = require("luasnip.extras.fmt").fmt

-- folds
local cStyleFolds = {
	s(
		"fd",
		fmt(
			[[
        // ~> {foldBodyDes}
        {code}
        // <~]],
			{
				foldBodyDes = i(1, "fold body description"),
				code = i(2, "/* code here */"),
			}
		)
	),
}
luasnip.add_snippets("javascript", cStyleFolds)
luasnip.add_snippets("c", cStyleFolds)

-- cStyleComments
local cStyleComments = {
	s("cl", fmt([[ // {commentbody} ]], { commentbody = i(1, "comment goes here") })),
	s(
		"cb",
		fmt(
			[[
            /*
            {commentbody}
            */
            ]],
			{ commentbody = i(1, "comment goes here") }
		)
	),
}
local cStyleCommentsLangs = {
	"c",
	"norg",
	"javascript",
	"css",
}
for _, lang in ipairs(cStyleCommentsLangs) do
	luasnip.add_snippets(lang, cStyleComments)
end
