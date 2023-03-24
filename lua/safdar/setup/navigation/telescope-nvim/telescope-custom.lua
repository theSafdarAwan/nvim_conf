local M = {}

local builtin = require("telescope.builtin")
local themes = require("telescope.themes")
local borders = require("safdar.setup.navigation.telescope-nvim.utils").borders

----------------------------------------------------------------------
--                     Telescope Custom Pickers                     --
----------------------------------------------------------------------

-- trim the long path names will show maximum of 2 parent directories
local path_style = function(tail, path_str)
	local split_path = vim.split(path_str, "/", { plain = false, trimempty = true })
	local path_len = #split_path
	local path
	if path_len == 2 then
		-- will show only one because the second would be the root
		-- directory name like nvim/init.lua to just init.lua
		path = tostring(split_path[path_len - 1]) .. "/" .. tail
	elseif path_len > 2 then
		-- show 2 directories if has more than 2
		path = tostring(split_path[path_len - 2]) .. "/" .. tostring(split_path[path_len - 1]) .. "/" .. tail
	end

	return string.format("%s", path or tail)
end

--> Search Neorg TODO files
M.gtd_neorg_files = function()
	local find_gtd_neorg_files = themes.get_dropdown({
		prompt_title = "❮ GTD ❯",
		cwd = "~/safdar-local/NOTES/Personal\\-Management/TODO/",
		borderchars = borders.dropdown,
		previewer = false,
		layout_config = {
			height = 0.50,
			width = 0.60,
			cursor = {},
		},
	})

	local opts = vim.deepcopy(find_gtd_neorg_files)
	opts.prompt_prefix = " ❯ "
	require("telescope.builtin").fd(opts)
end

--> search_nvim_dotfiles
M.search_nvim_dotfiles = function()
	builtin.find_files({
		prompt_title = "Nvim Conf",
		cwd = "~/.config/nvim",
		borderchars = borders.default,
	})
end

--> current_buffer_fuzzy_find
M.current_buffer_fuzzy_find = function()
	local buffer_fuzzy_find = themes.get_dropdown({
		-- winblend = 5,
		show_line = true,
		prompt_title = "Buffer Fuzzy Find",
		results_title = "",
		borderchars = borders.dropdown,
		layout_config = {
			width = 0.80,
			height = 0.40,
		},
	})

	local opts = vim.deepcopy(buffer_fuzzy_find)
	opts.prompt_prefix = " ❯ "
	-- opts.cwd = vim.fn.stdpath("config")
	require("telescope.builtin").current_buffer_fuzzy_find(opts)
end

--> find_files
M.center_list_find_files = function()
	local center_list = themes.get_cursor({
		-- winblend = 20,
		show_line = true,
		prompt_title = "Find",
		results_title = "Available Files",
		borderchars = borders.dropdown,
		hidden = true,
		previewer = false,
		layout_config = {
			width = 0.50,
			height = 0.22,
		},
		file_ignore_patterns = { "^.git/", "^assets/pictures" },
		path_display = function(opts, path)
			local tail = require("telescope.utils").path_tail(path)
			return path_style(tail, path)
		end,
	})

	local opts = vim.deepcopy(center_list)
	require("telescope.builtin").fd(opts)
end

--> ivy_find_files_with_preview
M.ivy_find_files_with_preview = function()
	local dropdown = themes.get_ivy({
		-- winblend = 5,
		show_line = true,
		prompt_title = "Find",
		results_title = "Available Files",
		borderchars = borders.ivy,
		hidden = false,
		layout_config = {
			horizontal = {
				results_width = 0.2,
			},
			width = 0.57,
			height = 0.65,
		},
		path_display = function(opts, path)
			local tail = require("telescope.utils").path_tail(path)
			return path_style(tail, path)
		end,
	})

	local opts = vim.deepcopy(dropdown)
	require("telescope.builtin").fd(opts)
end

--> Search for buffers
M.center_list_buffers_find = function()
	local center_list = themes.get_dropdown({
		prompt_title = "Search Buffer",
		results_title = "Available Buffers",
		preview_title = "Buffer Content",
		sort_lastused = true,
		sort_mru = true,
		layout_config = {
			width = 0.70,
			height = 0.25,
		},
		borderchars = borders.dropdown,
		path_display = function(opts, path)
			local tail = require("telescope.utils").path_tail(path)
			return path_style(tail, path)
		end,
	})

	local opts = vim.deepcopy(center_list)
	opts.prompt_prefix = " ❯ "
	-- opts.cwd = vim.fn.stdpath("config")
	require("telescope.builtin").buffers(opts)
end

--> Search for colorschemes
M.get_cursor_change_colorscheme = function()
	local center_list = themes.get_cursor({
		prompt_prefix = " ",
		prompt_title = "Colorschemes",
		borderchars = borders.get_cursor,
		enable_preview = false,
		layout_config = {
			width = 0.30,
			height = 0.25,
		},
	})

	local opts = vim.deepcopy(center_list)
	-- opts.cwd = vim.fn.stdpath("config")
	require("telescope.builtin").colorscheme(opts)
end

--> Search for colorschemes
M.ivy_colorscheme_preview = function()
	local center_list = themes.get_ivy({
		prompt_title = "Search Colorscheme",
		results_title = "Available Colorschemes",
		preview_title = "Live Preview",
		borderchars = borders.ivy,
		enable_preview = true,
	})

	local opts = vim.deepcopy(center_list)
	-- opts.cwd = vim.fn.stdpath("config")
	require("telescope.builtin").colorscheme(opts)
end

--> Search for lsp_document_symbols
M.center_list_document_symbols_find = function()
	local center_list = themes.get_dropdown({
		prompt_title = "Document Symbols",
		results_title = "Available Symbols",
		preview_title = "Symbol Preview",
		sort_lastused = true,
		sort_mru = true,
		layout_config = {
			width = 0.70,
			height = 0.25,
		},
		borderchars = borders.dropdown,
	})

	local opts = vim.deepcopy(center_list)
	opts.prompt_prefix = " ❯ "
	-- opts.cwd = vim.fn.stdpath("config")
	require("telescope.builtin").lsp_document_symbols(opts)
end

return M
