--[[
        Description:-
        I got this idea from the Damian Conway from his vim talk (https://youtu.be/aHm36-na4-4?t=245)
        to highlight line like the `:h colorcolumn` but it only highlights it if it
        exceeds the certain character limit and only highlights the current line.
--]]
local api, fn, cmd = vim.api, vim.fn, vim.api.nvim_command
local create_autocmd = api.nvim_create_autocmd

local group = api.nvim_create_augroup("colorcolumn", { clear = true })

local function colorcolumn()
	-- only highlight the normal files
	if #vim.bo.buftype > 0 then
		return
	end
	-- add line column according to the textwidth
	local max_col = vim.opt.textwidth._value
	max_col = max_col - 1
	local ns_id = api.nvim_create_namespace("colorcolumn highlight")
	local pos = fn.getpos(".")
	local cur_line = pos[2] - 1
	api.nvim_buf_clear_namespace(0, ns_id, 1, -1)
	api.nvim_buf_add_highlight(0, ns_id, "CustomColorColumn", cur_line, max_col, max_col + 1)
end

-- TODO: add colorcolumn to every line when BufRead and after that update it when
-- TextChanged, TextChangedI, etc.

-- create_autocmd({ "CursorMoved", "TextChanged", "TextChangedI" }, {
-- 	group = group,
-- 	callback = function()
-- 		colorcolumn()
-- 	end,
-- })
