local function plugin(install)
	install({
		"junegunn/vim-peekaboo",
		lazy = false,
	})
end
return { install = plugin }
