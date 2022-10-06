local map = require(require("genearl").core_loc() .. ".utils").map
local opts = { noremap = true, silent = true }
local expr = { noremap = true, silent = true, expr = true }
-- =========================================================================
--                            Mappings
-- =========================================================================

-- Center the next searched item
map("n", "n", "nzz", opts)
map("n", "N", "Nzz", opts)

-- copy the whole line after the cursor
map("n", "Y", "y$", opts)
map("v", "Y", "$y", opts)

-- Wrap around the selection
map("v", '<space>"', '<esc>`>a"<esc>`<i"<esc>', opts)
map("v", "<space>'", "<esc>`>a'<esc>`<i'<esc>", opts)
map("v", "<space>`", "<esc>`>a`<esc>`<i`<esc>", opts)
map("v", "<space>[", "<esc>`>a ]<esc>`<i[ <esc>", opts)
map("v", "<space>{", "<esc>`>a }<esc>`<i{ <esc>", opts)
map("v", "<space>(", "<esc>`>a )<esc>`<i( <esc>", opts)
map("v", "<space>*", "<esc>`>a*<esc>`<i*<esc>", opts)
map("v", "<space>2*", "<esc>`>a**<esc>`<i**<esc>", opts)

-- Remap of the century
map("n", "cn", "*``cgn", opts)
map("n", "cN", "*``cgN", opts)

-- Paste onto the selection and don't copy the selection to the reg
-- map("v", "p", '"_dP', opts)

-- undo break start new change points NOTE: it works only with ! , ` . =
map("i", "!", "!<c-g>u", opts)
map("i", "`", "`<c-g>u", opts)
map("i", ".", ".<c-g>u", opts)
map("i", ",", ",<c-g>u", opts)
map("i", "=", "=<c-g>u", opts)
map("n", "ds<space>", "mzF xf x`z", opts)
map("v", "<leader>a<space>", "o<ESC>i <ESC>gvoll<ESC>i <ESC>", opts)

-- Adding jump after 5 lines
map("n", "k", [[(v:count > 5 ? "m'" . v:count: "") . 'k']], expr)
map("n", "j", [[(v:count > 5 ? "m'" . v:count: "") . 'j']], expr)

--  Move Lines up and down
map("v", "<C-j>", ":m '>+1<cr>gv=gv", opts)
map("v", "<C-k>", ":m '<-2<cr>gv=gv", opts)

map("n", "<leader>R", ":set relativenumber! | redraw<cr>", opts)

-- " moving the the logng lines containing files in left and right
map("n", "<A-l>", "zl", opts)
map("n", "<A-h>", "zh", opts)

-- Don't need them not so productive
-- Move to the left and right, up and down in insert mode
-- map("i", "<C-l>", "<c-o>a", opts)
-- map("n", "<C-h>", "<c-o>h", opts)
--
-- map("i", "<C-j>", "<c-o>j", opts)
-- map("n", "<C-k>", "<c-o>k", opts)

-- Copy to the system clipboard
map("v", "<leader>y", '"+y', opts)
map("n", "<leader>Y", 'mzgg"+yG zzz', opts)

-- Paster From the system clipboard
map("n", "<leader>p", '"+p', opts)
--
-- Paste onto the selection and don't copy the selection to the reg
map("v", "<leader>p", "_dP", opts)

-- Yank the whole line after the cursor
map("n", "Y", "y$", opts)

-- use ESC to turn off search highlighting
map("n", "<ESC>", ":noh<cr><c-l>", opts)

-- Indentation
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Resize the buffer window
map("n", "<leader>=", ":vertical resize +5<cr>", opts)
map("n", "<leader>-", ":vertical resize -5<cr>", opts)
map("n", "<leader>rp", ":resize 100<cr><c-l>", opts)

-- indent the whole document
map("n", "<leader>I", "mzggVG=`z<c-l>", opts)

-- buffers mappings
map("n", "<leader>]", ":bnext<cr>", opts)
map("n", "<leader>[", ":bprevious<cr>", opts)
map("n", "<leader>x", ":bdelete<cr>", opts)
map("n", "<leader>X", ":bdelete!<cr>", opts)

-- I use Obsession plugin and i need to restore the whole (n)vim session without losing
-- a single pane so i replicated the ZZ command functionality and replace it with this one
map("n", "<leader>ZZ", ":wa | qa <cr>", opts)

-- =========================================================================
--                            Remove Mappings                            "
-- =========================================================================
--  remove the ctrl+c causes some problem's with lsp
map("n", "<C-c>", "<Nop>", opts)

-- ==========================================================================
--                         built_in_plugins configs
-- ==========================================================================
map("n", "<leader>so", ":so %<cr>", opts)

-- Spell checking
-- Pressing ,ss will toggle and untoggle spell checking
map("n", "<leader>ss", ":set spell!<cr>", opts)
map("n", "<leader>sn", "]s", opts)
map("n", "<leader>sp", "[s", opts)
map("n", "<leader>sa", "zg", opts)
map("n", "<leader>sr", "zug", opts)
map("n", "<leader>sd", "zw", opts)
map("n", "<leader>s?", "z=", opts)

-- To get out of the insert mode
map("i", "<c-[>", "<c-\\><c-n>", opts)

-- Terminal"
map("t", "<c-[>", "<c-\\><c-n>", opts)
-- map("n", "<c-s><c-n>", ":execute 15 .. 'new +terminal' | let b:term_type = 'hori' | startinsert <CR>", opts)
-- map("n", "<c-s><c-l>",":execute 'vnew +terminal' | let b:term_type = 'vert' | startinsert <CR>", opts)
-- map("n", "<c-s><c-t>", ":execute 'terminal' | let b:term_type = 'wind' | startinsert <CR>", opts)
