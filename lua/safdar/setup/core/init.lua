local function plugins(install)
	-- make sure impatient is loaded before any plugin
	local _, impatient = pcall(require, "impatient")
	pcall(impatient.enable_profile)
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
	install({ "nvim-lua/plenary.nvim" })
	install({ "nvim-lua/popup.nvim" })

	-- install the nvim-notify
	require("safdar.setup.core.notify").install(install)
end

return { get_plugins = plugins }
