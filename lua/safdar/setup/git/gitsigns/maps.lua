local M = {}
local utils = require("safdar.utils")
local set_map = utils.set_map

M.mappings = function(_) -- gives a bufnr
	local gs = package.loaded.gitsigns

	-- Navigation
	set_map("n", "]g", function()
		if vim.wo.diff then
			return "]c"
		end
		vim.schedule(function()
			gs.next_hunk()
		end)
		return "<Ignore>"
	end, { expr = true })
	set_map("n", "[g", function()
		if vim.wo.diff then
			return "[c"
		end
		vim.schedule(function()
			gs.prev_hunk()
		end)
		return "<Ignore>"
	end, { expr = true })

	-- Actions
	set_map("n", "gcs", ":Gitsigns stage_hunk<CR>")
	set_map("n", "gcr", ":Gitsigns reset_hunk<CR>")
	set_map("n", "<C-g>k", ":Gitsigns blame_line<CR>")
	set_map("n", "gbS", gs.stage_buffer)
	set_map("n", "gsu", gs.undo_stage_hunk)
	set_map("n", "gbR", gs.reset_buffer)
	set_map("n", "gsp", gs.preview_hunk)
	set_map("n", "<leader>hb", function()
		gs.blame_line({ full = true })
	end)
	set_map("n", "gtb", gs.toggle_current_line_blame)
	set_map("n", "gdt", gs.diffthis)
	set_map("n", "gdT", function()
		gs.diffthis("~")
	end)
	set_map("n", "gtd", gs.toggle_deleted)

	-- Text object
	set_map({ "n", "o", "x" }, "gks", ":<C-U>Gitsigns select_hunk<CR>")
end

return M
