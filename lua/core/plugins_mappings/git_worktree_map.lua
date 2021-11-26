local map = require("core.utils").map

map(
	"n",
	"<leader>gwc",
	[[:lua require('git-worktree').create_worktree('feat-69', 'master', 'origin')<cr>]],
	{ noremap = true, silent = true }
)

map("n", "<leader>gws", [[:lua require("git-worktree").switch_worktree("feat-69")<cr>]], { noremap = true, silent = true })

map("n", "<leader>gwd", [[ :lua require("git-worktree").delete_worktree("feat-69")<cr>]], {
	noremap = true,
	silent = true,
})
