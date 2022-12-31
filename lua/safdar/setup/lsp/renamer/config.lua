local function config()
	local ok, renamer = pcall(require, "renamer")
	if not ok then
		require("safdar.utils").notify("renamer.nvim not found")
		return
	end

	local mappings = require("safdar.setup.lsp.renamer.maps")
	renamer.setup({
		-- The popup title, shown if `border` is true
		title = "Rename",
		-- The padding around the popup content
		padding = {
			top = 0,
			left = 0,
			bottom = 0,
			right = 0,
		},
		-- The minimum width of the popup
		min_width = 15,
		-- The maximum width of the popup
		max_width = 45,
		-- Whether or not to shown a border around the popup
		border = true,
		-- The characters which make up the border
		border_chars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
		-- border_chars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
		-- Whether or not to highlight the current word references through LSP
		show_refs = true,
		-- Whether or not to add resulting changes to the quickfix list
		with_qf_list = true,
		-- Whether or not to enter the new name through the UI or Neovim's `input`
		-- prompt
		with_popup = true,
		-- The keymaps available while in the `renamer` buffer. The example below
		-- overrides the default values, but you can add others as well.
		mappings = mappings.core_mappings,
		-- Custom handler to be run after successfully renaming the word. Receives
		-- the LSP 'textDocument/rename' raw response as its parameter.
		handler = nil,
	})

	mappings.maps()
end

return { config = config }
