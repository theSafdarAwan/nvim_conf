--[[
	Description:-
	This script will add undo breakpoints for A-Z capital alphabets and punctuations.
--]]
local api, fn = vim.api, vim.fn

local function feed(keys)
	keys = api.nvim_replace_termcodes(keys, true, true, true)
	api.nvim_feedkeys(keys, "n", false)
end

api.nvim_create_autocmd("InsertCharPre", {
	group = api.nvim_create_augroup("undo-breakpoints", { clear = true }),
	callback = function()
		local char = vim.v.char
		if string.find(char, "[A-Z%p]") then
			feed("<C-g>u")
		end
	end,
})
