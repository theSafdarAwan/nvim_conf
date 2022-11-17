local cp = require("fused.palletes").dark_pallete
require("scrollbar").setup({
    handle = {
        color = cp.bg_windows,
    },
    marks = {
        Search = { color = cp.search },
        Error = { color = cp.red },
        Warn = { color = cp.yellow },
        Info = { color = cp.green },
        Hint = { color = cp.teal },
        Misc = { color = cp.pink },
    },
})
