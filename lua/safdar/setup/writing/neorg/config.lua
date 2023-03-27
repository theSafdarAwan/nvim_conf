local function config()
	local ok, neorg = pcall(require, "neorg")
	if not ok then
		require("safdar.utils").notify("neorg not installed")
		return
	end
	neorg.setup({
		load = {
			["core.defaults"] = {},
			["core.norg.esupports.metagen"] = {
				config = {
					type = "none", -- "none", "auto" or "empty"
					update_date = true,
				},
			},
			["core.norg.concealer"] = {
				config = {
					icon_preset = "basic", -- diamond, varied
					-- if you want to dim code blocks
					dim_code_blocks = {
						enabled = true,
						content_only = false,
						width = "content",
						padding = {
							left = 0,
							right = 5,
						},
						conceal = true,
					},
					folds = false,
					icons = {
						todo = {
							on_hold = {
								enabled = true,
								icon = "",
								query = "(todo_item_on_hold) @icon",
								extract = function()
									return 1
								end,
							},
						},
						markup = {
							enabled = true,
							spoiler = {
								highlight = "TSError",
							},
						},
					},
				},
			},
			["core.integrations.nvim-cmp"] = {},
			["core.keybinds"] = {
				config = {
					default_keybinds = false,
					hook = function(keybinds)
						-- Map all the below keybinds only when the "norg" mode is active
						keybinds.map_event_to_mode("norg", {
							n = {
								-- Hop to the destination of the link under the cursor
								{ "gd", "core.norg.esupports.hop.hop-link" },
								-- Same as `<CR>`, except opens the destination in a vertical split
								{
									"g<CR>",
									"core.norg.esupports.hop.hop-link",
									"vsplit",
								},
							},
						}, {
							silent = true,
							noremap = true,
						})
						-- Map the below keys only when traverse-heading mode is active
						keybinds.map_event_to_mode("traverse-heading", {
							n = {
								-- Move to the next heading in the document
								{
									"j",
									"core.integrations.treesitter.next.heading",
								},
								-- Move to the previous heading in the document
								{
									"k",
									"core.integrations.treesitter.previous.heading",
								},
							},
						}, {
							silent = true,
							noremap = true,
						})
						keybinds.map_event_to_mode("toc-split", {
							n = {
								-- Hop to the target of the TOC link
								{ "gd", "core.norg.qol.toc.hop-toc-link" },
								-- Closes the TOC split
								-- ^Quit
								{ "q", "core.norg.qol.toc.close" },
							},
						}, {
							silent = true,
							noremap = true,
							nowait = true,
						})
						-- Map the below keys on gtd displays
						keybinds.map_event_to_mode("gtd-displays", {
							n = {
								{ "gd", "core.gtd.ui.goto_task" },
								-- Keys for closing the current display
								{ "q", "core.gtd.ui.close" },
								{ "<Esc>", "core.gtd.ui.close" },
								{ "e", "core.gtd.ui.edit_task" },
								{ "<Tab>", "core.gtd.ui.details" },
							},
						}, {
							silent = true,
							noremap = true,
							nowait = true,
						})
						-- Apply the below keys to all modes
						keybinds.map_to_mode("all", {
							n = {
								{ "gmn", ":Neorg mode norg<CR>" },
								{
									"gmh",
									":Neorg mode traverse-heading<CR>",
								},
							},
						}, {
							silent = true,
							noremap = true,
						})
					end,
				},
			},
			["core.norg.qol.toc"] = {
				config = {
					close_split_on_jump = true,
					toc_split_placement = "right",
				},
			},
			["core.norg.journal"] = {
				config = {
					workspace = "PM",
					journal_folder = "Personal-Journal",
					strategy = "nested", -- flat or nested
				},
			},
			["core.norg.dirman"] = {
				config = {
					workspaces = {
						PM = "~/safdar-local/NOTES/Personal\\-Management/",
						todo = "~/safdar-local/NOTES/Personal\\-Management/TODO/",
						Personal_Management_Notes = "~/safdar-local/NOTES/Personal\\-Management/NOTES/",
					},
					autochdir = false, -- Automatically change the directory to the current workspace's root every time
					index = "index.norg", -- The name of the main (root) .norg file
				},
			},
			-- NOTE: this module is removed fro now
			-- ["core.gtd.base"] = {
			-- 	config = {
			-- 		workspace = "todo",
			-- 		syntax = {
			-- 			context = "#contexts",
			-- 			start = "#time.start",
			-- 			due = "#time.due",
			-- 			waiting = "#waiting.for",
			-- 		},
			-- 		custom_tag_completion = true,
			-- 	},
			-- },
			["core.norg.manoeuvre"] = {},
			["core.integrations.telescope"] = {},
		},
	})

	require("safdar.setup.writing.neorg.maps")
	require("fused").load_plugin("neorg")

	local optl = vim.opt_local
	local api = vim.api
	local function norg_ft_opts()
		optl.shiftwidth = 2
		optl.expandtab = true
	end

	api.nvim_create_autocmd({ "FileType" }, {
		group = api.nvim_create_augroup("_norg_config_autocmd", { clear = true }),
		pattern = { "norg" },
		callback = norg_ft_opts,
	})
end
return { config = config }
