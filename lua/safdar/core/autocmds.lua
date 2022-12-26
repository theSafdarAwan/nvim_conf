local M = {}

local vim = vim
local api = vim.api
local opt = vim.opt
local optl = vim.opt_local
local cmd = vim.cmd
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

	-- setting for the help file type buffer
	local function help_ft()
		if bo.filetype == "help" then
			optl.conceallevel = 0
			optl.statusline = " "
		end
	end

	-- set a bunch of options for the help filetype
	create_autocmd({ "BufWinEnter" }, {
		group = autocmds_augroup,
		callback = help_ft,
	})

	-- set line number for every buffer except a prompt, nofile and terminal
	local function line_numers()
		if bo.buftype ~= "prompt" and bo.buftype ~= "nofile" and bo.buftype ~= "terminal" then
			optl.relativenumber = true
			optl.number = true
		end
	end

	create_autocmd({ "BufWinEnter" }, {
		group = autocmds_augroup,
		callback = line_numers,
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
			optl.buflisted = false
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
end

return M
