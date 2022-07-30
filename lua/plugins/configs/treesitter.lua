local colors = require("lush_theme.dracula-pallete")
-- local colors = require("lush_theme.onedark-pallete")
-- vim.cmd [[packadd nvim-treesitter]]

require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "lua",
        "vim",
        "python",
        "typescript",
        "javascript",
        "css",
        "markdown",
        "rust",
        "go",
        "html",
        "json",
        "scss",
    },
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    },
    autotag = {
        enable = false,
    },
    rainbow = {
        enable = true,
        disable = { "html", "md" },
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        -- termcolors = {},-- table of colour name strings
        colors = {
            colors.rts_1,
            colors.rts_2,
            colors.rts_3,
            colors.rts_4,
            colors.rts_5,
        }, -- table of hex strings
    },
    context_commentstring = {
        enable = true,
    },
})
