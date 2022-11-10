local luasnip = require("luasnip")
local s = luasnip.snippet
-- local sn = luasnip.snippet_node
-- local isn = luasnip.indent_snippet_node
-- local t = luasnip.text_node
local i = luasnip.insert_node
-- local f = luasnip.function_node
-- local c = luasnip.choice_node
-- local d = luasnip.dynamic_node
-- local r = luasnip.restore_node
-- local events = require("luasnip.util.events")
-- local ai = require("luasnip.nodes.absolute_indexer")
-- local extras = require("luasnip.extras")
-- local l = extras.lambda
-- local rep = extras.rep
-- local p = extras.partial
-- local m = extras.match
-- local n = extras.nonempty
-- local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
-- local conds = require("luasnip.extras.expand_conditions")
-- local postfix = require("luasnip.extras.postfix").postfix
-- local types = require("luasnip.util.types")
-- local parse = require("luasnip.util.parser").parse_snippet

-- folds
local jsFolds = {
    s(
        "fd",
        fmt(
            [[
        // ++> {commentbody}
        // <++]],
            { commentbody = i(1, "fold body description") }
        )
    ),
}
luasnip.add_snippets("javascript", jsFolds)
luasnip.add_snippets("c", jsFolds)
local cssFolds = {
    s(
        "fd",
        fmt(
            [[
        /* ++> {commentbody}*/
        /* <++*/]],
            { commentbody = i(1, "fold body description") }
        )
    ),
}
luasnip.add_snippets("css", cssFolds)
local luaFolds = {
    s(
        "fd",
        fmt(
            [[
        -- ++> {commentbody}
        -- <++]],
            { commentbody = i(1, "fold body description") }
        )
    ),
}
luasnip.add_snippets("lua", luaFolds)

-- cStyleComments
local cStyleComments = {
    s(
        "cl",
        fmt([[ // {commentbody} ]], { commentbody = i(1, "comment goes here") })
    ),
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
