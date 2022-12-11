local M = {}

local vim = vim
local api = vim.api

----------------------------------------------------------------------
--                       ~> Lazy Loading                            --
----------------------------------------------------------------------
local packer = require("packer")
local packer_plugins = _G.packer_plugins

local events = { "BufRead", "BufWinEnter", "BufNewFile" }

-- schedule the loading of the plugin and deletes the autocmd group
-- expects name of the plugin or a tbl with name key and del_autocmd boolean value
local function schedule_load(plugin)
	local name
	if type(plugin) == "string" then
		name = plugin
	else
		name = plugin.name
	end

	if packer_plugins[name] and not packer_plugins[name].enable then
		local del_autocmd = plugin.del_autocmd or true
		if del_autocmd then
			api.nvim_del_augroup_by_name("lazy_load_" .. name)
		end
		vim.schedule(function()
			packer.loader(name)
		end)
	end
end

-- loads plugins that need to be loaded without delay like treesitter
local function on_file_loader(name)
	packer.loader(name)
end

-- this function needs a tbl with this info
-- {
--	name = "plugin name to set the augroup name", -- string
--	events = "name of the evens either one or a tbl of events", -- tbl|string
--	pattern = "see :autocmd-pattern", -- string
--	callback = "function to do something either condition checking or something", -- function
-- }
local function register_autocmd(plugin)
	api.nvim_create_autocmd(plugin.events or events, {
		group = api.nvim_create_augroup("lazy_load_" .. tostring(plugin.name), { clear = true }),
		pattern = plugin.pattern,
		command = plugin.cmd,
		callback = plugin.callback,
	})
end

-- for plugins that need a key to be loaded
-- 1){
--	name = "plugin name" -- string
--	packadd = "to add plugin package boolean value", -- boolean
--	keymap = {
--		mode = "mode name", -- string
--		key = "key to map", -- string
--		cmd = "command name without : or <CR>", -- string
--		opts = "options like noremap,silent", -- tbl
--		}
--	del_autocmd = "boolean value to delete the autocmd if exists or not", -- boolean
--	callback = function() print("load plugin configuration here") end, -- function
--  }
function M.keymap_plugin_loader(plugin)
	local opts = { noremap = true, silent = true }
	local mode = "n"
	vim.keymap.set(plugin.keymap.mode or mode, plugin.keymap.key, function()
		if packer_plugins[plugin.name] and not packer_plugins[plugin.name].enable then
			if plugin.callback then
				-- in callback you should provide the require modules
				plugin.callback()
			end

			-- if the plugin doesn't have a setup func so we can add
			-- it using packadd option
			if plugin.packadd then
				vim.cmd("packadd " .. plugin.name)
			end

			vim.cmd(plugin.keymap.cmd)

			if plugin.del_autocmd then
				schedule_load({ name = plugin.name, del_autocmd = plugin.del_autocmd })
			end
		else
			vim.cmd(plugin.keymap.cmd)
		end
	end, plugin.keymap.opts or opts)
end

----------------------------------------------------------------------
--                        CallBack functions                        --
----------------------------------------------------------------------

-- callbacks should be defined here because of packer compilation which is why we
-- cant pass references to other functions
local callbacks = {
	gitsigns = function()
		vim.fn.system("git -C " .. vim.fn.expand("%:p:h") .. " rev-parse")
		local gitsigns = "gitsigns.nvim"
		if vim.v.shell_error == 0 then
			schedule_load(gitsigns)
		end
	end,
	neorg = function()
		local neorg = "neorg"
		schedule_load(neorg)
		require("safdar.plugins.neorg").load_conf()
	end,
}

----------------------------------------------------------------------
--                          Plugins Loader                          --
----------------------------------------------------------------------
-- plugins that have callback function defined in the callbacks table
local plugins_callbacks = {
	["neorg"] = callbacks.neorg,
	["gitsigns.nvim"] = callbacks.gitsigns,
}

M.loader = function(plugin)
	-- for plugins that need a callback which is defined in the callbacks tbl
	for k, v in pairs(plugins_callbacks) do
		if plugin.name == k then
			plugin.callback = v
			register_autocmd(plugin)
			return
		end
	end

	if plugin.on_file then
		plugin.callback = function()
			on_file_loader(plugin.name)
		end
	elseif not plugin.cmd then
		plugin.callback = function()
			schedule_load(plugin.name)
		end
	end
	register_autocmd(plugin)
end

----------------------------------------------------------------------
--                   cmds of lazy loaded plugins                    --
----------------------------------------------------------------------

M.packer_cmds = {
	"PackerSnapshot",
	"PackerSnapshotRollback",
	"PackerSnapshotDelete",
	"PackerInstall",
	"PackerUpdate",
	"PackerSync",
	"PackerClean",
	"PackerCompile",
	"PackerStatus",
	"PackerProfile",
	"PackerLoad",
}

M.treesitter_cmds = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSEnable", "TSDisable", "TSModuleInfo" }

return M
