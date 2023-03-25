local function plugin(install)
	install({
		"smjonas/inc-rename.nvim",
		opts = {
			cmd_name = "IncRename", -- the name of the command
			hl_group = "Substitute", -- the highlight group used for highlighting the identifier's new name
			preview_empty_name = false, -- whether an empty new name should be previewed; if false the command preview will be cancelled instead
			show_message = true, -- whether to display a `Renamed m instances in n files` message after a rename operation
			-- input_buffer_type = "dressing", -- the type of the external input buffer to use (the only supported value is currently "dressing")
			post_hook = nil, -- callback to run after renaming, receives the result table (from LSP handler) as an argument
		},
		config = function(_, opts)
			require("inc_rename").setup(opts)
			vim.keymap.set("n", "yr", function()
				return ":IncRename " .. vim.fn.expand("<cword>")
			end, { noremap = true, silent = true, expr = true })
		end,
		event = "LspAttach",
	})
end

return { install = plugin }
