local M = {}

local vim = vim
----------------------------------------------------------------------
--                        lazy loader utils                         --
----------------------------------------------------------------------
local packer = require("packer")
local packer_plugins = _G.packer_plugins

local utils = require("safdar.core.lazy-loader.utils")
local schedule = utils.schedule
local register_autocmd = utils.register_autocmd
local add_package = utils.add_package
local callbacks = require("safdar.core.lazy-loader.callbacks").callbacks

----------------------------------------------------------------------
--                         Plugins Loaders                          --
----------------------------------------------------------------------
local loaders = {}

----------------------------------------------------------------------
--                          Callback Loder                          --
----------------------------------------------------------------------

-- plugins that have callback function defined in the callbacks table
local plugins_callbacks = {
	["neorg"] = callbacks.neorg,
	["gitsigns.nvim"] = callbacks.gitsigns,
	["cmp-nvim-lua"] = callbacks.cmp_nvim_lua,
}

-- depends on what you did in the callback function
-- for plugins that need a callback which is defined in the callbacks tbl
loaders.callback = function(plugin)
	for k, v in pairs(plugins_callbacks) do
		if plugin.name == k then
			plugin.callback = v
			register_autocmd(plugin)
			return
		end
	end
end

----------------------------------------------------------------------
--                          Keymap Loader                           --
----------------------------------------------------------------------

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
loaders.keymap = function(plugin)
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
				add_package(plugin.name)
			end

			vim.cmd(plugin.keymap.cmd)

			if plugin.del_autocmd then
				schedule({ name = plugin.name, del_autocmd = plugin.del_autocmd })
			end
		else
			vim.cmd(plugin.keymap.cmd)
		end
	end, plugin.keymap.opts or opts)
end

----------------------------------------------------------------------
--                          On File Loader                          --
----------------------------------------------------------------------

-- plugins that need to be loaded before files like treesitter
loaders.on_file = function(plugin)
	plugin.callback = function()
		packer.loader(plugin.name)
		-- to revoke the lsp or treesitter
		vim.defer_fn(function()
			vim.cmd("silent! do FileType")
		end, 1000)
	end
	register_autocmd(plugin)
end

----------------------------------------------------------------------
--                      Schedul Autocmd Loader                      --
----------------------------------------------------------------------

-- schedule plugin loading with the event
loaders.schedule_autocmd = function(plugin)
	plugin.callback = function()
		schedule(plugin.name)
	end
	register_autocmd(plugin)
end

M.loaders = loaders

return M
