require("neoclip").setup({
    enable_persistent_history = true,
    history = 30,
    length_limit = 1048576,
    continuous_sync = true,
    db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
    filter = nil,
    preview = true,
    prompt = nil,
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
