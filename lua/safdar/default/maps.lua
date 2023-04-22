local utils = require("safdar.utils")
local set_map = utils.set_map
local map_opts = require("safdar.utils").map_options:new()
local api = vim.api

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

set_map("n", "gls", function()
	vim.fn.system("ldoc " .. vim.fn.expand("%"))
end)

set_map("n", "glw", function()
	-- lua module
	local lua_mod = vim.fn.system("git rev-parse --show-toplevel")
	lua_mod = string.sub(lua_mod, 1, #lua_mod - 1) .. "/lua/"
	vim.fn.system("ldoc " .. lua_mod)
end)

-- Center the next searched item
-- set_map("n", "n", "nzz")
-- set_map("n", "N", "Nzz")
-- set_map("c", "<CR>", function()
-- 	return vim.fn.getcmdtype() == "/" and "<cr>zz" or "<CR>"
-- end, { expr = true, noremap = true, silent = true })

-- copy the whole line after the cursor
set_map("n", "Y", "y$")
set_map("v", "Y", "m`$y``")

-- WARN: this map deletes the current file from the file system, it asks the user
-- to for input using `vim.ui.select`
-- but it won't delete the buffer so if you accidentally deleted a file you can
-- recover the buffer by doing :w
set_map("n", "<leader>dd", function()
	local file_location = vim.fn.expand("%:p")
	local file_name = vim.fn.expand("%:t")
	local ui_select_menu = {
		"yes",
		"no",
	}
	local ui_select_opts = {
		prompt = "Do you want to delete " .. file_name .. " ?",
		format_item = function(item)
			local title = item
			return title
		end,
	}
	vim.ui.select(ui_select_menu, ui_select_opts, function(choice)
		if choice == "yes" then
			vim.fn.system({ "rm", "-rf", file_location })
			print("file deleted!")
		else
			print("file deletion canceled")
		end
	end)
end)

-- Best remap ever
set_map("n", "cn", "*``cgn")
set_map("n", "cN", "*``cgN")

-- Paste onto the selection and don't copy the selection to the reg
-- set_map("v", "p", '"_dP')

-- mark before format paragraph mapping
set_map("n", "=ap", "mm=ap`m")
set_map("n", "=ip", "mm=ip`m")

-- Adding jump after 5 lines
set_map("n", "k", [[(v:count > 5 ? "m'" . v:count: "") . 'k']], map_opts:noremap():silent():expr())
set_map("n", "j", [[(v:count > 5 ? "m'" . v:count: "") . 'j']], map_opts:noremap():silent():expr())

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

-- show messages
-- set_map("n", "<C-m>", ":messages<CR>") -- i am using noice.nvim

-- Paste From the system clipboard
set_map("n", "<leader>p", "\"+p")
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

-- -- Resize the buffer window
-- set_map("n", "<leader>=", ":vertical resize +5<cr>")
-- set_map("n", "<leader>-", ":vertical resize -5<cr>")
-- set_map("n", "<leader>rp", ":resize 100<cr><c-l>")

-- indent the whole document
set_map("n", "<leader>I", "mzggVG=`z<c-l>")

-- buffers mappings
set_map("n", "<Tab>", ":bnext<cr>")
set_map("n", "<S-Tab>", ":bprevious<cr>")
local function del_buf(args)
	-- don't close tab if has only one buffer in it
	local tabs = api.nvim_list_tabpages()
	local is_terminal = api.nvim_buf_get_option(0, "buftype") == "terminal"
	local cur_buf = api.nvim_get_current_buf()
	if #tabs > 1 and not is_terminal then
		local cur_tab = api.nvim_get_current_tabpage()
		local tab_wins = api.nvim_tabpage_list_wins(cur_tab)
		local valid_bufs = {}
		for _, win in ipairs(tab_wins) do
			if
				api.nvim_buf_is_valid(win)
				and win ~= cur_buf
				and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(win), "modifiable")
			then
				table.insert(valid_bufs, win)
			end
		end
		-- if no valid buf in the tab then create one
		if #valid_bufs < 1 then
			local new_buf = api.nvim_create_buf(true, false)
			table.insert(valid_bufs, new_buf)
		end
		api.nvim_set_current_buf(valid_bufs[1])
	end
	pcall(api.nvim_buf_delete, cur_buf, { force = is_terminal or args.force })
end
set_map("n", "<leader>x", function()
	del_buf({})
end)
set_map("n", "<leader>X", function()
	del_buf({ force = true })
end)
set_map("n", "[b", ":bp<cr>")
set_map("n", "]b", ":bn<cr>")
set_map("n", "<A-b>", ":buffers<cr>")

-- actually this doesn't work sometimes or the Ctrl-^ because some times i delete
-- the buffer instead i use my script file-history
-- set_map("n", "<leader>ap", ":buffer #<cr>")

-- window mappings
local function close_win(args)
	-- don't close tab if has only one buffer in it and its a valid file else close the tab
	local tabs = api.nvim_list_tabpages()
	local is_terminal = api.nvim_buf_get_option(0, "buftype") == "terminal"
	local cur_win = api.nvim_get_current_win()
	local cur_tab = api.nvim_get_current_tabpage()
	local tab_wins = api.nvim_tabpage_list_wins(cur_tab)
	if #tabs > 1 and not is_terminal then
		-- windows which have number set which are normal file windows
		local normal_wins = {}
		for _, win in ipairs(tab_wins) do
			if
				api.nvim_win_get_option(win, "number")
				and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(win), "modifiable")
			then
				table.insert(normal_wins, win)
			end
		end
		-- if no valid win is in the tab other then the current one then create a new buf
		if #normal_wins <= 1 and #vim.bo.filetype > 0 then
			api.nvim_set_current_buf(api.nvim_create_buf(true, false))
		else
			pcall(api.nvim_win_close, cur_win, { force = is_terminal or args.force })
		end
	else
		pcall(api.nvim_win_close, cur_win, { force = is_terminal or args.force })
	end
end
set_map("n", "gx", function()
	close_win({})
end)
set_map("n", "gX", function()
	close_win({ force = true })
end)

set_map("n", "gtx", ":tabclose<cr>")
set_map("n", "<C-n>", ":tabnew<cr>")

set_map("n", "gtn", ":tabnext<cr>")
set_map("n", "gtp", ":tabprevious<cr>")

-- screen movement by 10 lines
set_map("n", "zy", "10<C-y>")
set_map("n", "ze", "10<C-e>")

-- source the current file
set_map("n", "<leader>so", ":so %<CR>")

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

-- Terminal"
set_map("t", "<c-[>", "<C-\\><C-n>")
