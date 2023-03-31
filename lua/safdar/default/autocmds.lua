local opt, optl, bo = vim.opt, vim.opt_local, vim.bo
local cmd, api = vim.cmd, vim.api

local autocmds = {
	highlight_on_yank = {
		events = { "TextYankPost" },
		callback = function()
			require("vim.highlight").on_yank({
				timeout = 40,
				higroup = "MatchParen",
			})
		end,
	},

	help_ft = {
		events = { "BufWinEnter" },
		callback = function()
			if bo.filetype == "help" then
				optl.conceallevel = 0
				optl.statusline = " "
			end
		end,
	},

	line_number_helper = {
		events = { "CursorMoved" },
		callback = function()
			local ignore_list = {
				buf = { "prompt", "nofile", "terminal" },
				ft = { "norg", "noice" },
			}
			local safe = true
			for _, opt_type in pairs(ignore_list) do
				for _, type in pairs(opt_type) do
					if type == bo.filetype or type == bo.buftype then
						safe = false
						break
					end
					if not safe then
						break
					end
				end
			end
			if safe then
				optl.relativenumber = true
				optl.number = true
				optl.signcolumn = "yes"
			else
				optl.relativenumber = false
				optl.number = false
				optl.signcolumn = "no"
			end
		end,
	},
	terminal_mode = {
		events = { "TermOpen" },
		callback = function()
			optl.number = false
			optl.relativenumber = false
			opt.filetype = "terminal"
			optl.spell = false
		end,
	},
	qf_list = {
		events = { "FileType" },
		pattern = "qf",
		callback = function()
			optl.buflisted = false
		end,
	},
	-- q_file = {
	-- 	events = { "FileType" },
	-- 	pattern = { "help", "man", "lspinfo", "qf" },
	-- 	callback = function()
	-- 		vim.keymap.set({ "n", "v" }, "q", function()
	-- 			cmd("close")
	-- 		end, { noremap = true, silent = true })
	-- 	end,
	-- },
}

for _, au in pairs(autocmds) do
	local events = vim.deepcopy(au.events)
	au.events = nil
	au.group = au.group or api.nvim_create_augroup("autocmds.lua", { clear = true })
	vim.api.nvim_create_autocmd(events, au)
end

vim.cmd([[
	autocmd TermClose * if !v:event.status | exe 'bdelete! '..expand('<abuf>') | elseif !v:shell_error | exe 'bdelete! '..expand('<abuf>') | endif
]])
