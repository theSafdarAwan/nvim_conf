require("neoclip").setup({
    enable_persistent_history = true,
    history = 1000,
    continuous_sync = false,
    db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
    preview = true,
    default_register = "n",
    default_register_macros = "q",
    enable_macro_history = true,
    content_spec_column = false,
    on_paste = {
        set_reg = false,
    },
    on_replay = {
        set_reg = false,
    },
    keys = require("safdar.plugins_mappings.neoclip_map").mapings(),
})
