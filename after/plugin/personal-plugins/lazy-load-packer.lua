--- NOTE: In this file i do some crazy things which might not work with you
local utils = require("safdar.core.utils")
local vim = utils.vim
local api = vim.api
local bo = vim.bo
local fn = vim.fn
local packer_plugins = packer_plugins

local packer = require("packer")

local plugin_name
local au_group = api.nvim_create_augroup("__packer_lazy_loading_plugins", { clear = true })

local function timer(name, time)
	fn.timer_start(time, function()
		if packer_plugins[name] then
			if not packer_plugins[name].loaded then
				packer.loader(name)
			end
		end
	end)
end

api.nvim_create_autocmd({ "InsertEnter" }, {
	group = au_group,
	callback = function()
		plugin_name = "cmp-nvim-lua"
		if not packer_plugins[plugin_name].loaded and bo.filetype == "lua" then
			packer.loader(plugin_name)
		end
	end,
})

api.nvim_create_autocmd({ "InsertEnter" }, {
	group = au_group,
	callback = function()
		plugin_name = "cmp-tabnine"
		timer(plugin_name, 3000)
	end,
})

api.nvim_create_autocmd({ "InsertEnter" }, {
	group = au_group,
	callback = function()
		local ft = { "markdown", "norg" }
		for _, f in pairs(ft) do
			if bo.filetype == f then
				plugin_name = "cmp-dictionary"
				timer(plugin_name, 4000)
			end
		end
	end,
})

api.nvim_create_autocmd({ "BufReadPost" }, {
	group = au_group,
	callback = function()
		plugin_name = "gitsigns.nvim"
		local git_present = vim.fs.find({ ".git" }, { upward = true })[1]
		if git_present then
			if not packer_plugins[plugin_name].loaded then
				packer.loader(plugin_name)
			end
		end
	end,
})

api.nvim_create_autocmd(
	{ "BufRead" },
	{
		group = au_group,
		callback = function()
			plugin_name = "ale"
			if bo.filetype == "html" then
				timer(plugin_name, 1000)
			end
		end,
	} --
)

api.nvim_create_autocmd({ "VimEnter" }, {
	group = au_group,
	callback = function()
		plugin_name = "nvim-lspconfig"
		timer(plugin_name, 2000)
	end,
})

api.nvim_create_autocmd({ "BufEnter" }, {
	group = au_group,
	callback = function()
		plugin_name = "todo-comments.nvim"
		timer(plugin_name, 3000)
	end,
})

api.nvim_create_autocmd({ "InsertEnter" }, {
	group = au_group,
	callback = function()
		plugin_name = "nvim-autopairs"
		timer(plugin_name, 3000)
	end,
})

api.nvim_create_autocmd({ "InsertEnter" }, {
	group = au_group,
	callback = function()
		plugin_name = "markdown-preview.nvim"
		if bo.filetype == "markdown" then
			timer(plugin_name, 3000)
		end
	end,
})
