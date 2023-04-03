local function config()
	local status_ok, focus = pcall(require, "focus")
	if not status_ok then
		require("safdar.utils").notify("focus not installed")
		return
	end

	focus.setup({
		excluded_filetypes = { "toggleterm", "NvimTree", "Outline" },
		excluded_buftypes = { "nofile", "prompt", "popup" },
		cursorline = false,
		signcolumn = false,
		number = false,
		relativenumber = false,
		height_quickfix = 20,
	})
	require("safdar.setup.others.focus-nvim.maps")
end
return { config = config }
