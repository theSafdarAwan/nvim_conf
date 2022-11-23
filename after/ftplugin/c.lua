-- TODO: do something cool with this
local utils = require("safdar.core.utils")
local api = utils.api

local function harpoon(bufInfo)
	if api.nvim_buf_is_valid(bufInfo.buf) then
		local harpoon_map = require("safdar.plugins.harpoon.maps")
		harpoon_map.c_lang_term_maps()
	end
end

api.nvim_create_autocmd({ "BufEnter" }, {
	group = api.nvim_create_augroup("main.c compile", { clear = true }),
	pattern = { "main.c" },
	callback = function(bufInfo)
		harpoon(bufInfo)
	end,
})

--[[
    This is cool now i can create my own stuff to compile the c code
    TODO: write your script for executing c code
--]]
local vim = vim
local api = vim.api
local fn = vim.fn
local bufnr = 50

local function cool_func()
	fn.jobstart({ "gcc", "main.c", "|", "./a.out" }, {
		stdout_buffered = true,
		on_stdout = function(_, data)
			if data then
				api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
			end
		end,
		on_stderr = function(_, data)
			if data then
				api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
			end
		end,
	})
end

--[[ api.nvim_create_autocmd("BufWritePost", {
    group = api.nvim_create_augroup("tj", { clear = true }),
    callback = cool_func,
}) ]]
