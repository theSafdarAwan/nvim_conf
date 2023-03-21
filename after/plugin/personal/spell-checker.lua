--[[
        authord: @theSafdarAwan
        date: 11/17/22 - 00:52 AM
        last modifiction date: 03/21/23 - 07:57

        Description:-
        This is a small plugin for enabaling spell checking in insert mode.
--]]

local vim = vim
local api = vim.api
local optl = vim.opt_local
local bo = vim.bo
local create_autocmd = api.nvim_create_autocmd

--- configuration for spell checker
---@table config
---@field ignore_filetypes table file types to ignore when setting spell checker
---@field check_filetypes table|nil|boolean if file types are added to this table
--- spell checker will only check spell in these file types only else if `nil` or
--- if set to `false`. Then will check every file type excluding the `ignore_filetypes`.
local config = {
	ignore_filetypes = {},
	check_filetypes = {},
}

local status_ok = true

--- Main spell checker function
local function spell_checker()
	if not status_ok then
		return
	end

	if type(config.ignore_filetypes) == "table" then
		for _, ft in ipairs(config.ignore_filetypes) do
			if vim.bo.filetype == ft then
				return
			end
		end
	end

	if type(config.check_filetypes) == "table" and #config.check_filetypes > 0 then
		local check_spell = false
		for _, ft in ipairs(config.check_filetypes) do
			if vim.bo.filetype == ft then
				check_spell = true
			end
		end

		if not check_spell then
			return
		end
	end

	local spell = optl.spell._value

	-- check if spell is set by user or not
	if spell then
		return
	end

	local mode = api.nvim_get_mode().mode
	if mode == "i" and bo.buftype ~= "prompt" then
		optl.spell = true
		-- set the spell false as we leave the insert mode
		local set_spell_off = api.nvim_create_augroup("set spell to false on InsertLeave", { clear = true })
		create_autocmd("InsertLeave", {
			group = set_spell_off,
			callback = function()
				optl.spell = false
				vim.api.nvim_del_augroup_by_id(set_spell_off)
			end,
		})
	end
end

create_autocmd({ "ModeChanged" }, {
	group = api.nvim_create_augroup("spell checker plugin", { clear = true }),
	callback = spell_checker,
})

api.nvim_create_user_command("ToggleSpellChecker", function()
	if status_ok then
		status_ok = false
	else
		status_ok = true
	end
end, {})
