local vim = vim
require("neoclip").setup({
	history = 100,
	enable_persistent_history = true,
	db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
	filter = nil,
	preview = true,
	default_register = '"',
	content_spec_column = false,
	on_paste = {
		set_reg = false,
	},
	keys = require(require("genearl").core_loc() .. ".plugins_mappings.neoclip_map").mapings()
})
