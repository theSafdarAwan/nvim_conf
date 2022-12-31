local function config()
	local types = require("luasnip.util.types")
	local ls = require("luasnip")

	-- TODO: add the cool snippets from the wiki
	ls.config.set_config({
		-- This tells LuaSnip to remember to keep around the last snippet.
		-- You can jump back into it even if you move outside of the selection
		history = true,

		-- This one is cool cause if you have dynamic snippets, it updates as you type!
		updateevents = "TextChanged,TextChangedI",

		-- Autosnippets:
		enable_autosnippets = true,

		ext_opts = {
			[types.choiceNode] = {
				active = {
					virt_text = { { " « ", "@include" } },
				},
			},
			--[[ [types.insertNode] = {
            active = {
                virt_text = { { "●", "@string" } },
            },
        }, ]]
		},
	})

	-- require the vscode html tag completion
	require("luasnip/loaders/from_vscode").lazy_load()

	-- require snippets
	require("safdar.setup.completion.luasnip.snippets")

	-- require mappings
	require("safdar.setup.completion.luasnip.maps")
end

return { config = config }
