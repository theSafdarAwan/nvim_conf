local function plugin(install)
	install({
		"rareitems/printer.nvim",
		keys = {
			{ "gP", mode = "v" },
			"gP",
		},
		config = function()
			-- trim the long path names, will show maximum of 2 parent directories
			local trim_path = function(str)
				local path_tbl = vim.split(str, "/", { plain = false, trimempty = true })
				local parent_dirs = #path_tbl
				local path_str = ""
				if parent_dirs > 2 then
					path_str = path_tbl[parent_dirs - 2] .. "/" .. path_tbl[parent_dirs - 1]
				else
					path_str = str
				end
				return string.format("%s", path_str)
			end
			local function lua_formatter(inside, variable)
				return string.format("print('%s: ' .. vim.inspect(%s))", inside, variable)
			end
			require("printer").setup({
				keymap = "gP",
				formatters = {
					lua = lua_formatter,
				},
				-- function which modifies the text inside string in the print statement, by default it adds the path and line number
				add_to_inside = function(text)
					return string.format(
						"[%s:%s] %s",
						trim_path(vim.fn.expand("%")),
						vim.fn.line("."),
						text
					)
				end,
			})
			vim.keymap.set({ "n" }, "gP", "<Plug>(printer_print)iw", { silent = true, noremap = true })
		end,
	})
end
return { install = plugin }
