local vim = vim
local fn = vim.fn

local function get_plugins(install)
	local modules = {
		"core",
		"ui",
		"navigation",
		"git",
		"lsp",
		"completion",
		"others",
	}
	for _, mod in pairs(modules) do
		require("safdar.setup." .. mod).get_plugins(install)
	end
end

local function setup(cmd)
	local packer = require("packer")
	packer.init({
		auto_clean = true,
		compile_on_sync = true,
		git = { clone_timeout = 6000 },
		profile = {
			enable = true,
			threshold = 30, -- the amount in ms that a plugins load time must be over for it to be included in the profile
		},
		display = {
			working_sym = "ﲊ",
			error_sym = "✗ ",
			done_sym = " ",
			removed_sym = " ",
			moved_sym = "",
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
	})

	packer.startup(function(install)
		get_plugins(install)
		require("safdar.setup.core.on-last")
	end)

	if cmd then
		vim.cmd(cmd)
	end
end

local notify = require("safdar.utils").notify

-- install packer if doesn't exist's and compile it if the compiled file doesn't exists
local packer_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
local packer_compiled = fn.stdpath("config") .. "/plugin/packer_compiled.lua"
if fn.empty(fn.glob(packer_path)) > 0 then
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#11111B" })
	notify({
		msg = "Cloning packer ..",
	})
	fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", packer_path })
	vim.cmd("packadd packer.nvim")
	notify({
		msg = "Installing Plugins",
	})
	setup("PackerSync")
elseif fn.empty(fn.glob(packer_compiled)) > 0 then
	print("packer is compiling ..")
	setup("PackerCompile")
	notify({
		msg = "packer compiled reload neovim",
	})
else
	setup()
end
