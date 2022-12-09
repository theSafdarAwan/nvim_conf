local vim = vim
local fn = vim.fn
local bo = vim.bo

-- the @lazy_loading takes a tbl with 4 keys
-- events -- events like InsertEnter etc.
-- plugin_name -- name of the plugin
-- condition -- condition which returns a boolean

-- use lazy_load function for each plugin and maybe use the cond key in packer
local compiled = fn.stdpath("config") .. "/plugin/packer_compiled.lua"
if fn.empty(fn.glob(compiled)) == 0 then
	local plugins = {
		{
			events = { "InsertEnter" },
			plugin_name = "cmp-tabnine",
		},
		{
			events = { "InsertEnter" },
			plguin_name = "cmp-nvim-lua",
			au = true,
			condition = function()
				if bo.filetype == "lua" then
					return true
				end
			end,
		},
		{
			events = { "InsertEnter" },
			plugin_name = "cmp-dictionary",
			au = true,
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
			events = { "VimEnter", "BufReadPost" },
			plugin_name = "gitsigns.nvim",
			condition = function()
				local git_present = vim.fs.find({ ".git" }, { upward = true })[1]
				if git_present then
					-- vim.fn.system("git -C " .. vim.fn.expand("%:p:h") .. " rev-parse")
					-- if vim.v.shell_error == 0 then
					return true
				end
			end,
		},
		{
			events = { "BufReadPost" },
			plugin_name = "nvim-lspconfig",
		},
		{
			events = { "VimEnter" },
			plugin_name = "todo-comments.nvim",
		},
	}
	require("safdar.core.utils").lazy_load(plugins)
end
