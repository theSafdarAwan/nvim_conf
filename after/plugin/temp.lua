local ts = vim.treesitter
local api = vim.api

function Parse()
	local bufnr = api.nvim_get_current_buf()
	local lang = vim.bo.filetype
	local parser = ts.get_parser(bufnr, lang)
	local tree = parser:parse()
	print(vim.inspect(tree[1]:root()))
end
