local opt, optl, bo = vim.opt, vim.opt_local, vim.bo
local cmd, api = vim.cmd, vim.api

local autocmds = {}
autocmds.highlight_on_yank = {
	events = { "TextYankPost" },
	callback = function()
		require("vim.highlight").on_yank({
			timeout = 40,
			higroup = "MatchParen",
		})
	end,
}
autocmds.set_common_opts = {
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
			-- vim.api.nvim_create_autocmd("BufWinLeave,", {
			-- 	once = true,
			-- 	callback = function()
			-- 		pcall(api.nvim_win_del_var, win_nr, "_common_opts")
			-- 	end,
			-- })
		end
		local common_opts = {
			add = {
				relativenumber = true,
				number = true,
				signcolumn = "yes",
			},
			remove = {
				relativenumber = false,
				number = false,
				signcolumn = "no",
			},
		}
		local types = {
			buf = {
				["prompt"] = common_opts.remove,
				["nofile"] = common_opts.remove,
				["terminal"] = common_opts.remove,
			},
			ft = {
				["qf"] = { buflisted = false },
				["peekaboo"] = common_opts.remove,
				["noice"] = common_opts.remove,
				["help"] = vim.tbl_extend(
					"force",
					common_opts.add,
					{ signcolumn = "no", conceallevel = 0, statusline = " " }
				),
				["harpoon"] = vim.tbl_extend("force", common_opts.remove, { number = true }),
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
				for option, val in pairs(common_opts.add) do
					optl[option] = val
				end
			end
		end, 0)
	end,
}
autocmds.terminal_mode = {
	events = { "TermOpen" },
	callback = function()
		optl.number = false
		optl.signcolumn = "no"
		optl.relativenumber = false
		opt.filetype = "terminal"
		optl.spell = false
	end,
}
-- open help in full window if its only the valid win.
autocmds.open_help_in_tab = {
	events = { "BufRead", "BufNew" },
	callback = function()
		-- TODO: check for tab available windows and if only 1 window then do this
		-- else don't just like buf delete or window close maps
		vim.defer_fn(function()
			local ignore_filetypes = {
				"prompt",
				"popup",
				"",
			}
			for _, ft in ipairs(ignore_filetypes) do
				if vim.bo.buftype == ft then
					return
				end
			end
			local cur_tab = api.nvim_get_current_tabpage()
			local tab_wins = api.nvim_tabpage_list_wins(cur_tab)
			local normal_wins = {}
			for _, win in ipairs(tab_wins) do
				if api.nvim_win_get_option(win, "number") then
					table.insert(normal_wins, win)
				end
			end
			for _, win in ipairs(normal_wins) do
				local buf_nr = api.nvim_win_get_buf(win)
				if #api.nvim_buf_get_option(buf_nr, "filetype") < 1 then
					pcall(api.nvim_win_close, win, { force = true })
				end
			end
		end, 0)
	end,
}

-- autocmds.q_file = {
-- 	events = { "FileType" },
-- 	pattern = { "help", "man", "lspinfo", "qf" },
-- 	callback = function()
-- 		vim.keymap.set({ "n", "v" }, "q", function()
-- 			cmd("close")
-- 		end, { noremap = true, silent = true })
-- 	end,
-- },

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
