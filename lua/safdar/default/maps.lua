local utils = require("safdar.utils")
local set_map = utils.set_map
local opts = { noremap = true, silent = true }
local expr = vim.deepcopy(opts)
expr.expr = true

-- TODO: figure out this
-- ~> Remove mappings
local removed_maps = {
	{ { "n", "t", "i", "v" }, "<F1>" },
	{ "n", "[[" },
	--  remove the ctrl+c causes some problem's with lsp
	{ "n", "<C-c>" },
	{ "n", "]]" },
	{ "n", "gf" },
}
for _, map in pairs(removed_maps) do
	set_map(map[1], map[2], "", nil)
end

-- Center the next searched item
-- set_map("n", "n", "nzz", opts)
-- set_map("n", "N", "Nzz", opts)
-- set_map("c", "<CR>", function()
-- 	return vim.fn.getcmdtype() == "/" and "<cr>zz" or "<CR>"
-- end, { expr = true, noremap = true, silent = true })

-- copy the whole line after the cursor
set_map("n", "Y", "y$", opts)
set_map("v", "Y", "m`$y``", opts)

-- Best remap ever
set_map("n", "cn", "*``cgn", opts)
set_map("n", "cN", "*``cgN", opts)

-- Paste onto the selection and don't copy the selection to the reg
-- set_map("v", "p", '"_dP', opts)

-- mark before format paragraph mapping
set_map("n", "=ap", "mm=ap`m", opts)
set_map("n", "=ip", "mm=ip`m", opts)

-- Adding jump after 5 lines
set_map("n", "k", [[(v:count > 5 ? "m'" . v:count: "") . 'k']], expr)
set_map("n", "j", [[(v:count > 5 ? "m'" . v:count: "") . 'j']], expr)

--  Move Lines up and down
set_map("v", "<C-j>", ":m '>+1<cr>gv=gv", opts)
set_map("v", "<C-k>", ":m '<-2<cr>gv=gv", opts)

set_map("n", "<leader>R", ":set modifiable|set readonly!<cr>", opts)

-- " moving the the logng lines containing files in left and right
set_map("n", "<A-l>", "zl", opts)
set_map("n", "<A-h>", "zh", opts)

-- Don't need them not so productive
-- Move to the left and right, up and down in insert mode
-- set_map("i", "<C-l>", "<c-o>a", opts)
-- set_map("n", "<C-h>", "<c-o>h", opts)
--
-- set_map("i", "<C-j>", "<c-o>j", opts)
-- set_map("n", "<C-k>", "<c-o>k", opts)

-- Copy to the system clipboard
set_map("v", "Y", '"+y', opts)
-- TODO: write a function that will copy line starting from the cursor position
-- if the Y is pressed once if its pressed multiple times then copy the whole file
set_map("n", "<leader>Y", 'mzgg"+yG zzz', opts)

-- show messages
set_map("n", "<C-m>", ":messages<CR>", opts)

-- Paster From the system clipboard
set_map("n", "<leader>p", '"+p', opts)
--
-- Paste onto the selection and don't copy the selection to the reg
set_map("v", "<leader>p", "_dP", opts)

-- Yank the whole line after the cursor
set_map("n", "Y", "y$", opts)

-- use ESC to turn off search highlighting
set_map("n", "<ESC>", ":noh<cr><c-l>", opts)

-- use backspace to change the selection
-- only for the @luasnip selection
set_map("v", "<BS>", '"_c', opts)

-- Indentation
set_map("v", "<", "<gv", opts)
set_map("v", ">", ">gv", opts)

-- delete into the void in visual mode
set_map("v", "D", '"_d', opts)

-- Resize the buffer window
set_map("n", "<leader>=", ":vertical resize +5<cr>", opts)
set_map("n", "<leader>-", ":vertical resize -5<cr>", opts)
set_map("n", "<leader>rp", ":resize 100<cr><c-l>", opts)

-- indent the whole document
set_map("n", "<leader>I", "mzggVG=`z<c-l>", opts)

-- buffers mappings
set_map("n", "<Tab>", ":bnext<cr>", opts)
set_map("n", "<S-Tab>", ":bprevious<cr>", opts)
set_map("n", "<leader>x", ":bdelete<cr>", opts)
set_map("n", "<leader>X", ":bdelete!<cr>", opts)

-- window mappings
set_map("n", "gx", ":close<cr>", opts)
set_map("n", "gX", ":close!<cr>", opts)

-- tab mappings
set_map("n", "<leader>]", ":tabnext<cr>", opts)
set_map("n", "<leader>[", ":tabprev<cr>", opts)
set_map("n", "<C-x>", ":tabclose<cr>", opts)
set_map("n", "<C-n>", ":tabnew<cr>", opts)

-- I use Obsession plugin and i need to restore the whole (n)vim session without losing
-- a single pane so i replicated the ZZ command functionality and replace it with this one
set_map("n", "<leader>ZZ", ":wa | qa <cr>", opts)

-- source the current file
set_map("n", "<leader>so", ":so %<CR>", opts)

----------------------------------------------------------------------
--                      Built-in plugins maps                       --
----------------------------------------------------------------------
-- set_map("n", "<leader>so", ":so %<cr>", opts) -- look into packer/maps

-- Spell checking
-- Pressing ,ss will toggle and untoggle spell checking
-- set_map("n", "<leader>ss", ":setlocal spell!<cr>", opts)
set_map("n", "<leader>sn", "]s", opts)
set_map("n", "<leader>sp", "[s", opts)
set_map("n", "<leader>sa", "zg", opts)
set_map("n", "<leader>sr", "zug", opts)
set_map("n", "<leader>sd", "zw", opts)
set_map("n", "<leader>s?", "z=", opts)

-- To get out of the insert mode
set_map("i", "<C-[>", "<c-\\><c-n>", opts)
-- Create a new line with no indentation
set_map("i", "<C-j>", "<Enter><ESC>i", opts)

-- Terminal"
set_map("t", "<c-[>", "<c-\\><c-n>", opts)
-- set_map("n", "<c-s><c-n>", ":execute 15 .. 'new +terminal' | let b:term_type = 'hori' | startinsert <CR>", opts)
-- set_map("n", "<c-s><c-l>",":execute 'vnew +terminal' | let b:term_type = 'vert' | startinsert <CR>", opts)
-- set_map("n", "<c-s><c-t>", ":execute 'terminal' | let b:term_type = 'wind' | startinsert <CR>", opts)
