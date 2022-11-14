local vim = vim

local ls = require("luasnip")
local s = ls.snippet
-- local sn =ls.snippet_node
-- local isn =ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
-- local d =ls.dynamic_node
-- local r =ls.restore_node
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
local parse = require("luasnip.util.parser").parse_snippet

local luaSnips = {
    -- folds
    s(
        "fd",
        fmt(
            [[
        -- ++> {foldBodyDesc}
        {code}
        -- <++]],
            {
                foldBodyDesc = i(1, "fold body description"),
                code = i(2, "-- code here"),
            }
        )
    ),
    -- comments
    s("cl", t("-- ")),
    s(
        "cb",
        fmt("--[[\n{comment}\n--]]", {
            comment = i(1, "-- comment here"),
        })
    ),
    -- local require
    s(
        "lreq",
        fmt([[local {} = require("{}")]], {
            f(function(import_name)
                local parts = vim.split(import_name[1][1], ".", true)
                return parts[#parts] or ""
            end, { 1 }),
            i(1),
        })
    ),
    -- require("")
    parse("req", "require(\"$0\")"),
    -- global function
    parse("gfn", "function $1($2)\n\t$0\nend"),
    -- local function
    parse("lfn", "local function $1($2)\n\t$0\nend"),
    -- local variable function
    parse("lvfn", "local $1 = function($2)\n\t$0\nend"),
    -- module function
    parse("mfn", "M.$1 = function($2)\n\t$0\nend"),
    -- global function
    parse("gfn", "$1 = function($2)\n\t$0\nend"),
    s(
        "trig",
        c(1, {
            t("Ugh boring, a text node"),
            i(1, "At least I can edit something now..."),
            f(function(args)
                return "Still only counts as text!!"
            end, {}),
        }, {})
    ),
}

ls.add_snippets("lua", luaSnips)
