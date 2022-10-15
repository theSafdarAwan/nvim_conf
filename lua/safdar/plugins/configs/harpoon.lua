require("harpoon").setup({
	nav_first_in_list = true,
})
vim.cmd([[
    autocmd TermClose * if !v:event.status | exe 'bdelete! '..expand('<abuf>') | endif
]])
