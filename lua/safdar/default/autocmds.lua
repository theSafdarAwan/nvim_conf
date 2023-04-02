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
				set = {
					relativenumber = true,
					number = true,
					signcolumn = "yes",
				},
				unset = {
					relativenumber = false,
					number = false,
					signcolumn = "no",
				},
			}
			local types = {
				buf = {
					["prompt"] = common_opts.unset,
					["nofile"] = common_opts.unset,
					["terminal"] = common_opts.unset,
				},
				ft = {
					["startuptime"] = common_opts.unset,
					["noice"] = common_opts.unset,
					["help"] = vim.tbl_extend("force", common_opts.unset, { signcolumn = "no" }),
					["harpoon"] = vim.tbl_extend("force", common_opts.unset, { number = nil }),
				},
			}
			if types.buf[vim.bo.buftype] then
				for option, val in pairs(types.buf[vim.bo.buftype]) do
					optl[option] = val
				end
			elseif types.ft[vim.bo.filetype] then
				for option, val in pairs(types.ft[vim.bo.filetype]) do
					optl[option] = val
				end
			elseif #bo.buftype < 1 then
				for option, val in pairs(common_opts.set) do
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
