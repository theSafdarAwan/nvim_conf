require("init")
require("_packer.packer_compiled")

-- vim.cmd[[
-- autocmd BufEnter * ALEDisable
-- ]]

local map = require("core.utils").map
map("n", "<leader>mp", ":MarkdownPreviewToggle<CR>", {noremap = true, silent = true})
local g = vim.g

g.mkdp_refresh_slow = 1
g.mkdp_browser = 'firefox'
g.mkdp_echo_preview_url = 1
g.mkdp_filetypes = { "markdown" }
