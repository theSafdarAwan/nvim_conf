-- TODO: work on this extension

--[[
        authord: @theSafdarAwan
        date: 11/17/22 - 00:52 AM

        Description:-
        This is a small extension for enabaling spell checking only in insert
        mode. If it was not set by the user on the defined filetypes.
--]]
local utils = require("safdar.core.utils")
local api = utils.api
local optl = utils.optl
local create_autocmd = api.nvim_create_autocmd

local spell_checker = api.nvim_create_augroup("spell_checker", { clear = true })

local file_types = { "gitcommit", "NeogitCommitMessage", "markdown", "tex", "norg" }

local function setFileTypeSpellAu()
    local spud = "spell_checker_disable"
    local spell = optl.spell._value

    local function spell_var_setter(ft_buf_info)
        if spell then
            api.nvim_buf_set_var(ft_buf_info.buf, spud, true)
        else
            api.nvim_buf_set_var(ft_buf_info.buf, spud, false)
        end
    end

    api.nvim_create_autocmd("BufEnter", {
        group = spell_checker,
        callback = function(ft_buf_info)
            spell_var_setter(ft_buf_info)
        end,
    })

    local function _set_spell(bufInfo)
        local mode = api.nvim_get_mode().mode
        local get_spell_var = api.nvim_buf_get_var(bufInfo.buf, spud)

        spell_var_setter(bufInfo)

        if get_spell_var then
            print(mode .. "r")
            return
        elseif mode == "i" then
            print(mode .. "e")
            optl.spell = true
        end
    end

    create_autocmd({ "InsertEnter", "InsertLeave" }, {
        group = api.nvim_create_augroup("ft_spell_au", { clear = true }),
        callback = function(bufInfo)
            _set_spell(bufInfo)
        end,
    })
end

-- -- set spell for the gitcommit messages and other filetypes
-- create_autocmd({ "FileType" }, {
--     group = spell_checker,
--     pattern = file_types,
--     callback = setFileTypeSpellAu,
-- })
