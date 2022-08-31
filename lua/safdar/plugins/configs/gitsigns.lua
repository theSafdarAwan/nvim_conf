-----------------------
--  git sigs plugin  --
-----------------------

require("gitsigns").setup {
    keymaps = {
        -- Default keymap options
        buffer = true,
        noremap = true,
        ["n ]c"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'" },
        ["n [c"] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'" },
        ["n <leader>ghs"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
        ["n <leader>ghu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
        ["n <leader>ghr"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
        ["n <leader>ghp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
        ["n <leader>gbs"] = ':Gitsigns stage_buffer<cr>',
        ["n <leader>gbr"] = ':Gitsigns reset_buffer<cr>',
    },
    numhl = false,

    sign_priority = 5,
    signs = {
        add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
        change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
        changedelete = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
        delete = { hl = "DiffDelete", text = "│", numhl = "GitSignsDeleteNr" },
        topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
    },

    status_formatter = nil, -- Use default
    watch_gitdir = {
        interval = 100,
    },
}
