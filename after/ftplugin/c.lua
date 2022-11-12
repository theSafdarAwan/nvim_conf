-- TODO: do something cool with this
local utils = require("safdar.core.utils")
local api = utils.api

local function harpoon(bufInfo)
    if api.nvim_buf_is_valid(bufInfo.buf) then
        local harpoon_map = require("safdar.plugins_mappings.harpoon_map")
        harpoon_map.c_lang_term_maps()
    end
end

-- TODO: clean this harpoon function it will be called every time you enter the
-- buffer from another buffer
api.nvim_create_autocmd({ "BufEnter" }, {
    group = api.nvim_create_augroup("main.c compile", { clear = true }),
    pattern = { "main.c" },
    callback = function(bufInfo)
        harpoon(bufInfo)
    end,
})
