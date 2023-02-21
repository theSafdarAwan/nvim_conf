local function config()
	require("spectre").setup({
		open_cmd = "bn",
		live_update = true, -- auto execute search again when you write any file in vim
		mapping = {
			["toggle_line"] = {
				map = "tt",
				cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
				desc = "toggle current item",
			},
			["enter_file"] = {
				map = "<cr>",
				cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
				desc = "goto current file",
			},
			["send_to_qf"] = {
				map = "=q",
				cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
				desc = "send all item to quickfix",
			},
			["replace_cmd"] = {
				map = "=y",
				cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
				desc = "input replace vim command",
			},
			["show_option_menu"] = {
				map = "=m",
				cmd = "<cmd>lua require('spectre').show_options()<CR>",
				desc = "show option",
			},
			["run_current_replace"] = {
				map = "=rc",
				cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
				desc = "replace current line",
			},
			["run_replace"] = {
				map = "=R",
				cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
				desc = "replace all",
			},
			["change_view_mode"] = {
				map = "=v",
				cmd = "<cmd>lua require('spectre').change_view()<CR>",
				desc = "change result view mode",
			},
			["change_replace_sed"] = {
				map = "trs",
				cmd = "<cmd>lua require('spectre').change_engine_replace('sed')<CR>",
				desc = "use sed to replace",
			},
			["change_replace_oxi"] = {
				map = "tro",
				cmd = "<cmd>lua require('spectre').change_engine_replace('oxi')<CR>",
				desc = "use oxi to replace",
			},
			["toggle_live_update"] = {
				map = "tu",
				cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
				desc = "update change when vim write file.",
			},
			["toggle_ignore_case"] = {
				map = "ti",
				cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
				desc = "toggle ignore case",
			},
			["toggle_ignore_hidden"] = {
				map = "th",
				cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
				desc = "toggle search hidden",
			},
			["resume_last_search"] = {
				map = "=l",
				cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
				desc = "resume last search before close",
			},
			-- you can put your mapping here it only use normal mode
		},
		find_engine = {
			-- rg is map with finder_cmd
			["rg"] = {
				cmd = "rg",
				-- default args
				args = {
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
				},
				options = {
					["ignore-case"] = {
						value = "--ignore-case",
						icon = "[I]",
						desc = "ignore case",
					},
					["hidden"] = {
						value = "--hidden",
						desc = "hidden file",
						icon = "[H]",
					},
					-- you can put any rg search option you want here it can toggle with
					-- show_option function
				},
			},
			["ag"] = {
				cmd = "ag",
				args = {
					"--vimgrep",
					"-s",
				},
				options = {
					["ignore-case"] = {
						value = "-i",
						icon = "[I]",
						desc = "ignore case",
					},
					["hidden"] = {
						value = "--hidden",
						desc = "hidden file",
						icon = "[H]",
					},
				},
			},
		},
		replace_engine = {
			["sed"] = {
				cmd = "sed",
				args = nil,
				options = {
					["ignore-case"] = {
						value = "--ignore-case",
						icon = "[I]",
						desc = "ignore case",
					},
				},
			},
			-- call rust code by nvim-oxi to replace
			["oxi"] = {
				cmd = "oxi",
				args = {},
				options = {
					["ignore-case"] = {
						value = "i",
						icon = "[I]",
						desc = "ignore case",
					},
				},
			},
		},
		default = {
			find = {
				--pick one of item in find_engine
				cmd = "rg",
				options = { "ignore-case" },
			},
			replace = {
				--pick one of item in replace_engine
				cmd = "sed",
			},
		},
		replace_vim_cmd = "cdo",
		is_open_target_win = true, --open file on opener window
		is_insert_mode = false, -- start open panel on is_insert_mode
	})
end
return { config = config }
