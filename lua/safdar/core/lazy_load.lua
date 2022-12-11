local M = {}

local vim = vim
local api = vim.api

----------------------------------------------------------------------
--                       ~> Lazy Loading                            --
----------------------------------------------------------------------
local packer = require("packer")
local packer_plugins = _G.packer_plugins

local events = { "BufRead", "BufWinEnter", "BufNewFile" }

-- schedule the loading of the plugin and delete the group
local function schedule_load(name)
	api.nvim_del_augroup_by_name("lazy_load_" .. name)
	vim.schedule(function()
		packer.loader(name)
	end)
end

-- this function needs a tbl with this info
-- {
-- }
local function register_autocmd(plugin)
	api.nvim_create_autocmd(plugin.events or events, {
		group = api.nvim_create_augroup("lazy_load_" .. tostring(plugin.name), { clear = true }),
		pattern = plugin.pattern,
		callback = plugin.callback,
	})
end

-- for plugins that need a key to be loaded
-- 1){
--	name = plugin name -- string
--	keymap = {
--		mode = mode name, -- string
--		key = key to map, -- string
--		cmd = command name without : or <CR>, -- string
--		opts = options like noremap,silent, -- tbl
--		}
--	callback = load plugin configuration here, -- function
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
			vim.cmd(plugin.keymap.cmd)
			if plugin.del_autocmd then
				schedule_load(plugin.name)
			else
				vim.schedule(function()
					packer.loader(plugin.name)
				end)
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

M.loader = function(plugin)
	if plugin.name == "gitsigns.nvim" then
		plugin.callback = callbacks.gitsigns
	elseif plugin.name == "neorg" then
		plugin.callback = callbacks.neorg
		-- elseif plugin.name == "vim-be-good" then
		-- plugin.callback = callbacks.vim_be_good
	else
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
