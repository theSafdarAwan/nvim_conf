--- Bootstrapping lazy.nvim, up and running.
local M = {}

--- lazy.nvim configuration
local lazy_config = {
	defaults = {
		lazy = true,
	},
	install = {
		-- install missing plugins on startup. This doesn't increase startup time.
		missing = true,
	},

	ui = {
		icons = {
			ft = "",
			lazy = "鈴 ",
			loaded = "",
			not_loaded = "",
		},
		custom_keys = {
			x = false,
		},
	},
	concurrency = 5, ---@type number limit the maximum amount of concurrent tasks
	dev = {
		-- directory where you store your local plugin projects
		path = "~/.config/nvim/dev/",
		fallback = false, -- Fallback to git when local plugin doesn't exist
	},
	diff = {
		-- diff command <d> can be one of:
		-- * browser: opens the github compare view. Note that this is always mapped to <K> as well,
		--   so you can have a different command for diff <d>
		-- * git: will run git diff and open a buffer with filetype git
		-- * terminal_git: will open a pseudo terminal with git diff
		-- * diffview.nvim: will open Diffview to show the diff
		cmd = "git",
	},
	change_detection = {
		-- automatically check for config file changes and reload the ui
		enabled = true,
		notify = true, -- get a notification when changes are found
	},
}

--- loads lazy.nvim and passes plugins table and config table.
---@param get_plugins function get's plugins
local lazy_installer = function(get_plugins)
	local plugins = get_plugins()
	require("lazy").setup(plugins, lazy_config)
	-- disable some of the default config commands and keys
	local config = require("lazy.view.config")
	config.commands.clean.key_plugin = nil
end

--- bootstraps lazy.nvim
---@param setup function
M.bootstrap = function(setup)
	local notify = require("safdar.utils").notify

	-- lazy.nvim installation path
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

	vim.opt.rtp:prepend(lazypath)

	vim.keymap.set("n", "<leader>ll", ":Lazy<CR>", { noremap = true, silent = true })

	--- Bootstrap lazy.nvim
	if not vim.loop.fs_stat(lazypath) then
		notify("Bootstrapping lazy.nvim ..")

		--- clone lazy.nvim
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			lazypath,
		})

		notify("Installing Plugins")
		lazy_installer(setup)

		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1f2335" }) -- change the bg color for poup

		-- vim.api.nvim_buf_delete(0, { force = true }) -- close lazy window

		-- install binaries from mason.nvim & tsparsers
		require("safdar.setup.lsp.mason.config").mason_installer()
		vim.defer_fn(function()
			vim.cmd("silent! MasonInstallAll")
		end, 0)
	else
		lazy_installer(setup)
	end
end

return M
