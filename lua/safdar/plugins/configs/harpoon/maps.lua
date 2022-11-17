local utils = require("safdar.core.utils")
local map = utils.map
local opts = { noremap = true, silent = true }
local buf_map = utils.buf_set_keymap

local M = {}

M.maps = function()
    -- TODO: add some autocmd or mapping so whenever you move between two files then
    -- it should add the previous file to a harpoon nav_file(4) and add the mapping
    -- of <leader>ap.
    -- Harpoon
    map("n", "<leader>aa", ":lua require('harpoon.mark').add_file()<CR>", opts)
    map(
        "n",
        "<leader>ah",
        ":lua require('harpoon.ui').toggle_quick_menu()<cr>",
        opts
    )
    map(
        "n",
        "<leader>aH",
        ":lua require('harpoon.cmd-ui').toggle_quick_menu()<cr>",
        opts
    )
    map("n", "<leader>aj", ":lua require('harpoon.ui').nav_file(1)<cr>", opts)
    map("n", "<leader>ak", ":lua require('harpoon.ui').nav_file(2)<cr>", opts)
    map("n", "<leader>al", ":lua require('harpoon.ui').nav_file(3)<cr>", opts)

    -- Terminal's
    map(
        "n",
        "<leader>tj",
        ":lua require('harpoon.term').gotoTerminal(1)<cr>",
        opts
    )
    map(
        "n",
        "<leader>tk",
        ":lua require('harpoon.term').gotoTerminal(2)<cr>",
        opts
    )
    map(
        "n",
        "<leader>tl",
        ":lua require('harpoon.term').gotoTerminal(3)<cr>",
        opts
    )

    -- tmux Terminals
    --[[ map(
        "n",
        "<leader>tj",
        ":lua require('harpoon.tmux').gotoTerminal(1)<cr>",
        opts
    )
    map(
        "n",
        "<leader>tk",
        ":lua require('harpoon.tmux').gotoTerminal(2)<cr>",
        opts
    )
    map(
        "n",
        "<leader>tl",
        ":lua require('harpoon.tmux').gotoTerminal(3)<cr>",
        opts
    ) ]]
end

-- send commands to terminal windows
M.c_lang_term_maps = function()
    buf_map(
        0,
        "n",
        "<leader>ts",
        ":lua require('harpoon.term').sendCommand(1, './compile')<CR>",
        opts
    )
end

return M
