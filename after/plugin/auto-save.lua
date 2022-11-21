local utils = require("safdar.core.utils")
local vim = utils.vim
local api = utils.api
local create_autocmd = api.nvim_create_autocmd
local command = utils.command
local b = utils.bo
local cmd = utils.cmd
local fn = utils.fn
local delay_auto_save = 10

-- create the autosave augroup and Initialization of the autosave_queued and
-- autosave_block variables
local auto_save = api.nvim_create_augroup("autosave", { clear = true })
local auto_save_queued = "autosave_queued"
local auto_save_block = "autosave_block"

api.nvim_create_autocmd("BufRead", {
    group = auto_save,
    callback = function(buf_info)
        api.nvim_buf_set_var(buf_info.buf, auto_save_queued, false)
        api.nvim_buf_set_var(buf_info.buf, auto_save_block, false)
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
local function autoSaveFn(buf_info)
    local ok, queued =
    pcall(api.nvim_buf_get_var, buf_info.buf, auto_save_queued)
    if not ok then
        return
    end

    if not queued then
        local excluded_ftype = { "TelescopePrompt", "harpoon" }
        local excluded_buftype = { "prompt" }
        local invalid_buf = validater({ type = "buf", data = excluded_buftype })
        local invalid_ft = validater({ type = "ft", data = excluded_ftype })
        -- check if the buf is modifiable and then validate buf does not have any of
        -- the excluded filetypes or buftypes
        if b.modifiable == true
            and invalid_ft == false
            and invalid_buf == false
        then
            command("update")
            -- print("saved at " .. vim.fn.strftime("%H:%M:%S"))
            api.nvim_buf_set_var(buf_info.buf, auto_save_queued, true)
            fn.timer_start(1500, function()
                cmd("echon ''")
            end)
        end

        local function defer_fn()
            if api.nvim_buf_is_valid(buf_info.buf) then
                api.nvim_buf_set_var(buf_info.buf, auto_save_queued, false)
            end
        end

        vim.defer_fn(defer_fn, delay_auto_save)
        local block = api.nvim_buf_get_var(buf_info.buf, auto_save_block)
        if not block then
            api.nvim_buf_set_var(buf_info.buf, auto_save_block, true)
            local function defer_block_fn()
                -- check if the buffer valid
                -- because buffer may disappear after delay
                if api.nvim_buf_is_valid(buf_info.buf) then
                    api.nvim_buf_set_var(buf_info.buf, auto_save_queued, false)
                    api.nvim_buf_set_var(buf_info.buf, auto_save_block, false)
                end
            end

            vim.defer_fn(defer_block_fn, delay_auto_save)
        end
    end
end

-- register autocmd to autosave on these events
create_autocmd({ "TextChanged", "ModeChanged", "CursorHold" }, {
    group = auto_save,
    callback = function(buf_info)
        autoSaveFn(buf_info)
    end,
})
