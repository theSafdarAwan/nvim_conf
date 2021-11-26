local vim = vim
local term = require("toggleterm")
term.setup({
	on_config_done = nil,
	-- size can be a number or function which is passed the current terminal
	size = 20,
	-- open_mapping = [[<c-\>]],
	open_mapping = [[<c-t>]],
	hide_numbers = true, -- hide the number column in toggleterm buffers
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
	start_in_insert = true,
	insert_mappings = true, -- whether or not the open mapping applies in insert mode
	persist_size = false,
	-- direction = 'vertical' | 'horizontal' | 'window' | 'float',
	direction = "float",
	close_on_exit = true, -- close the terminal window when the process exits
	-- shell = vim.o.shell, -- change the default shell
	shell = "zsh", -- change the default shell
	-- This field is only relevant if direction is set to 'float'
	float_opts = {
		-- The border key is *almost* the same as 'nvim_win_open'
		-- see :h nvim_win_open for details on borders however
		-- the 'curved' border is a custom border type
		-- not natively supported but implemented in this plugin.
		-- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
		border = "single",
		-- width = <value>,
		-- height = <value>,
		winblend = 0,
		highlights = {
			border = "LineNr",
			background = "Normal",
		},
	},
	-- execs = {
	--     { "lazygit", "gg", "LazyGit" },
	-- },
})

require("core.plugins_mappings.toggle-term_map")

--> lazygit
local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

_lazygit_toggle = function()
	lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })

--> ranger
local ranger = Terminal:new({ cmd = "ranger", hidden = true, close_on_exit = true })

_ranger_toggle = function()
	ranger:toggle()
end

vim.api.nvim_set_keymap("n", "-", "<cmd>lua _ranger_toggle()<CR>", { noremap = true, silent = true })
vim.cmd("set hidden")
