local M = {}

local utils = require("safdar.core.utils")
local vim = utils.vim
local api = utils.api
local opt = utils.opt
local optl = utils.optl
local cmd = utils.cmd
local bo = vim.bo
local create_autocmd = api.nvim_create_autocmd

local autocmds_augroup = api.nvim_create_augroup("autocmds.lua", { clear = true })

M.autocmds = function()
	-- Highlight The yanked text
	local function highlightOnYank()
		require("vim.highlight").on_yank({ timeout = 40 })
	end

	create_autocmd({ "TextYankPost" }, {
		group = autocmds_augroup,
		callback = highlightOnYank,
	})

	-- Help Helper Function
	local function help_helper()
		if bo.filetype == "help" then
			optl.relativenumber = true
			optl.number = true
			optl.conceallevel = 0
			optl.statusline = " "
		end
	end

	-- set a bunch of options for the help filetype
	create_autocmd({ "BufWinEnter" }, {
		group = autocmds_augroup,
		callback = help_helper,
	})

	-- Don't show the line numbers in terminal mode
	local function terminalMode()
		optl.number = false
		optl.relativenumber = false
		opt.filetype = "terminal"
		optl.spell = false
	end

	create_autocmd({ "TermOpen" }, {
		group = autocmds_augroup,
		callback = terminalMode,
	})

	-- dont list quickfix buffers
	create_autocmd("FileType", {
		pattern = "qf",
		callback = function()
			vim.opt_local.buflisted = false
		end,
	})

	-- instead use gx map
	--[[ -- mapping q to close the windows in help, packer and some other file types
	local function quitter()
		map({ "n", "v" }, "q", function()
			utils.command("close")
		end, opts)
	end
	create_autocmd({ "FileType" }, {
		pattern = { "help", "man", "lspinfo", "qf" },
		group = autocmds_augroup,
		callback = quitter,
	}) ]]

	-- don't give exit code when exiting the terminal
	cmd([[
    autocmd TermClose * if !v:event.status | exe 'bdelete! '..expand('<abuf>') | endif
	]])
end

M.plugins_autocmds = function()
	-- Help Helper Function
	local function norg_ft_opts()
		optl.shiftwidth = 2
		optl.expandtab = true
	end

	create_autocmd({ "FileType" }, {
		group = autocmds_augroup,
		pattern = { "norg" },
		callback = norg_ft_opts,
	})

	-- Colorizer plugin attach autocmd's
	create_autocmd({ "BufEnter", "InsertLeave", "CursorMoved", "CursorHold" }, {
		group = autocmds_augroup,
		command = "ColorizerAttachToBuffer",
	})
end

return M
