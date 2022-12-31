local function plugins(install)
	install({
		"mfussenegger/nvim-dap",
		after = "nvim-dap-virtual-text",
		config = function()
			require("safdar.setup.debugging.dap.config").config()
			--> plugins configs
			require("safdar.setup.debugging.dap.config").dap_ui_config()
			require("safdar.setup.debugging.dap.config").dap_virtual_text_config()
		end,
	})
	install({
		"rcarriga/nvim-dap-ui",
		keys = { { "n", "_" } },
		requires = { "theHamsta/nvim-dap-virtual-text", after = "nvim-dap-ui" },
	})
end

return { install = plugins }
