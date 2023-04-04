local function config()
	local smart_splits = require("smart-splits")
	smart_splits.setup({
		-- Ignored filetypes (only while resizing)
		ignored_filetypes = {
			"nofile",
			"quickfix",
			"prompt",
			"popup",
		},
		-- Ignored buffer types (only while resizing)
		ignored_buftypes = { "NvimTree" },
		-- the default number of lines/columns to resize by at a time
		default_amount = 3,
		-- whether to wrap to opposite side when cursor is at an edge
		-- e.g. by default, moving left at the left edge will jump
		-- to the rightmost window, and vice versa, same for up/down.
		wrap_at_edge = true,
		-- when moving cursor between splits left or right,
		-- place the cursor on the same row of the *screen*
		-- regardless of line numbers. False by default.
		-- Can be overridden via function parameter, see Usage.
		move_cursor_same_row = false,
		-- whether the cursor should follow the buffer when swapping
		-- buffers by default; it can also be controlled by passing
		-- `{ move_cursor = true }` or `{ move_cursor = false }`
		-- when calling the Lua function.
		cursor_follows_swapped_bufs = false,
		-- resize mode options
		resize_mode = {
			-- key to exit persistent resize mode
			quit_key = "<C-c>",
			-- keys to use for moving in resize mode
			-- in order of left, down, up' right
			resize_keys = { "h", "j", "k", "l" },
			-- set to true to silence the notifications
			-- when entering/exiting persistent resize mode
			silent = true,
			-- must be functions, they will be executed when
			-- entering or exiting the resize mode
			hooks = {
				on_enter = function()
					local icons = require("safdar.setup.ui.icons").misc
					vim.notify("Resizing mode is active!")
				end,
				on_leave = function()
					vim.notify("Exiting resize mode.")
				end,
			},
		},
		-- ignore these autocmd events (via :h eventignore) while processing
		-- smart-splits.nvim computations, which involve visiting different
		-- buffers and windows. These events will be ignored during processing,
		-- and un-ignored on completed. This only applies to resize events,
		-- not cursor movement events.
		ignored_events = {
			"BufEnter",
			"WinEnter",
		},
		-- enable or disable a multiplexer integration
		-- set to false to disable, otherwise
		-- it will default to tmux if $TMUX is set,
		-- then wezterm if $WEZTERM_PANE is set,
		-- then kitty if $KITTY_LISTEN_ON is set,
		-- otherwise false
		multiplexer_integration = nil,
		-- disable multiplexer navigation if current multiplexer pane is zoomed
		-- this functionality is only supported on tmux due to wezterm and kitty
		-- not having a way to check if a pane is zoomed
		disable_multiplexer_nav_when_zoomed = true,
	})
	local map = require("safdar.utils").set_map
	local function resize(direction)
		return function()
			local count = vim.v.count ~= 0 and vim.v.count or 3
			smart_splits["resize_" .. direction](count)
		end
	end

	map("n", "gsh", resize("left"))
	map("n", "gsj", resize("down"))
	map("n", "gsk", resize("up"))
	map("n", "gsl", resize("right"))
	map("n", "gss", smart_splits.start_resize_mode)
end
return { config = config }
