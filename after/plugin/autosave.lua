local utils = require("safdar.core.utils")
local vim = utils.vim
local api = utils.api
local b = utils.b

local function validateBuf()
    local filetypeValidated = false
    local exclude_ftype = { "TelescopePrompt", "harpoon" }

    -- check if buf filetype is not included in the exclude_ftype
    for _, filetype in ipairs(exclude_ftype) do
        if b.filetype ~= filetype and filetypeValidated == false then
            filetypeValidated = false
        else
            filetypeValidated = true
        end
    end

    -- check if the buf is modifiable and does not have any of the exclude_ftype
    if b.modifiable == false or filetypeValidated then
        return
    else
        api.nvim_command("update")
        print("saved at " .. vim.fn.strftime("%H:%M:%S"))
        vim.fn.timer_start(1500, function()
            vim.cmd("echon ''")
        end)
    end
end

api.nvim_create_autocmd({ "CursorHoldI", "InsertLeave", "TextChanged" }, {
    callback = validateBuf,
})
