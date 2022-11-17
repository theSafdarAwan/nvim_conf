require("nvim-surround").setup({
    keymaps = {
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        normal = "ys",
        normal_cur = "ysl",
        normal_line = "ysL",
        normal_cur_line = "yss",
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
