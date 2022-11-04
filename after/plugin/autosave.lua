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

--[[ ---@diagnostic disable: param-type-mismatch
local api = vim.api
local fn = vim.fn

local delay = 250 -- ms

local autosave = api.nvim_create_augroup("autosave", { clear = true })
-- Initialization
api.nvim_create_autocmd("BufRead", {
    pattern = "*",
    group = autosave,
    callback = function(ctx)
        api.nvim_buf_set_var(ctx.buf, "autosave_queued", false)
        api.nvim_buf_set_var(ctx.buf, "autosave_block", false)
    end,
})

api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
    pattern = "*",
    group = autosave,
    callback = function(ctx)
        local ok, queued =
        pcall(api.nvim_buf_get_var, ctx.buf, "autosave_queued")
        if not ok then
            return
        end

        if not queued then
            if -- conditions to save
            vim.bo.modified
                and fn.findfile(ctx.file, ".") ~= ""
                and not ctx.file:match("wezterm.lua")
            then
                vim.cmd("silent w")
                api.nvim_buf_set_var(ctx.buf, "autosave_queued", true)
                vim.notify("Saved at " .. os.date("%H:%M:%S"))
            end
        end

        local block = api.nvim_buf_get_var(ctx.buf, "autosave_block")
        if not block then
            api.nvim_buf_set_var(ctx.buf, "autosave_block", true)
            vim.defer_fn(function()
                if api.nvim_buf_is_valid(ctx.buf) then
                    api.nvim_buf_set_var(ctx.buf, "autosave_queued", false)
                    api.nvim_buf_set_var(ctx.buf, "autosave_block", false)
                end
            end, delay)
        end
    end,
}) ]]
