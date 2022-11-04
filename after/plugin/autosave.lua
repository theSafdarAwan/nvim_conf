local utils = require("safdar.core.utils")
local vim = utils.vim
local new_autocmd = utils.create_autocmd
local command = utils.command
local b = utils.b
local cmd = utils.cmd

-- validate excluded buftype's and filetype's from autosaving if
-- included then will return true else will return false
local function validater(opts)
    local ok = false
    local type
    if opts.type == "buf" then
        type = b.buftype
    else
        type = b.filetype
    end
    for _, value in ipairs(opts.data) do
        if type == value and ok == false then
            ok = true
        end
    end
    return ok
end

local function autoSave()
    local excluded_ftype = { "TelescopePrompt", "harpoon" }
    local excluded_buftype = { "prompt" }
    local invalidBuf = validater({ type = "buf", data = excluded_buftype })
    local invalidFt = validater({ type = "ft", data = excluded_ftype })
    -- check if the buf is modifiable and then validate buf does not have any of
    -- the excluded filetypes or buftypes
    if b.modifiable == true and invalidFt == false and invalidBuf == false then
        command("update")
        print("saved at " .. vim.fn.strftime("%H:%M:%S"))
        vim.fn.timer_start(1500, function()
            cmd("echon ''")
        end)
    end
end

-- register autocmd to autosave on these events
new_autocmd({ "InsertLeave", "CursorHoldI", "TextChanged" }, {
    callback = autoSave,
})
