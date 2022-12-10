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
		callback = plugin.callback,
	})
end

M.lazy_load = function(plugin)
	if plugin.name == "gitsigns.nvim" then
		plugin.callback = function()
			vim.fn.system("git -C " .. vim.fn.expand("%:p:h") .. " rev-parse")
			if vim.v.shell_error == 0 then
				schedule_load(plugin.name)
			end
		end
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
