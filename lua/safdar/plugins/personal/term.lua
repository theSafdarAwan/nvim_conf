local vim = vim

local te_buf = nil
local te_win_id = nil

local command = vim.api.nvim_command
local fn = vim.fn
local gotoid = fn.win_gotoid
local getid = fn.win_getid

local function open_terminal()
	if fn.bufexists(te_buf) ~= 1 then
		command("sp | winc J | res 15 | te")
		te_win_id = getid()
		te_buf = fn.bufnr("%")
	elseif gotoid(te_win_id) ~= 1 then
		command("sb " .. te_buf .. "| winc J | res 15 ")
		te_win_id = getid()
	end
	command("startinsert")
end

local function hide_terminal()
	if gotoid(te_win_id) == 1 then
		command("hide")
	end
end

function toggle_terminal()
	if gotoid(te_win_id) == 1 then
		hide_terminal()
	else
		open_terminal()
	end
end

require("safdar.plugins.plugins_mappings.term_map")
