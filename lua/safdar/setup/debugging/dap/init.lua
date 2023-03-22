local function plugins(install)
	install({
		"mfussenegger/nvim-dap",
		config = function()
			require("safdar.setup.debugging.dap.config").config()
			--> plugins configs
			require("safdar.setup.debugging.dap.config").dap_ui_config()
			require("safdar.setup.debugging.dap.config").dap_virtual_text_config()
		end,
	})
	install({
		"rcarriga/nvim-dap-ui",
		keys = "_",
		dependencies = { "theHamsta/nvim-dap-virtual-text", dependencies = "nvim-dap" },
	})
end

return { install = plugins }
