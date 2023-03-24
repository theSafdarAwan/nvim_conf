local set_map = require("safdar.utils").set_map
set_map("n", "<leader>gwc", [[:lua require('git-worktree').create_worktree('feat-69', 'master', 'origin')<cr>]])
set_map("n", "<leader>gws", [[:lua require("git-worktree").switch_worktree("feat-69")<cr>]])
set_map("n", "<leader>gwd", [[ :lua require("git-worktree").delete_worktree("feat-69")<cr>]])
