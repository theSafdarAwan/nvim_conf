require("nvim-surround").setup({
    keymaps = {
        insert = "<C-g>s", -- to creae a pair of {},[],<>,<tag><\tag>
        insert_line = "<C-g>S",
        normal = "ys",
        normal_cur = "yss",
        normal_line = "ysS",
        normal_cur_line = "ySS",
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
