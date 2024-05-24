local M = {}

function M.override()
	vim.diagnostic.is_disabled = vim.diagnostic.is_enabled

	vim.tbl_add_reverse_lookup = function(tbl)
		for k, v in pairs(tbl) do
			tbl[v] = k
		end
	end
end

return M
