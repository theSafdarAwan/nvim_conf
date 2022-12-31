local snippets = {
	"all_snip",
	"c_snip",
	"css_snip",
	"cstyle_snip",
	"lua_snip",
	"norg_snip",
	"tex_snip",
}

for _, mod in pairs(snippets) do
	require("safdar.setup.completion.luasnip.snippets." .. mod)
end
