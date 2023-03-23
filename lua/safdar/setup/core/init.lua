local function plugins(install)
	-- make sure impatient is loaded before any plugin
	local _, impatient = pcall(require, "impatient")
	pcall(impatient.enable_profile)
	-- install({ -- my plugin to have extra power over lazy-loading
	-- 	"TheSafdarAwan/lazy-loader.nvim",
	-- })
	install({
		lazy = false,
		"lewis6991/impatient.nvim",
	})
	install({
		lazy = false,
		"antoinemadec/FixCursorHold.nvim",
		build = function()
			vim.g.curshold_updatime = 100
		end,
	})
	install({
		lazy = false,
		"norcalli/profiler.nvim",
		config = function()
			require("profiler")
		end,
	})
	install({
		"dstein64/vim-startuptime",
		cmd = { "StartupTime" },
	})
	----------------------------------------------------------------------
	--                   ~> Common Libraries                            --
	----------------------------------------------------------------------
	install({ "nvim-lua/plenary.nvim", lazy = false })
	install({ "nvim-lua/popup.nvim", lazy = false })

	-- install the nvim-notify
	require("safdar.setup.core.notify").install(install)
end

return { get_plugins = plugins }
