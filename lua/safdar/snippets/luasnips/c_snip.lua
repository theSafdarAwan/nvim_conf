local vim = vim

local ls = require("luasnip")
local s = ls.snippet
-- local sn =ls.snippet_node
-- local isn =ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
-- local c =ls.choice_node
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

local cSnips = {
	-- function
	s(
		"fn",
		fmt(
			[[
			{type} {funcName}({args}) {openingParen}
				{code}
			{closeParen}
			]],
			{
				type = i(1, "type"),
				funcName = i(2, "name"),
				args = i(3, "args"),
				code = i(4, "// code here"),
				openingParen = t("{"),
				closeParen = t("}"),
			}
		)
	),
	-- for loop
	s(
		"for",
		fmt(
			[[
			for (int {initial} = {i_num}; {statement_var} {statement_op} {statement_num}; {expr}{oper}) {l}
				{code}
			{r}]],
			{
				initial = i(1, "i"),
				i_num = i(2, "1"),
				statement_var = f(function(var_name)
					return var_name[1][1] or ""
				end, { 1 }),
				statement_op = i(3, "<="),
				statement_num = i(4, "1"),
				expr = f(function(var_name)
					return var_name[1][1] or ""
				end, { 1 }),
				oper = i(5, "++"),
				code = i(6, ""),
				l = t("{"),
				r = t("}"),
			}
		)
	),
	-- while loop
	s(
		"whi",
		fmt(
			[[
			while ({expr}) {l}
				{code}
			{r}
			]],
			{
				expr = i(1, "i <= 10"),
				code = i(2, "// code goes here"),
				l = t("{"),
				r = t("}"),
			}
		)
	),
	-- do while loop
	s(
		"dow",
		fmt(
			[[
			do {l}
				{code}
			{r} while({expr});
			]],
			{
				expr = i(1, "i <= 10"),
				code = i(2, "// code goes here"),
				l = t("{"),
				r = t("}"),
			}
		)
	),
	parse("inc", "#include <$0>"),
	parse("vr", "$1 $2 = $0;"),
	parse("pri", "printf(\"$1\\n\", $0);"),
	parse("if", "if ($1) {\n\t$0\n};"),
}

ls.add_snippets("c", cSnips)
