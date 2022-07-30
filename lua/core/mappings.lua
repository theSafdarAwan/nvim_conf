local map = require("core.utils").map
-- =========================================================================
--                            Mappings
-- =========================================================================

-- Center the next searched item
map("n", "n", "nzz", { noremap = true, silent = true })
map("n", "N", "Nzz", { noremap = true, silent = true })

-- copy the whole line after the cursor
map("n", "Y", "y$", { noremap = true, silent = true })
map("v", "Y", "$y", { noremap = true, silent = true })

-- Wrap around the selection
map("v", '<space>"', '<esc>`>a"<esc>`<i"<esc>', { noremap = true, silent = true })
map("v", "<space>'", "<esc>`>a'<esc>`<i'<esc>", { noremap = true, silent = true })
map("v", "<space>`", "<esc>`>a`<esc>`<i`<esc>", { noremap = true, silent = true })
map("v", "<space>[", "<esc>`>a]<esc>`<i[<esc>", { noremap = true, silent = true })
map("v", "<space>{", "<esc>`>a}<esc>`<i{<esc>", { noremap = true, silent = true })
map("v", "<space>(", "<esc>`>a)<esc>`<i(<esc>", { noremap = true, silent = true })
map("v", "<space>*", "<esc>`>a*<esc>`<i*<esc>", { noremap = true, silent = true })

-- Remap of the century
map("n", "cn", "*``cgn", { noremap = true, silent = true })
map("n", "cN", "*``cgN", { noremap = true, silent = true })

-- Paste onto the selection and don't copy the selection to the reg
-- map("v", "p", '"_dP', { noremap = true, silent = true })

-- undo break start new change points NOTE: it works only with ! , ` . =
map("i", "!", "!<c-g>u", { noremap = true, silent = true })
map("i", "`", "`<c-g>u", { noremap = true, silent = true })
map("i", ".", ".<c-g>u", { noremap = true, silent = true })
map("i", ",", ",<c-g>u", { noremap = true, silent = true })
map("i", "=", "=<c-g>u", { noremap = true, silent = true })

-- Adding jump after 5 lines
map("n", "k", [[(v:count > 5 ? "m'" . v:count: "") . 'k']], { noremap = true, silent = true, expr = true })
map("n", "j", [[(v:count > 5 ? "m'" . v:count: "") . 'j']], { noremap = true, silent = true, expr = true })

--  Move Lines up and down
map("v", "<C-j>", ":m '>+1<cr>gv=gv", { noremap = true, silent = true })
map("v", "<C-k>", ":m '<-2<cr>gv=gv", { noremap = true, silent = true })

map("n", "<leader>R", ":set relativenumber! | redraw<cr>", { noremap = true, silent = true })

-- " moving the the logng lines containing files in left and right
map("n", "<A-l>", "zl", { noremap = true, silent = true })
map("n", "<A-h>", "zh", { noremap = true, silent = true })

-- Don't need them not so productive
-- Move to the left and right, up and down in insert mode
-- map("i", "<C-l>", "<c-o>a", {noremap = true, silent = true})
-- map("n", "<C-h>", "<c-o>h", {noremap = true, silent = true})

-- map("i", "<C-j>", "<c-o>j", {noremap = true, silent = true})
-- map("n", "<C-k>", "<c-o>k", {noremap = true, silent = true})

-- Add new line above and below
map("n", "[<leader>", 'mzO<c-[>`z', { noremap = true, silent = true })
map("n", "]<leader>", 'mzo<c-[>`z', { noremap = true, silent = true })

-- Copy to the system clipboard
map("v", "<leader>y", '"+y', { noremap = true, silent = true })
map("n", "<leader>Y", 'mzgg"+yG zzz', { noremap = true, silent = true })

-- Paster From the system clipboard
map("n", "<leader>p", '"+p', { noremap = true, silent = true })
--
-- Paste onto the selection and don't copy the selection to the reg
map("v", "<leader>p", "_dP", { noremap = true, silent = true })

-- Yank the whole line after the cursor
map("n", "Y", "y$", { noremap = true, silent = true })

-- use ESC to turn off search highlighting
map("n", "<ESC>", ":noh<cr><c-l>", { noremap = true, silent = true })

