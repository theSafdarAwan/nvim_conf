require("safdar").default()

-- Remove default plugins
local vim = vim
local g = vim.g
local disabled_built_ins = {
	"2html_plugin",
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
}

for _, plugin in pairs(disabled_built_ins) do
	g["loaded_" .. plugin] = 1
end

local fn = vim.fn

local function setup()
	-- require the plugins
	require("safdar").plugins()
	-- lazy load the plugins
	vim.cmd("PackerInstall")
	vim.cmd("PackerCompile")
end

-- install packer if doesn't exist's and compile the it if the compiled file
-- doesn't exists
local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
local compiled = fn.stdpath("config") .. "/plugin/packer_compiled.lua"
if fn.empty(fn.glob(install_path)) > 0 then
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#11111B" })
	print("Cloning packer ..")
	fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	-- install plugins + compile their configs
	vim.cmd("packadd packer.nvim")
	setup()
elseif fn.empty(fn.glob(compiled)) > 0 then
	print("packer is compiling ..")
	setup()
	vim.g.lazy_load = true
	vim.defer_fn(function()
		require("after.plugin.lazy_load")
	end, 1000)
	vim.defer_fn(function()
		vim.api.nvim_notify("packer has compiled reload neovim.", vim.log.levels.ERROR, {})
	end, 2000)
end
setup()
