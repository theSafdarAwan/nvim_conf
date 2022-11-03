local vim = vim

local api = vim.api

local function validateBuf()
    if vim.bo.modifiable == true and vim.bo.buftype ~= "prompt" then
        vim.api.nvim_command("update")
        print("saved at " .. vim.fn.strftime("%H:%M:%S"))
        vim.fn.timer_start(1500, function()
            vim.cmd("echon ''")
        end)
    else
        return false
    end
end

api.nvim_create_autocmd({ "TextChangedI", "TextChanged" }, {
    callback = validateBuf,
})
