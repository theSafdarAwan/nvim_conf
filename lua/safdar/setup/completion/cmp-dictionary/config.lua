local function config()
	local cms_words = "/home/safdar/Dotfiles/monkeytype/cmw/"
	local en1k = "/home/safdar/Dotfiles/monkeytype/en-1k/"
	local en5k = "/home/safdar/Dotfiles/monkeytype/en-5k/"
	local en10k = "/home/safdar/Dotfiles/monkeytype/en-10k/"

	local cms_words_items = 7
	local en1k_items = 4
	local en5k_items = 24
	local en10k_items = 49

	local dict = {}

	while en10k_items ~= 0 do
		if cms_words_items >= 1 then
			dict[#dict + 1] = cms_words .. cms_words_items .. ".txt"
			cms_words_items = cms_words_items - 1
		end

		if en1k_items >= 1 then
			dict[#dict + 1] = en1k .. en1k_items .. ".txt"
			en1k_items = en1k_items - 1
		end

		if en5k_items >= 1 then
			dict[#dict + 1] = en5k .. en5k_items .. ".txt"
			en5k_items = en5k_items - 1
		end

		if en10k_items >= 1 then
			dict[#dict + 1] = en10k .. en10k_items .. ".txt"
			en10k_items = en10k_items - 1
		end
	end

	require("cmp_dictionary").setup({
		dic = {
			["*"] = dict,
		},
	})
end

local dict_source_autocmd = function()
	local api = vim.api
	local cmp = require("cmp")
	-- the reason i use file extension rather then file types is that
	-- file types like norg won't have filetype set if the plugin for norg
	-- isn't loaded. Which sets the filetype.
	local ft_extensions = {
		["html"] = "html",
		["norg"] = "norg",
		["md"] = "md",
	}
	local dictionary_source = { name = "dictionary", keyword_length = 2, max_item_count = 4 }
	-- NOTE: you have to re-enter or execute ":e" in command mode the buffer for this
	-- first time to load this plugin source i have no idea why it doesn't loads but 
	-- after loading for the first time then it works perfectly
	api.nvim_create_autocmd({ "InsertEnter" }, {
		group = api.nvim_create_augroup("cmp-dictionary source autocmd", { clear = true }),
		-- This function will remove the cmp-dictionary from source list of cmp if file
		-- extension is not not listed in the ft_extensions list
		callback = function()
			local sources = cmp.get_config().sources
			if not ft_extensions[vim.fn.expand("%:e")] then
				for i = #sources, 1, -1 do
					if sources[i].name == "dictionary" then
						table.remove(sources, i)
						break
					end
				end
				cmp.setup.buffer({ sources = sources })
			else
				-- guard for adding multiple sources
				for _, s in pairs(sources) do
					if s.name == "dictionary" then
						return
					end
				end
				table.insert(sources, dictionary_source)
				cmp.setup.buffer({ sources = sources })
			end
		end,
	})
end

return { config = config, dict_source_autocmd = dict_source_autocmd }
