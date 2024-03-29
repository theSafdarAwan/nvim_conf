local maps = require("safdar.setup.debugging.nvim-dap.maps")
local function config()
	local ok, dap = pcall(require, "dap")
	if not ok then
		require("safdar.utils").notify("dap not installed")
		return
	end
	local dapui = require("dapui")
	dap.listeners.after.event_initialized["dapui_config"] = function()
		print("Debugger Initialised")
		dapui.open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		print("Debugger Terminated")
		dapui.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		print("Debugger Exited")
		dapui.close()
	end

	-- adapters
	local dapAdapters = {
		"js-dap",
	}
	for _, adapters in ipairs(dapAdapters) do
		require("safdar.setup.debugging.nvim-dap.adapters." .. adapters)
	end

	local fn = vim.fn
	fn.sign_define("DapBreakpoint", { text = "ß", texthl = "@attribute", linehl = "", numhl = "" })
	fn.sign_define("DapBreakpointCondition", { text = "", texthl = "@warning", linehl = "", numhl = "" })
	fn.sign_define("DapStopped", { text = "ඞ", texthl = "@error" })
	fn.sign_define("DapLogPoint", { text = "", texthl = "@keyword", linehl = "", numhl = "" })

	maps.dap_maps()
end

local function dap_ui_config()
	local ok, dapui = pcall(require, "dapui")
	if not ok then
		require("safdar.utils").notify("dap-ui not installed")
		return
	end
	dapui.setup({
		icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
		mappings = maps.dap_ui_mappings,
		-- Use this to override mappings for specific elements
		element_mappings = {
			-- Example:
			-- stacks = {
			--   open = "<CR>",
			--   expand = "o",
			-- }
		},
		-- Expand lines larger than the window
		-- Requires >= 0.7
		expand_lines = vim.fn.has("nvim-0.7") == 1,
		-- Layouts define sections of the screen to place windows.
		-- The position can be "left", "right", "top" or "bottom".
		-- The size specifies the height/width depending on position. It can be an Int
		-- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
		-- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
		-- Elements are the elements shown in the layout (in order).
		-- Layouts are opened in order so that earlier layouts take priority in window sizing.
		layouts = {
			{
				elements = {
					-- Elements can be strings or table with id and size keys.
					{ id = "scopes", size = 0.25 },
					"breakpoints",
					"stacks",
					"watches",
				},
				size = 40, -- 40 columns
				position = "left",
			},
			{
				elements = {
					"repl",
					"console",
				},
				size = 0.25, -- 25% of total lines
				position = "bottom",
			},
		},
		controls = {
			-- Requires Neovim nightly (or 0.8 when released)
			enabled = true,
			-- Display controls in this element
			element = "repl",
			icons = {
				pause = "",
				play = "",
				step_into = "",
				step_over = "",
				step_out = "",
				step_back = "",
				run_last = "↻",
				terminate = "□",
			},
		},
		floating = {
			max_height = nil, -- These can be integers or a float between 0 and 1.
			max_width = nil, -- Floats will be treated as percentage of your screen.
			border = "single", -- Border style. Can be "single", "double" or "rounded"
			mappings = {
				close = { "q", "<Esc>" },
			},
		},
		windows = { indent = 1 },
		render = {
			max_type_length = nil, -- Can be integer or nil.
			max_value_lines = 100, -- Can be integer or nil.
		},
	})
	maps.dap_ui_maps()
end

local function dap_virtual_text_config()
	local ok, dap_vt = pcall(require, "nvim-dap-virtual-text")
	if not ok then
		require("safdar.utils").notify("nvim-dap-virtual-text not installed")
		return
	end
	dap_vt.setup({
		enabled = true, -- enable this plugin (the default)
		enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
		highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
		highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
		show_stop_reason = true, -- show stop reason when stopped for exceptions
		commented = false, -- prefix virtual text with comment string
		only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
		all_references = false, -- show virtual text on all all references of the variable (not only definitions)
		filter_references_pattern = "<module", -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
		-- experimental features:
		virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
		all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
		virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
		virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
		-- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
	})
end

return { config = config, dap_ui_config = dap_ui_config, dap_virtual_text_config = dap_virtual_text_config }
