-- TODO: do something cool with this
local utils = require("safdar.core.utils")
local api = utils.api

local function harpoon(bufInfo)
    if api.nvim_buf_is_valid(bufInfo.buf) then
        local harpoon_map = require("safdar.plugins.harpoon.maps")
        harpoon_map.c_lang_term_maps()
    end
end

api.nvim_create_autocmd({ "BufEnter" }, {
    group = api.nvim_create_augroup("main.c compile", { clear = true }),
    pattern = { "main.c" },
    callback = function(bufInfo)
        harpoon(bufInfo)
    end,
})
