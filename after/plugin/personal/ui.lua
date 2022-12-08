--[[
        authord: @theSafdarAwan
        date: 11/23/22 - 23:19
        last modifiction date: 11/25/22 - 16:01

        Description:-
		This file includes some of the improvement for the ui or some plugins related to
		UI. I didn't wanted to add a new file for every utility so i added single for.
--]]
local utils = require("safdar.core.utils")
local api = utils.api
local command = utils.command
local create_autocmd = api.nvim_create_autocmd

local augroup_ui = api.nvim_create_augroup("ui.lua", { clear = true })

--[[
        Description:-
        I got this from the Damian Conway from his vim talk (https://youtu.be/aHm36-na4-4?t=245)
        to highlight line like the `:h colorcolumn` but it only highlights it if it
        exceeds the 81 character limit.
--]]
-- BUG: highlight is global so i can't do anything here do something after you
-- learn more about vim-script and lua.
-- files to ignore
local matchadd_ignore_ft = {
	"packer",
	"terminal",
	"^NvimTree$",
	"^Outline$",
	"DiffviewFileHistory",
	"DiffviewFiles",
}
local function damian_conways_matchadd(buf_info)
	for _, v in pairs(matchadd_ignore_ft) do
		if buf_info.filetype == v then
			return
		end
		-- DamianConway is just the name of the highlight you can provide any highlight
		-- name here for convenience i create a new highlight wit the name DamianConway
		command("call matchadd('DamianConway', '\\%80v')")
	end
end

create_autocmd({ "BufEnter" }, {
	group = augroup_ui,
	callback = function(buf_info)
		damian_conways_matchadd(buf_info)
	end,
})
