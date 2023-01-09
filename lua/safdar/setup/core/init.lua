local function plugins(install)
	-- make sure impatient is loaded before any plugin
	local ok, impatient = pcall(require, "impatient")
	if not ok then
		require("safdar.utils").notify("impatient not found")
	else
		impatient.enable_profile()
	end

	install({ -- packer can manage itself
		opt = true,
		"wbthomason/packer.nvim",
	})
	install({ -- my plugin to have extra power over lazy-loading
		"TheSafdarAwan/lazy-loader.nvim",
	})
	install({
		"lewis6991/impatient.nvim",
	})
	install({
		after = "impatient.nvim",
		"antoinemadec/FixCursorHold.nvim",
		run = function()
			vim.g.curshold_updatime = 100
		end,
	})
	install({
		opt = true,
		"norcalli/profiler.nvim",
		config = function()
			require("profiler")
		end,
	})
	install({
		opt = true,
		"dstein64/vim-startuptime",
		cmd = { "StartupTime" },
	})
	----------------------------------------------------------------------
	--                   ~> Common Libraries                            --
	----------------------------------------------------------------------
	install({ "nvim-lua/plenary.nvim" })
	install({ "nvim-lua/popup.nvim", after = "plenary.nvim" })

	--  install the nvim-notify
	require("safdar.setup.core.notify").install(install)
end

return { get_plugins = plugins }
