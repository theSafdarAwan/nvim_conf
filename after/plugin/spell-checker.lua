--[[
        authord: @theSafdarAwan
        date: 11/17/22 - 00:52 AM
        last modifiction date: 11/18/22 - 17:00

        Description:-
        This is a small plugin for enabaling spell checking only in insert
        mode. In the user specified file types.
--]]

local utils = require("safdar.core.utils")
local api = utils.api
local optl = utils.optl
local bo = utils.bo
local create_autocmd = api.nvim_create_autocmd

local spell_checker = api.nvim_create_augroup("spell_checker", { clear = true })

-- file types to enable this plugin in
local file_types = {
    "gitcommit",
    "NeogitCommitMessage",
    "markdown",
    "tex",
    "norg",
}

local function load_plugin()
    local spell = optl.spell._value

    -- check if spell is set by user or not
    if spell then
        return
    end

    local function set_spell_on_insert()
        local mode = api.nvim_get_mode().mode

        if mode == "i" and bo.buftype ~= "prompt" then
            optl.spell = true
        else
            optl.spell = false
        end
    end

    create_autocmd({ "ModeChanged" }, {
        group = api.nvim_create_augroup("ft_spell_au", { clear = true }),
        callback = function()
            set_spell_on_insert()
        end,
    })
end

-- set spell for the gitcommit messages and other filetypes
create_autocmd({ "FileType" }, {
    group = spell_checker,
    pattern = file_types,
    callback = function()
        load_plugin()
    end,
})
