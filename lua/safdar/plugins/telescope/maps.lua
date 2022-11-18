local map = require("safdar.core.utils").map
-- --> Telescope
map(
    "n",
    "<leader>vc",
    ":Telescope git_commits<CR>",
    { noremap = true, silent = true }
)
map(
    "n",
    "<leader>tr",
    ":Telescope resume<CR>",
    { noremap = true, silent = true }
)
map(
    "n",
    "<leader>b",
    ":Telescope git_bcommits<CR>",
    { noremap = true, silent = true }
)
map(
    "n",
    "<leader>vo",
    ":Telescope vim_options<CR>",
    { noremap = true, silent = true }
)
map("n", "<leader>vm", ":Telescope marks<CR>", { noremap = true, silent = true })
map(
    "n",
    "<leader>ch",
    ":Telescope keymaps<CR>",
    { noremap = true, silent = true }
)
map(
    "n",
    "<leader>fg",
    "<cmd>Telescope live_grep<cr>",
    { noremap = true, silent = true }
)
map(
    "n",
    "<leader>fh",
    ":Telescope help_tags<cr>",
    { noremap = true, silent = true }
)
map(
    "n",
    "<leader>fo",
    "<cmd>Telescope oldfiles<cr>",
    { noremap = true, silent = true }
)
map(
    "n",
    "<leader>tb",
    ":Telescope builtin<cr>",
    { noremap = true, silent = true }
)

map("n", "<leader>en", function()
    require("safdar.plugins.telescope").search_nvim_dotfiles()
end, { noremap = true, silent = true })

map("n", "<leader>gtd", function()
    require("safdar.plugins.telescope").gtd_neorg_files()
end, { noremap = true, silent = true })

map("n", "<leader>f;", function()
    require("safdar.plugins.telescope").ivy_find_files_with_preview()
end, { noremap = true, silent = true })

map("n", "<leader>fb", function()
    require("safdar.plugins.telescope").center_list_buffers_find()
end, { noremap = true, silent = true })

map("n", "<leader>tc", function()
    require("safdar.plugins.telescope").get_cursor_change_colorscheme()
end, { noremap = true, silent = true })

map("n", "<leader>ff", function()
    -- ":Telescope find_files theme=get_cursor previewer=false find_command=rg,--hidden,--files<CR>",
    require("safdar.plugins.telescope").center_list_find_files()
end, { noremap = true, silent = true })

map("n", "<C-_>", function()
    require("safdar.plugins.telescope").current_buffer_fuzzy_find()
end, { noremap = true, silent = true })

map("n", "<leader>ds", function()
    require("safdar.plugins.telescope").center_list_document_symbols_find()
end, { noremap = true, silent = true })

-- Telescope core mappings
local M = {}
M.mappings = function()
    return {
        i = {
            ["<C-l>"] = require("telescope.actions").cycle_history_next,
            ["<C-h>"] = require("telescope.actions").cycle_history_prev,
        },
        n = {
            ["<C-[>"] = require("telescope.actions").close,
        },
    }
end
return M
--
