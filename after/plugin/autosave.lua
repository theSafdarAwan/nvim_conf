local utils = require("safdar.core.utils")
local vim = utils.vim
local api = utils.api
local create_autocmd = api.nvim_create_autocmd
local command = utils.command
local b = utils.b
local cmd = utils.cmd
local fn = utils.fn
local dealyAutoSave = 300

-- create the autosave augroup and Initialization of the autosave_queued and
-- autosave_block variables
local autoSave = api.nvim_create_augroup("autosave", { clear = true })
local autoSaveQueued = "autosave_queued"
local autoSaveBlock = "autosave_block"

api.nvim_create_autocmd("BufRead", {
    group = autoSave,
    callback = function(bufInfo)
        api.nvim_buf_set_var(bufInfo.buf, autoSaveQueued, false)
        api.nvim_buf_set_var(bufInfo.buf, autoSaveBlock, false)
    end,
})

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

-- autosave function
local function autoSaveFn(bufInfo)
    local ok, queued = pcall(api.nvim_buf_get_var, bufInfo.buf, autoSaveQueued)
    if not ok then
        return
    end

    if not queued then
        local excluded_ftype = { "TelescopePrompt", "harpoon" }
        local excluded_buftype = { "prompt" }
        local invalidBuf = validater({ type = "buf", data = excluded_buftype })
        local invalidFt = validater({ type = "ft", data = excluded_ftype })
        -- check if the buf is modifiable and then validate buf does not have any of
        -- the excluded filetypes or buftypes
        if b.modifiable == true
            and invalidFt == false
            and invalidBuf == false
        then
            command("update")
            -- print("saved at " .. vim.fn.strftime("%H:%M:%S"))
            api.nvim_buf_set_var(bufInfo.buf, autoSaveQueued, true)
            fn.timer_start(1500, function()
                cmd("echon ''")
            end)
        end

        local function deferFn()
            if api.nvim_buf_is_valid(bufInfo.buf) then
                api.nvim_buf_set_var(bufInfo.buf, autoSaveQueued, false)
            end
        end

        vim.defer_fn(deferFn, dealyAutoSave)
        local block = api.nvim_buf_get_var(bufInfo.buf, autoSaveBlock)
        if not block then
            api.nvim_buf_set_var(bufInfo.buf, autoSaveBlock, true)
            local function deferBlockFn()
                -- check if the buffer valid
                -- because buffer may disappear after delay
                if api.nvim_buf_is_valid(bufInfo.buf) then
                    api.nvim_buf_set_var(bufInfo.buf, autoSaveQueued, false)
                    api.nvim_buf_set_var(bufInfo.buf, autoSaveBlock, false)
                end
            end

            vim.defer_fn(deferBlockFn, dealyAutoSave)
        end
    end
end

-- register autocmd to autosave on these events
create_autocmd({ "TextChanged", "InsertLeave", "CursorHold" }, {
    group = autoSave,
    callback = function(bufInfo)
        autoSaveFn(bufInfo)
    end,
})
