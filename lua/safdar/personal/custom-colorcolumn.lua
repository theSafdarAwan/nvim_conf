--[[
        Description:-
        I got this idea from the Damian Conway from his vim talk (https://youtu.be/aHm36-na4-4?t=245)
        to highlight line like the `:h colorcolumn` but it only highlights it if it
        exceeds the certain character limit.
--]]
local api, fn, cmd = vim.api, vim.fn, vim.api.nvim_command
local create_autocmd = api.nvim_create_autocmd

local group = api.nvim_create_augroup("custom-colorcolumn", { clear = true })

local function custom_colorcolumn(buf_info)
	if #vim.bo.buftype > 0 then
		return
	end
	-- local ns = api.nvim_create_namespace("custom higlight")
	-- local pos = fn.getpos(".")
	-- local extmark = api.nvim_buf_set_extmark(0, ns, pos[2] - 1, pos[3] - 1, {})
	-- local extmarks = api.nvim_buf_get_extmarks(0, ns, 0, -1, {})
	-- api.nvim_buf_add_highlight(0, ns, "CustomColorColumn", pos[2] - 1, 0, -1)
	-- create_autocmd("CursorMoved", {})
end

create_autocmd({ "BufRead" }, {
	group = group,
	callback = function(buf_info)
		custom_colorcolumn(buf_info)
	end,
})
