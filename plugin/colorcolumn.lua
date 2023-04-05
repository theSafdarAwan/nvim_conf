--[[
		authord: @theSafdarAwan
		last modifiction date: 04/04/23 - 10:48
		Description:-
		I got this idea from the Damian Conway from his vim talk (https://youtu.be/aHm36-na4-4?t=245)
		to highlight line like the `:h colorcolumn` but it only highlights it if it
		exceeds the certain character limit and only highlights the current line.
--]]

local api, fn, cmd = vim.api, vim.fn, vim.api.nvim_command
local create_autocmd = api.nvim_create_autocmd

local group = api.nvim_create_augroup("colorcolumn", { clear = true })

local function add_highlight(args)
	api.nvim_buf_add_highlight(args.buf, args.ns_id, "CustomColorColumn", args.line_nr, args.col, args.col + 1)
end
local function colorcolumn(args)
	-- only highlight the normal files
	if #vim.bo.buftype > 0 then
		return
	end
	-- add line column according to the textwidth
	local max_col = vim.opt.textwidth._value
	max_col = max_col - 1
	local buf = api.nvim_get_current_buf()
	local ns_id = api.nvim_create_namespace("colorcolumn highlight")
	if args.buf then
		local line_count = api.nvim_buf_line_count(buf)
		local i = line_count
		while true do
			if i < 1 then
				break
			end
			add_highlight({ buf = buf, ns_id = ns_id, line_nr = i, col = max_col })
			i = i - 1
		end
		create_autocmd("InsertLeave", {
			once = true,
			callback = function()
				api.nvim_buf_clear_namespace(buf, ns_id, 1, -1)
			end,
		})
	elseif args.cur_line then
		local pos = fn.getpos(".")
		local cur_line = pos[2] - 1
		api.nvim_buf_clear_namespace(buf, ns_id, cur_line, cur_line + 1)
		add_highlight({ buf = buf, ns_id = ns_id, line_nr = cur_line, col = max_col })
	end
end

create_autocmd({ "InsertEnter" }, {
	group = group,
	callback = function()
		colorcolumn({ buf = true })
	end,
})

create_autocmd({ "TextChangedI" }, {
	group = group,
	callback = function()
		colorcolumn({ cur_line = true })
	end,
})
