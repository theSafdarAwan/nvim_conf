local M = {}

local vim = vim
local api = vim.api

----------------------------------------------------------------------
--                       ~> Lazy Loading                            --
----------------------------------------------------------------------
local packer = require("packer")

local events = { "BufRead", "BufWinEnter", "BufNewFile" }

-- schedule the loading of the plugin and delete the group
local function schedule_load(name)
	api.nvim_del_augroup_by_name("lazy_load_" .. name)
	vim.schedule(function()
		packer.loader(name)
	end)
end

local function register_autocmd(plugin)
	api.nvim_create_autocmd(plugin.events or events, {
		group = api.nvim_create_augroup("lazy_load_" .. tostring(plugin.name), { clear = true }),
		pattern = plugin.pattern,
		callback = plugin.callback,
	})
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
}

----------------------------------------------------------------------
--                          Plugins Loader                          --
----------------------------------------------------------------------

M.loader = function(plugin)
	if plugin.name == "gitsigns.nvim" then
		plugin.callback = callbacks.gitsigns
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

M.lsp_cmds = {
	"LspAttach",
	"LspStop",
	"LspStart",
	"LspInfo",
	"LspLog",
}

M.treesitter_cmds = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSEnable", "TSDisable", "TSModuleInfo" }

return M
