local vim = vim

local function setup()
	local lazy_config = {
		defaults = { lazy = true },
		install = { colorscheme = { "nvchad" } },

		ui = {
			icons = {
				ft = "",
				lazy = "鈴 ",
				loaded = "",
				not_loaded = "",
			},
		},

		performance = {
			rtp = {
				disabled_plugins = {
					"2html_plugin",
					"tohtml",
					"getscript",
					"getscriptPlugin",
					"gzip",
					"logipat",
					"netrw",
					"netrwPlugin",
					"netrwSettings",
					"netrwFileHandlers",
					"matchit",
					"tar",
					"tarPlugin",
					"rrhelper",
					"spellfile_plugin",
					"vimball",
					"vimballPlugin",
					"zip",
					"zipPlugin",
					"tutor",
					"rplugin",
					"syntax",
					"synmenu",
					"optwin",
					"compiler",
					"bugreport",
					"ftplugin",
				},
			},
		},
	}

	local plugins = {}
	local function install(plugin)
		table.insert(plugins, plugin)
	end
	local modules = {
		"core",
		"ui",
		"navigation",
		"git",
		"lsp",
		"completion",
		"others",
		"debugging",
		"writing",
	}
	for _, mod in pairs(modules) do
		require("safdar.setup." .. mod).get_plugins(install)
	end
	require("lazy").setup(plugins, lazy_config)
end

local notify = require("safdar.utils").notify

-- lazy.nvim installation path
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

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

	vim.opt.rtp:prepend(lazypath)

	notify("Installing Plugins")
	setup()

	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#11111B" }) -- change the bg color for poup

	-- vim.api.nvim_buf_delete(0, { force = true }) -- close lazy window

	-- install binaries from mason.nvim & tsparsers
	require("safdar.setup.lsp.mason.config").mason_installer()
	vim.defer_fn(function()
		vim.cmd("silent! MasonInstallAll")
	end, 0)
else
	setup()
end

vim.opt.rtp:prepend(lazypath)
