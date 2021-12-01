require("harpoon").setup({
	nav_first_in_list = true,
})
vim.cmd([[
    autocmd TermClose * if !v:event.status | exe 'bdelete! '..expand('<abuf>') | endif
]])

-- Don't show any numbers inside terminals
vim.cmd [[ au TermOpen term://* setlocal nonumber norelativenumber | setfiletype terminal ]]
