local vim = vim
local fn = vim.fn

require("safdar").default()

local function setup_plugins(cmd)
	-- require the plugins
	require("safdar").plugins()
	-- either PackerCompile or PackerSync
	if cmd then
		vim.cmd(cmd)
	end
	-- to require the modules that need to be required
	require("safdar.plugins.packer.on-last")
	-- to load plugins which are not loaded after compilation or installation
	vim.defer_fn(function()
		vim.cmd("silent! do BufRead")
	end, 1000)
end

local function notifyer(notify)
	if notify then
		local level = vim.log.levels.WARN
		vim.schedule(function()
			vim.api.nvim_notify(notify.msg, notify.level or level, notify.opts or {})
		end)
	end
end

-- install packer if doesn't exist's and compile it if the compiled file doesn't exists
local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
local compiled = fn.stdpath("config") .. "/plugin/packer_compiled.lua"
if fn.empty(fn.glob(install_path)) > 0 then
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#11111B" })
	notifyer({
		msg = "Cloning packer ..",
	})
	fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	-- install plugins + compile their configs
	vim.cmd("packadd packer.nvim")
	vim.cmd("silent! do VimEnter")
	setup_plugins("PackerSync")
	notifyer({
		msg = "Plugin Installation done Reload neovim",
	})
	return
elseif fn.empty(fn.glob(compiled)) > 0 then
	print("packer is compiling ..")
	setup_plugins("PackerCompile")
	notifyer({
		msg = "packer compiled reload neovim",
	})
	return
end
setup_plugins()
