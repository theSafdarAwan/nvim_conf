-----------------------
--  git sigs plugin  --
-----------------------
local vim = vim

require("gitsigns").setup({
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
            if vim.wo.diff then
                return "]c"
            end
            vim.schedule(function()
                gs.next_hunk()
            end)
            return "<Ignore>"
        end, { expr = true })
        map("n", "[c", function()
            if vim.wo.diff then
                return "[c"
            end
            vim.schedule(function()
                gs.prev_hunk()
            end)
            return "<Ignore>"
        end, { expr = true })

        -- Actions
        map({ "n", "v" }, "gcs", ":Gitsigns stage_hunk<CR>")
        map({ "n", "v" }, "gcr", ":Gitsigns reset_hunk<CR>")
        map("n", "gbS", gs.stage_buffer)
        map("n", "gus", gs.undo_stage_hunk)
        map("n", "gbR", gs.reset_buffer)
        map("n", "gsp", gs.preview_hunk)
        map("n", "<leader>hb", function()
            gs.blame_line({ full = true })
        end)
        map("n", "gtb", gs.toggle_current_line_blame)
        map("n", "gdt", gs.diffthis)
        map("n", "gdT", function()
            gs.diffthis("~")
        end)
        map("n", "gtd", gs.toggle_deleted)

        -- Text object
        map({ "n", "o", "x" }, "gks", ":<C-U>Gitsigns select_hunk<CR>")
    end,
    sign_priority = 5,
    signs = {
        add = { hl = "DiffAdd", text = "┃", numhl = "GitSignsAddNr" },
        change = { hl = "DiffChange", text = "┃", numhl = "GitSignsChangeNr" },
        changedelete = {
            hl = "DiffChange",
            text = "┃",
            numhl = "GitSignsChangeNr",
        },
        -- delete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
        delete = { hl = "DiffDelete", text = "━", numhl = "GitSignsDeleteNr" },
        topdelete = {
            lh = "DiffDelete",
            text = "▔",
            numhl = "GitSignsDeleteNr",
        },
    },

    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
        interval = 100,
        follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
    },
    current_line_blame_formatter = " <author> 神<author_time:%d-%m-%Y>  <summary>",
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
        -- Options passed to nvim_open_win
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
    },
    yadm = {
        enable = false,
    },
})
