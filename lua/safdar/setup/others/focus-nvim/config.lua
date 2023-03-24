local function config()
	local status_ok, focus = pcall(require, "focus")
	if not status_ok then
		require("safdar.utils").notify("focus not found")
		return
	end

	focus.setup({
		excluded_filetypes = { "toggleterm", "NvimTree", "Outline" },
		compatible_filetrees = { "filetree", "nvimtree", "nerdtree", "chadtree", "fern", "Outline" },
		cursorline = false,
		signcolumn = false,
	})
	require("safdar.setup.others.focus-nvim.maps")
end
return { config = config }
