local utils = require("safdar.core.utils")
local vim = utils.vim
-- =========================================================================
--                          telescope config
-- =========================================================================
local telescope = require("telescope")

local borderchars = {
    default = {
        prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        results = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    },
    dropdown = {
        prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
        results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
        preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    },
    ivy = {
        prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
        results = { " " },
        preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    },
}

telescope.setup({
    defaults = {
        mappings = require("safdar.plugins_mappings.telescope_map").mappings(),
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
telescope.load_extension("fzf")
telescope.load_extension("git_worktree")

-- =========================================================================
--                          custom
-- =========================================================================
local M = {}
local builtin = require("telescope.builtin")
local themes = require("telescope.themes")

--> Search Neorg TODO files
M.gtd_neorg_files = function()
    local find_gtd_neorg_files = themes.get_dropdown({
        prompt_title = "< GTD >",
        cwd = "~/safdar-local/NOTES/Personal\\-Management/TODO/",
        borderchars = borderchars.dropdown,
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
        borderchars = borderchars.default,
    })
end

--> current_buffer_fuzzy_find
M.current_buffer_fuzzy_find = function()
    local buffer_fuzzy_find = themes.get_dropdown({
        -- winblend = 5,
        show_line = true,
        prompt_title = "Buffer Fuzzy Find",
        results_title = "",
        borderchars = borderchars.dropdown,
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
        borderchars = borderchars.dropdown,
        hidden = true,
        previewer = false,
        layout_config = {
            width = 0.80,
            height = 0.30,
        },
        file_ignore_patterns = { ".git/", "assets/pictures" },
        path_display = function(opts, path)
            local tail = require("telescope.utils").path_tail(path)
            return string.format("%s (%s)", tail, path)
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
        borderchars = borderchars.ivy,
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
            return string.format("%s (%s)", tail, path)
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
        borderchars = borderchars.dropdown,
    })

    local opts = vim.deepcopy(center_list)
    opts.prompt_prefix = " ❯ "
    -- opts.cwd = vim.fn.stdpath("config")
    require("telescope.builtin").buffers(opts)
end

--> Search for colorschemes
M.get_cursor_change_colorscheme = function()
    local center_list = themes.get_cursor({
        prompt_title = "Change Colorscheme",
        results_title = "Available Colorschemes",
        preview_title = "Colorscheme Highlights",
        borderchars = borderchars.get_cursor,
        enable_preview = true,
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
        preview_title = "Colorscheme Highlights",
        borderchars = borderchars.ivy,
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
        borderchars = borderchars.dropdown,
    })

    local opts = vim.deepcopy(center_list)
    opts.prompt_prefix = " ❯ "
    -- opts.cwd = vim.fn.stdpath("config")
    require("telescope.builtin").lsp_document_symbols(opts)
end

return M

-- TODO:  telescope vim_options
