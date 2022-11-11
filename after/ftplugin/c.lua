function AutoCompileMain()
    local utils = require("safdar.core.utils")
    local api = utils.api

    api.nvim_create_autocmd({ "BufLeave" }, {
        group = api.nvim_create_augroup("main.c compile", { clear = true }),
        pattern = { "main.c" },
        command = "silent !./compile",
    })
end
