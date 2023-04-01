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
	set_common_opts = {
		events = { "BufRead", "BufWinEnter" },
		callback = function()
			local common_opts = {
				{
					relativenumber = true,
					number = true,
					signcolumn = "yes",
				},
				{
					relativenumber = false,
					number = false,
					signcolumn = "no",
				},
			}
			local types = {
				buf = {
					["prompt"] = common_opts[2],
					["nofile"] = common_opts[2],
					["terminal"] = common_opts[2],
				},
				ft = {
					["noice"] = common_opts[2],
					["help"] = vim.tbl_extend("force", common_opts[1], { signcolumn = "no" }),
					["harpoon"] = {
						signcolumn = "no",
						relativenumber = false,
					},
				},
			}
			if types.buf[vim.bo.buftype] then
				for option, val in pairs(types.buf[vim.bo.buftype]) do
					optl[option] = val
				end
			end
			if types.ft[vim.bo.filetype] then
				for option, val in pairs(types.ft[vim.bo.filetype]) do
					optl[option] = val
				end
			end
		end,
	},
	terminal_mode = {
		events = { "TermOpen" },
		callback = function()
			optl.number = false
			optl.signcolumn = "no"
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
	vim.defer_fn(function()
		vim.api.nvim_create_autocmd(events, au)
	end, 0)
end

vim.cmd([[
	autocmd TermClose * if !v:event.status | exe 'bdelete! '..expand('<abuf>') | elseif !v:shell_error | exe 'bdelete! '..expand('<abuf>') | endif
]])
