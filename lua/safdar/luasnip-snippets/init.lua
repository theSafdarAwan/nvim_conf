local mods = {
    "cstyle-snip",
    "lua-snip",
    "css-snip",
    "norg-snip",
}
for _, mod in ipairs(mods) do
    require("safdar.luasnip-snippets.langs." .. mod)
end
