--[[
        authord: @theSafdarAwan
        date: 11/17/22 - 00:52 AM
        last modifiction date: 01/03/23 - 12:51

        Description:-
        This is a small plugin for enabaling spell checking in insert mode.
--]]

local vim = vim
local api = vim.api
local optl = vim.opt_local
local bo = vim.bo
local create_autocmd = api.nvim_create_autocmd

local function set_spell()
	local spell = optl.spell._value

	-- check if spell is set by user or not
	if spell then
		return
	end

	local mode = api.nvim_get_mode().mode
	if mode == "i" and bo.buftype ~= "prompt" then
		optl.spell = true
		-- to set the spell false as we leave the insert mode
		local del_spell = api.nvim_create_augroup("set spell to false", { clear = true })
		create_autocmd("InsertLeave", {
			group = del_spell,
			callback = function()
				optl.spell = false
				-- need to delete the augoup as soon as it sets the
				-- spell off else if user sets spell then it will
				-- turn off spell after leaving insert mode
				vim.api.nvim_del_augroup_by_id(del_spell)
			end,
		})
	end
end

create_autocmd({ "ModeChanged" }, {
	group = api.nvim_create_augroup("spell checker plugin", { clear = true }),
	callback = set_spell,
})
