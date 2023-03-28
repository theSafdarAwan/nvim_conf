local config = function()
	local cmd = vim.cmd

	cmd([[
		let b:ale_linters = ['htmlhint']
	]])

	cmd([[
		let g:ale_sign_error = ''
		let g:ale_sign_warning = ' '
		" use the neovim lsp api to show diagnostics
		let g:ale_use_neovim_diagnostics_api=1
		" disable the echo message
		let g:ale_echo_cursor = 0
	]])

	-- Trick
	cmd([[
		autocmd BufEnter * ALEDisable
		autocmd BufEnter *.html ALEEnable
	]])

	require("safdar.setup.lsp.ale.maps")
end
return { config = config }
