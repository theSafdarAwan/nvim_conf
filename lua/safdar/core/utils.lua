local vim = vim
local api = vim.api
local fn = vim.fn

-- TODO: remove these useless utils

local M = {}
-- for anyone coming here this file is just here so that the vim variable warnings only remain to this file
-- i don't like warnings so i have defined it here and i access it using require and then requiring the all other
-- options.
M.vim = vim
M.opt = vim.opt
M.wo = vim.wo
M.optl = vim.opt_local
M.api = vim.api
M.g = vim.g
M.bo = vim.bo
M.cmd = vim.cmd
M.fn = vim.fn

M.map = function(mode, mapping, command, opts)
	vim.keymap.set(mode, mapping, command, opts)
end

M.buf_set_keymap = function(buffer, mode, lhs, rhs, opts)
	M.api.nvim_buf_set_keymap(buffer, mode, lhs, rhs, opts)
end

M.buf_set_option = function(buffer, name, value)
	M.api.nvim_buf_set_option(buffer, name, value)
end

M.command = function(cmd)
	M.api.nvim_command(cmd)
end

M.lazy_load = function(plugins_tbl)
	local packer_plugins = packer_plugins
	local packer = require("packer")

	local function load_now(t)
		for _, plugin in pairs(t) do
			if packer_plugins[plugin.plugin_name] then
				if not packer_plugins[plugin.plugin_name].loaded and plugin.condition then
					-- vim.defer_fn(function()
					packer.loader(plugin.plugin_name)
					-- end, 0)
				end
			end
		end
	end
	local function load_plugins(t)
		for _, tbl in pairs(t) do
			api.nvim_create_autocmd(tbl.events, {
				group = api.nvim_create_augroup("BeLazyOnFileOpen" .. tostring(tbl.plugin_name), { clear = true }),
				callback = function()
					if packer_plugins[tbl.plugin_name] then
						local condition = true
						if tbl.condition then
							condition = tbl.condition
						end
						if not packer_plugins[tbl.plugin_name].loaded and condition then
							api.nvim_del_augroup_by_name("BeLazyOnFileOpen" .. tbl.plugin_name)
							vim.defer_fn(function()
								packer.loader(tbl.plugin_name)
							end, tbl.time or 0)
						end
					end
				end,
			})
		end
	end
	if vim.g.lazy_load then
		local load_now_plugins_tbl = {}
		local i = 1
		for _, plugin in pairs(plugins_tbl) do
			local idx = #load_now_plugins_tbl
			local load_it_now = false
			local events = #plugin["events"]
			if events then
				for _, event in pairs(plugin["events"]) do
					if event == "BufReadPost" or event == "BufRead" or event == "VimEnter" or event == "BufEnter" then
						load_it_now = true
						break
					end
				end
			end
			if load_it_now then
				load_now_plugins_tbl[idx + 1] = plugin
				plugins_tbl[i] = nil
			end
			i = i + 1
		end
		load_now(load_now_plugins_tbl)
		load_plugins(plugins_tbl)
	else
		load_plugins(plugins_tbl)
	end
end

return M
