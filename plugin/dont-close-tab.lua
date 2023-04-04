--[[
--	Description: If there are more than one tabs open and you deleted last
--	buffer in that tab. Keep the tab with a nofile.
--]]

local api = vim.api
vim.api.nvim_create_autocmd("TabClosed", {
	group = vim.api.nvim_create_augroup("last buf in a tab", { clear = true }),
	callback = function()
		-- get the tabs list
		local tabs = api.nvim_list_tabpages()
		local cur_tab = api.nvim_win_get_tabpage(0)
		local cur_buf = vim.api.nvim_get_current_buf()
		local create_bf = vim.api.nvim_create_buf(false, true)
		local win_info = vim.fn.getwininfo()
		for _, i in ipairs(win_info) do
			if i.bufnr == cur_buf then
				vim.api.nvim_win_set_buf(i.winid, create_bf)
			end
		end
		vim.api.nvim_buf_delete(cur_buf, {})
	end,
})
