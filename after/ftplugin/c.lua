-- TODO: do something cool with this
local vim = vim
local api = vim.api
local command = vim.api.nvim_command
local fn = vim.fn

local utils = require("safdar.core.utils")
local map = utils.map

-- NOTE: this is just for fun to test the limits of neovim
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
		local harpoon_map = require("safdar.plugins.harpoon.maps")
		harpoon_map.c_lang_term_maps()
		-- debugger
		map("n", "_D", function()
			c_debugger()
		end, { noremap = true, silent = true })
	end
end

api.nvim_create_autocmd({ "BufEnter" }, {
	group = api.nvim_create_augroup("main.c compile", { clear = true }),
	pattern = { "main.c" },
	callback = function(bufInfo)
		harpoon(bufInfo)
	end,
})
