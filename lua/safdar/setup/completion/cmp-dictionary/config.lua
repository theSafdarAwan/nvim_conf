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

return { config = config }
