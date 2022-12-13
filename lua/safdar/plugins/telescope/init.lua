local M = {}

local ok, telescope = pcall(require, "telescope")
if not ok then
	return
end

M.telescope = function()
	local borderchars = require("safdar.core.utils").telescop_border_chars
	----------------------------------------------------------------------
	--                            Lsp Config                            --
	----------------------------------------------------------------------
	local maps = require("safdar.plugins.telescope.maps")
	telescope.setup({
		defaults = {
			-- @mappings
			mappings = maps.mappings(),
			prompt_prefix = "   ",
			selection_caret = "  ",
			entry_prefix = "  ",
			initial_mode = "insert",
			scroll_strategy = "cycle",
			selection_strategy = "reset",
			borderchars = {
				prompt = borderchars.default.prompt,
				results = borderchars.default.results,
				preview = borderchars.default.preview,
			},
			sorting_strategy = "ascending",
			layout_strategy = "horizontal",
			layout_config = {
				horizontal = {
					prompt_position = "top",
					preview_width = 0.55,
					results_width = 0.8,
				},
				vertical = {
					mirror = false,
				},
				width = 0.87,
				height = 0.90,
				preview_cutoff = 80,
			},
			-- path_display = { "shorten", shorten = 3 },
			-- path_display = { "smart" },
			file_ignore_patterns = { "^.git/", "^.obsidian/" },
		},
		pickers = {
			buffers = {
				mappings = maps.picker_find(),
			},
		},
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = false, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			},
		},
	})
end

-- @maps
require("safdar.plugins.telescope.maps").maps()

return M
