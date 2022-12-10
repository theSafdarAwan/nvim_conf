local vim = vim
local api = vim.api
local bo = vim.bo

local M = {}

M.set_map = function(mode, mapping, command, opts)
	vim.keymap.set(mode, mapping, command, opts)
end

M.del_map = function(mode, mapping, opts)
	vim.keymap.set(mode, mapping, opts)
end

M.deprecated = function()
	-- vim.g.dep_foo = true
end

M.buf_set_map = function(buffer, mode, lhs, rhs, opts)
	api.nvim_buf_set_keymap(buffer, mode, lhs, rhs, opts)
end

M.buf_set_opt = function(buffer, name, value)
	api.nvim_buf_set_option(buffer, name, value)
end

----------------------------------------------------------------------
--                       ~> Lazy Loading                            --
----------------------------------------------------------------------
local packer_plugins = _G.packer_plugins
local packer = require("packer")

-- creates a autocmd to lazy load plgin
local function augroup_create(plugin)
	api.nvim_create_autocmd(plugin.events, {
		group = api.nvim_create_augroup("BeLazyOnFileOpen" .. tostring(plugin.name), { clear = true }),
		callback = function()
			if packer_plugins[plugin.name] then
				if not packer_plugins[plugin.name].loaded then
					api.nvim_del_augroup_by_name("lazy_load_" .. plugin.name)
					vim.defer_fn(function()
						packer.loader(plugin.name)
					end, 1000)
				end
			end
		end,
	})
end

local function find_git()
	local git_present = vim.fs.find({ ".git" }, { upward = true })[1]
	if not git_present then
		-- vim.fn.system("git -C " .. vim.fn.expand("%:p:h") .. " rev-parse")
		-- if vim.v.shell_error == 0 then
		return
	end
end

M.lazy_load = function(plugins_tbl)
	for _, plugin in pairs(plugins_tbl) do
		if plugin.name == "gitsigns.nvim" then
			if find_git() then
				vim.defer_fn(function()
					packer.loader(plugin.name)
				end, 0)
			else
				augroup_create(plugin)
			end
		else
			augroup_create(plugin)
		end
	end
end

return M
