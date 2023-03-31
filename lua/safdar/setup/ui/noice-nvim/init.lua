local function plugin(install)
	install({
		"folke/noice.nvim",
		lazy = false,
		init = function()
			require("fused").load_plugin("noice.nvim")
		end,
		config = function()
			require("safdar.setup.ui.noice-nvim.config").config()
			require("safdar.setup.ui.noice-nvim.maps")
		end,
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	})
end

return { install = plugin }
