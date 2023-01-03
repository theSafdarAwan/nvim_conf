--[[
        authord: @theSafdarAwan
        date: 11/17/22 - 00:52 AM
        last modifiction date: 01/03/23 - 05:30

        Description:-
        This is a small plugin for enabaling spell checking in insert mode.
--]]

local vim = vim
local api = vim.api
local optl = vim.opt_local
local bo = vim.bo
local create_autocmd = api.nvim_create_autocmd

local notify = function(notify)
	local msg
	if type(notify) == "string" then
		msg = notify
	end
	if notify then
		local level = vim.log.levels.WARN
		vim.api.nvim_notify(notify.msg or msg, notify.level or level, notify.opts or {})
	end
end

local config = {
	-- ignore_filetypes = {
	-- 	"lua",
	-- 	"css",
	-- },
	check_filetypes = true,
	-- check_filetypes = {
	-- 	"markdown",
	-- 	"html",
	-- 	"norg",
	-- },
}

local function set_spell()
	-- if the check_filetypes is true then only ignore the files in the
	-- ignore_filetypes table
	if type(config.check_filetypes) == "boolean" and config.check_filetypes == true then
		if type(config.ignore_filetypes) == "table" then
			for _, ft in ipairs(config.ignore_filetypes) do
				if vim.bo.filetype == ft then
					return
				end
			end
		end
	elseif type(config.check_filetypes) == "table" then
		-- if the check_filetypes is a table then only check the provided
		-- table filetypes
		local check_for_spell = false
		for _, ft in ipairs(config.check_filetypes) do
			if vim.bo.filetype == ft then
				check_for_spell = true
			end
		end
		if not check_for_spell then
			return
		end
	end

	if type(config.ignore_filetypes) == "boolean" then
		-- if ignore_filetypes is a boolean value then warn user
		notify("ignore_filetypes should be a table not a boolean value")
	elseif config.check_filetypes == nil then
		-- warn if the check_filetypes is a nil value
		notify("check_filetypes is nil")
	end

	local spell = optl.spell._value

	-- check if spell is set by user or not
	if spell then
		return
	end

	local mode = api.nvim_get_mode().mode
	if mode == "i" and bo.buftype ~= "prompt" then
		optl.spell = true
		-- to set the spell false as we leave the insert mode
		local del_spell = api.nvim_create_augroup("set spell to false on InsertLeave", { clear = true })
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
