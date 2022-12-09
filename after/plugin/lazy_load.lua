local vim = vim
local fn = vim.fn
local bo = vim.bo

local compiled = fn.stdpath("config") .. "/plugin/packer_compiled.lua"
if fn.empty(fn.glob(compiled)) == 0 then
	local plugins = {
		{
			events = { "InsertEnter" },
			plugin_name = "cmp-tabnine",
			time = 2000,
		},
		{
			events = { "InsertEnter" },
			plguin_name = "cmp-nvim-lua",
			time = 3000,
			condition = function()
				vim.cmd("packadd packer/opt/cmp-nvim-lua")
				if bo.filetype == "lua" then
					return true
				end
			end,
		},
		{
			events = { "InsertEnter" },
			plugin_name = "cmp-dictionary",
			time = 2000,
			condition = function()
				local ft = { "markdown", "norg" }
				for _, f in pairs(ft) do
					if bo.filetype == f then
						return true
					end
				end
			end,
		},
		{
			events = { "BufReadPost" },
			plugin_name = "gitsigns.nvim",
			condition = function()
				local git_present = vim.fs.find({ ".git" }, { upward = true })[1]
				if git_present then
					return true
				end
			end,
		},
		{
			events = { "BufReadPost" },
			plugin_name = "ale",
			time = 2000,
			condition = function()
				if bo.filetype == "html" then
					return true
				end
			end,
		},
		{
			events = { "VimEnter" },
			plugin_name = "nvim-lspconfig",
		},
		{
			events = { "BufEnter" },
			plugin_name = "todo-comments.nvim",
			time = 1000,
		},
		{
			events = { "InsertEnter" },
			plugin_name = "markdown-preview.nvim",
			condition = function()
				if bo.filetype == "markdown" then
					return true
				end
			end,
			time = 3000,
		},
	}
	require("safdar.core.utils").lazy_load(plugins)
end
