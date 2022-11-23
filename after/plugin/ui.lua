local utils = require("safdar.core.utils")
local api = utils.api
local command = utils.command
local create_autocmd = api.nvim_create_autocmd

local autocmds_augroup = api.nvim_create_augroup("ui.lua", { clear = true })

--[[
        authord: @theSafdarAwan
        date: 11/23/22 - 23:19
        last modifiction date: 11/23/22 - 23:19

        Description:-
        I got this from the Damian Conway from his vim talk (https://youtu.be/aHm36-na4-4?t=245)
        to highlight line like the `:h colorcolumn` but it only highlights it if it
        exceeds the 81 character limit.
--]]
-- files to ignore
local matchadd_ignore_ft = {
    "packer",
    "terminal",
    "^NvimTree$",
    "^Outline$",
    "DiffviewFileHistory",
    "DiffviewFiles",
}
local function damian_conways_matchadd(buf_info)
    for _, v in pairs(matchadd_ignore_ft) do
        if buf_info.filetype == v then
            return
        end
        command("call matchadd('DamianConway', '\\%80v')")
    end
end

-- create highlight when i enter insert mode to otherwise don't do it on the
-- files when reading
create_autocmd({ "InsertEnter" }, {
    group = autocmds_augroup,
    callback = function(buf_info)
        damian_conways_matchadd(buf_info)
    end,
})
