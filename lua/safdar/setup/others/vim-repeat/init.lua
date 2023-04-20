local function Plugin(install)
	install({
		lazy = false,
		"tpope/vim-repeat",
	})
end

return { install = Plugin }
