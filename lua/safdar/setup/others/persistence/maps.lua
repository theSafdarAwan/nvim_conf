local set_map = require("safdar.utils").set_map
-- restore the session for the current directory
set_map("n", "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]])

-- restore the last session
set_map("n", "<leader>ql", [[<cmd>lua require("persistence").load({ last = true })<cr>]])

-- stop Persistence => session won't be saved on exit
set_map("n", "<leader>qd", [[<cmd>lua require("persistence").stop()<cr>]])
