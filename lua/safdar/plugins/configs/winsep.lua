local vim = vim
local borders = { "─", "│", "┌", "┐", "└", "┘" }
require("colorful-winsep").setup({
    -- symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
    symbols = borders,
    win_opts = { style = "minimal", relative = "editor" },
    no_exec_files = {
        "packer",
        "TelescopePrompt",
        "NvimTree",
        "mason",
        "CompetiTest",
    },
    highlight = {
        guifg = vim.api.nvim_get_hl_by_name("String", true)["foreground"],
        guibg = vim.api.nvim_get_hl_by_name("Normal", true)["background"],
    },
})