-- Indentation
map("v", "<", "<gv", { noremap = true, silent = true })
map("v", ">", ">gv", { noremap = true, silent = true })

-- Resize the buffer window
map("n", "<leader>=", ":vertical resize +5<cr>", { noremap = true, silent = true })
map("n", "<leader>-", ":vertical resize -5<cr>", { noremap = true, silent = true })
map("n", "<leader>rp", ":resize 100<cr><c-l>", { noremap = true, silent = true })

-- indent the whole document
map("n", "<leader>I", "mzggVG=`z<c-l>", { noremap = true, silent = true })
--
-- toggle the relativenumber Helpful when substituting"
map("n", "<leader>tr", ":set rnu!<cr>", { noremap = true, silent = true })
map("n", "<leader>tn", ":set nu!<cr>", { noremap = true, silent = true })

-- buffers mappings
map("n", "<TAB>", ":bnext<cr>", { noremap = true, silent = true })
map("n", "<S-TAB>", ":bprevious<cr>", { noremap = true, silent = true })
map("n", "<leader>x", ":bdelete<cr>", { noremap = true, silent = true })
map("n", "<leader>X", ":bdelete!<cr>", { noremap = true, silent = true })
map("n", "<leader>C", ":close<cr>", { noremap = true, silent = true })

-- I use Obsession plugin and i need to restore the whole (n)vim session without losing
-- a single pane so i replicated the ZZ command functionality and replace it with this one
map("n", "<leader>ZZ", ":wa | qa <cr>", { noremap = true, silent = true })

-- =========================================================================
--                            Remove Mappings                            "
-- =========================================================================
--  remove the ctrl+c causes some problem's with lsp
map("n", "<C-c>", "<Nop>", { noremap = true, silent = true })

-- ==========================================================================
--                         built_in_plugins configs
-- ==========================================================================
map("n", "<leader>so", ":so %<cr>", { noremap = true, silent = true })

-- Spell checking
-- Pressing ,ss will toggle and untoggle spell checking
map("n", "<leader>ss", ":set spell!<cr>", { noremap = true, silent = true })
--[[
map("n", "<leader>sn", "]s", { noremap = true, silent = true })
map("n", "<leader>sp", "[s", { noremap = true, silent = true })
map("n", "<leader>sa", "zg", { noremap = true, silent = true })
map("n", "<leader>sr", "zug", { noremap = true, silent = true })
map("n", "<leader>sd", "zw", { noremap = true, silent = true })
map("n", "<leader>s?", "z=", { noremap = true, silent = true })
]]

-- Netrw
map("n", "<leader>vex", ":Explore<cr>", { noremap = true, silent = true })
-- map("n", "<leader>vex", ":Vexplore<cr><c-w>L :vertical resize 30<cr>", { noremap = true, silent = true })
map("n", "<leader>sex", ":Sexplore<cr><c-w>K", { noremap = true, silent = true })

-- To get out of the insert mode
map("i", "<c-[>", "<c-\\><c-n>", { noremap = true, silent = true })

-- Terminal"
map("t", "<c-[>", "<c-\\><c-n>", { noremap = true, silent = true })
-- map("n", "<c-s><c-n>", ":execute 15 .. 'new +terminal' | let b:term_type = 'hori' | startinsert <CR>", {noremap = true, silent = true})
-- map("n", "<c-s><c-l>",":execute 'vnew +terminal' | let b:term_type = 'vert' | startinsert <CR>", {noremap = true, silent = true})
-- map("n", "<c-s><c-t>", ":execute 'terminal' | let b:term_type = 'wind' | startinsert <CR>", {noremap = true, silent = true})

-- ==========================================================================
--                        custom manipluations
--                        hey don't worry :)
-- ==========================================================================
map("n", "<leader>ki", ":e ~/.config/nvim/lua/plugins/init.lua<cr>", { noremap = true, silent = true })
map("n", "<leader>kk", ":e ~/.config/nvim/lua/core/mappings.lua<cr>", { noremap = true, silent = true })
map("n", "<leader>ks", ":e ~/.config/nvim/lua/core/options.lua<cr>", { noremap = true, silent = true })
