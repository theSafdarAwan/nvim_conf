require("safdar").default()

-- Remov default plugins
local utils = require("safdar.core.utils")
local g = utils.g
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

local vim = vim
local fn = vim.fn

-- require the packer compiled file
local packer_compile = "_packer"
if fn.empty(fn.glob(packer_compile)) > 0 then
	require(packer_compile)
	require("safdar.plugins")
end

-- install packer if doesn't exist's
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#11111B" })
	print("Cloning packer ..")
	fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })

	-- install plugins + compile their configs
	vim.cmd("packadd packer.nvim")
	-- require the plugins
	require("safdar.plugins")
	-- require the plugins autocmds
	require("safdar").plugins()
	vim.cmd("PackerInstall")
	vim.cmd("PackerCompile")
end
