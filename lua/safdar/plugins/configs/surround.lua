require("nvim-surround").setup({
    keymaps = {
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        normal = "S",
        normal_cur = "Sl",
        normal_line = "SL",
        normal_cur_line = "Ss",
        visual = "S",
        visual_line = "SL",
        delete = "ds",
        change = "cs",
    },
    surrounds = {
        ["("] = {
            add = { "(", ")" },
        },
        [")"] = {
            add = { "( ", " )" },
        },
        ["{"] = {
            add = { "{", "}" },
        },
        ["}"] = {
            add = { "{ ", " }" },
        },
        ["["] = {
            add = { "[", "]" },
        },
        ["]"] = {
            add = { "[ ", " ]" },
        },
    },
    aliases = {
        ["j"] = "(",
        ["k"] = "{",
        ["l"] = "[",
        ["q"] = { "\"", "'", "`" },
        ["s"] = { "{", "[", "(", "<", "\"", "'", "`", " " },
    },
    move_cursor = false,
    indent_lines = false,
})
