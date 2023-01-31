local utils = require("safdar.utils")
local set_map = utils.set_map
-- TODO: do something like ray-x does in his dot files
local expr = { noremap = true, silent = true ,expr = true}

-- ~> Remove mappings
local removed_maps = {
	{ { "n", "t", "i", "v" }, "<F1>" },
	{ "n", "[[" },
	--  remove the ctrl+c causes some problem's with lsp
	{ "n", "<C-c>" },
	{ "n", "]]" },
	{ "n", "gf" },
	-- remove space to acts as the l in normal mode
	{ "n", " " },
}
for _, map in ipairs(removed_maps) do
	set_map(map[1], map[2], "", nil)
end

-- Center the next searched item
-- set_map("n", "n", "nzz")
-- set_map("n", "N", "Nzz")
-- set_map("c", "<CR>", function()
-- 	return vim.fn.getcmdtype() == "/" and "<cr>zz" or "<CR>"
-- end, { expr = true, noremap = true, silent = true })

-- copy the whole line after the cursor
set_map("n", "Y", "y$")
set_map("v", "Y", "m`$y``")

-- Best remap ever
set_map("n", "cn", "*``cgn")
set_map("n", "cN", "*``cgN")

-- Paste onto the selection and don't copy the selection to the reg
-- set_map("v", "p", '"_dP')

-- mark before format paragraph mapping
set_map("n", "=ap", "mm=ap`m")
set_map("n", "=ip", "mm=ip`m")

-- Adding jump after 5 lines
set_map("n", "k", [[(v:count > 5 ? "m'" . v:count: "") . 'k']], expr)
set_map("n", "j", [[(v:count > 5 ? "m'" . v:count: "") . 'j']], expr)

--  Move Lines up and down
set_map("v", "<C-j>", ":m '>+1<cr>gv=gv")
set_map("v", "<C-k>", ":m '<-2<cr>gv=gv")

set_map("n", "<leader>R", ":set modifiable|set readonly!<cr>")

-- " moving the the logng lines containing files in left and right
set_map("n", "<A-l>", "zl")
set_map("n", "<A-h>", "zh")

-- Don't need them not so productive
-- Move to the left and right, up and down in insert mode
-- set_map("i", "<C-l>", "<c-o>a")
-- set_map("n", "<C-h>", "<c-o>h")
--
-- set_map("i", "<C-j>", "<c-o>j")
-- set_map("n", "<C-k>", "<c-o>k")

-- Copy to the system clipboard
set_map("v", "Y", "\"+y")
-- TODO: write a function that will copy line starting from the cursor position
-- if the Y is pressed once if its pressed multiple times then copy the whole file
set_map("n", "<leader>Y", "mzgg\"+yG zzz")

-- show messages
set_map("n", "<C-m>", ":messages<CR>")

-- Paster From the system clipboard
set_map("n", "<leader>p", "\"+p")
--
-- Paste onto the selection and don't copy the selection to the reg
set_map("v", "<leader>p", "_dP")

-- Yank the whole line after the cursor
set_map("n", "Y", "y$")

-- use ESC to turn off search highlighting
set_map("n", "<ESC>", ":noh<cr><c-l>")

-- use backspace to change the selection
-- only for the @luasnip selection
set_map("v", "<BS>", "\"_c")

-- Indentation
set_map("v", "<", "<gv")
set_map("v", ">", ">gv")

-- delete into the void in visual mode
set_map("v", "D", "\"_d")

-- Resize the buffer window
set_map("n", "<leader>=", ":vertical resize +5<cr>")
set_map("n", "<leader>-", ":vertical resize -5<cr>")
set_map("n", "<leader>rp", ":resize 100<cr><c-l>")

-- indent the whole document
set_map("n", "<leader>I", "mzggVG=`z<c-l>")

-- buffers mappings
set_map("n", "<Tab>", ":bnext<cr>")
set_map("n", "<S-Tab>", ":bprevious<cr>")
set_map("n", "<leader>x", ":bdelete<cr>")
set_map("n", "<leader>X", ":bdelete!<cr>")
set_map("n", "[b", ":bp<cr>")
set_map("n", "]b", ":bn<cr>")
set_map("n", "<A-b>", ":buffers<cr>")

-- window mappings
set_map("n", "gx", ":close<cr>")
set_map("n", "gX", ":close!<cr>")

-- tab mappings
set_map("n", "<leader>]", ":tabnext<cr>")
set_map("n", "<leader>[", ":tabprev<cr>")
set_map("n", "<C-x>", ":tabclose<cr>")
set_map("n", "<C-n>", ":tabnew<cr>")

-- I use Obsession plugin and i need to restore the whole (n)vim session without losing
-- a single pane so i replicated the ZZ command functionality and replace it with this one
set_map("n", "<leader>ZZ", ":wa | qa <cr>")

-- source the current file
set_map("n", "<leader>so", ":so %<CR>")

----------------------------------------------------------------------
--                      Built-in plugins maps                       --
----------------------------------------------------------------------
-- set_map("n", "<leader>so", ":so %<cr>") -- look into packer/maps

-- Spell checking
-- Pressing ,ss will toggle and untoggle spell checking
-- set_map("n", "<leader>ss", ":setlocal spell!<cr>")
set_map("n", "<leader>sn", "]s")
set_map("n", "<leader>sp", "[s")
set_map("n", "<leader>sa", "zg")
set_map("n", "<leader>sr", "zug")
set_map("n", "<leader>sd", "zw")
set_map("n", "<leader>s?", "z=")

-- To get out of the insert mode
set_map("i", "<C-[>", "<c-\\><c-n>")
-- Create a new line with no indentation
set_map("i", "<C-j>", "<Enter><ESC>i")

-- Terminal"
set_map("t", "<c-[>", "<c-\\><c-n>")
-- set_map("n", "<c-s><c-n>", ":execute 15 .. 'new +terminal' | let b:term_type = 'hori' | startinsert <CR>")
-- set_map("n", "<c-s><c-l>",":execute 'vnew +terminal' | let b:term_type = 'vert' | startinsert <CR>")
-- set_map("n", "<c-s><c-t>", ":execute 'terminal' | let b:term_type = 'wind' | startinsert <CR>")
