local cp = require("fused.palletes").dark_pallete
require("scrollbar").setup({
    handle = {
        color = cp.bg_windows2,
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
