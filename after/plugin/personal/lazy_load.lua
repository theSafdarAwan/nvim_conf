local utils = require("safdar.core.utils")
local vim = utils.vim
local bo = vim.bo
local lazy_load = utils.lazy_load

lazy_load({
	events = { "InsertEnter" },
	plguin_name = "cmp-nvim-lua",
	condition = function()
		if bo.filetype == "lua" then
			return true
		end
	end,
})

lazy_load({
	events = { "InsertEnter" },
	plugin_name = "cmp-tabnine",
	time = 2000,
})

lazy_load({
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
})

lazy_load({
	events = { "BufReadPost" },
	plugin_name = "gitsigns.nvim",
	condition = function()
		local git_present = vim.fs.find({ ".git" }, { upward = true })[1]
		if git_present then
			return true
		end
	end,
})

lazy_load({
	events = { "BufReadPost" },
	plugin_name = "ale",
	condition = function()
		if bo.filetype == "html" then
			return true
		end
	end,
})

lazy_load({
	events = { "VimEnter" },
	plugin_name = "nvim-lspconfig",
})

lazy_load({
	events = { "BufEnter" },
	plugin_name = "todo-comments.nvim",
	time = 1000,
})

lazy_load({
	events = { "InsertEnter" },
	plugin_name = "nvim-autopairs",
	time = 3000,
})

lazy_load({
	events = { "InsertEnter" },
	plugin_name = "markdown-preview.nvim",
	condition = function()
		if bo.filetype == "markdown" then
			return true
		end
	end,
	time = 3000,
})
