local utils = require("safdar.core.utils")
local vim = utils.vim

local te_buf = nil
local te_win_id = nil

local command = utils.command
local fun = vim.fn
local gotoid = fun.win_gotoid
local getid = fun.win_getid

local function openTerminal()
	if fun.bufexists(te_buf) ~= 1 then
		command("sp | winc J | res 15 | te")
		te_win_id = getid()
		te_buf = fun.bufnr("%")
	elseif gotoid(te_win_id) ~= 1 then
		command("sb " .. te_buf .. "| winc J | res 15 ")
		te_win_id = getid()
	end
	command("startinsert")
end

local function hideTerminal()
	if gotoid(te_win_id) == 1 then
		command("hide")
	end
end

function ToggleTerminal()
	if gotoid(te_win_id) == 1 then
		hideTerminal()
	else
		openTerminal()
	end
end

require("safdar.plugins.plugins_mappings.term_map")
