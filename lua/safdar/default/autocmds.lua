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
	set_common_opts = {
		events = { "BufRead", "CursorMoved", "BufAdd" },
		callback = function()
			local win_nr = api.nvim_get_current_win()
			if pcall(api.nvim_win_get_var, win_nr, "_common_opts") then
				return
			else
				api.nvim_win_set_var(win_nr, "_common_opts", {})
				-- need to delete the var as soon as we leave, it will become problem
				-- when we are navigation file link help files and we are jumping on
				-- links.
				vim.api.nvim_create_autocmd("BufWinLeave,", {
					once = true,
					callback = function()
						api.nvim_win_del_var(win_nr, "_common_opts")
					end,
				})
			end
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
					["qf"] = { buflisted = false },
					["noice"] = common_opts.unset,
					["help"] = vim.tbl_extend(
						"force",
						common_opts.set,
						{ signcolumn = "no", conceallevel = 0, statusline = " " }
					),
					["harpoon"] = vim.tbl_extend("force", common_opts.unset, { number = true }),
				},
			}
			vim.defer_fn(function()
				if types.ft[vim.bo.filetype] then
					for option, val in pairs(types.ft[vim.bo.filetype]) do
						optl[option] = val
					end
				elseif types.buf[vim.bo.buftype] then
					for option, val in pairs(types.buf[vim.bo.buftype]) do
						optl[option] = val
					end
				elseif #bo.buftype < 1 then
					for option, val in pairs(common_opts.set) do
						optl[option] = val
					end
				end
			end, 0)
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
	func NoExitCode()
		if !v:event.status 
			exe 'bdelete! '..expand('<abuf>')
		elseif !v:shell_error 
			exe 'bdelete! '..expand('<abuf>')
		endif
	endfunc
	autocmd TermClose * call NoExitCode()
]])
