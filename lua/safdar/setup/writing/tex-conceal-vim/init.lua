local function plugin(install)
	install({
		ft = "tex",
		"KeitaNakamura/tex-conceal.vim",
		config = function()
			vim.cmd([[
			set conceallevel=2
			let g:tex_conceal="abdgm"
			let g:tex_superscripts= "[0-9a-zA-W.,:;+-<>/()=]"
			let g:tex_subscripts= "[0-9aehijklmnoprstuvx,+-/().]"
			let g:tex_conceal_frac=1
			]])
		end,
	})
end
return { install = plugin }
