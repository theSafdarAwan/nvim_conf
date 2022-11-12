require("harpoon").setup({
    excluded_filetypes = { "harpoon" },
    menu = {
        width = vim.api.nvim_win_get_width(0) - 20,
    },
})

-- require general mappings
require("safdar.plugins_mappings.harpoon_map").maps()
