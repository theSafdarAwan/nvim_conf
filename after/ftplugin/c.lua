local api = vim.api
local command = vim.api.nvim_command
local fn = vim.fn

local utils = require("safdar.utils")
local set_map = utils.set_map

local function c_debugger()
	command("new")
	-- get the bufid
	local bufnr = vim.fn.bufnr()
	local function cool_func()
		fn.jobstart({ "./compile" }, {
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

	api.nvim_create_autocmd("BufWritePost", {
		group = api.nvim_create_augroup("tj", { clear = true }),
		callback = cool_func,
	})
end

local function harpoon(bufInfo)
	if api.nvim_buf_is_valid(bufInfo.buf) then
		local harpoon_map = require("safdar.setup.navigation.harpoon.maps")
		harpoon_map.c_lang()
		-- debugger
		set_map("n", "_D", function()
			c_debugger()
		end, { noremap = true, silent = true })
	end
end

api.nvim_create_autocmd({ "BufWinEnter" }, {
	group = api.nvim_create_augroup("main.c compile", { clear = true }),
	pattern = { "*.c" },
	callback = function(bufInfo)
		harpoon(bufInfo)
	end,
})

local opt = vim.opt_local
local indent = 4
opt.shiftwidth = indent
opt.tabstop = indent
opt.softtabstop = indent
