-- NOTE: if you are trying to lazy_load using the safdar/core/lazy-loader
-- functions then there should be only three keys in the plugin table
-- 1) opt
-- 2) setup
-- 3) config
-- If you have requires key then it may break so move that to a separate key.

local vim = vim

pcall(require, "impatient") -- run :LuaCacheClear

local packer = require("packer")
packer.init({
	auto_clean = true,
	compile_on_sync = true,
	git = { clone_timeout = 6000 },
	profile = {
		enable = true,
		threshold = 100, -- the amount in ms that a plugins load time must be over for it to be included in the profile
	},
	display = {
		working_sym = "ﲊ",
		error_sym = "✗ ",
		done_sym = " ",
		removed_sym = " ",
		moved_sym = "",
		open_fn = function()
			return require("packer.util").float({ border = "single" })
		end,
	},
})

local plugins = {
	["wbthomason/packer.nvim"] = { -- packer can manage itself
		opt = true,
		cmd = require("safdar.core.utils").packer_cmds,
	},

	----------------------------------------------------------------------
	--                        ~> Performance                            --
	----------------------------------------------------------------------
	["lewis6991/impatient.nvim"] = { -- reduces loadtime
		config = function()
			require("impatient")
			require("impatient").enable_profile()
		end,
	},
	["antoinemadec/FixCursorHold.nvim"] = {
		after = "impatient.nvim",
		run = function()
			vim.g.curshold_updatime = 100
		end,
	},
	["norcalli/profiler.nvim"] = {
		opt = true,
		config = function()
			require("profiler")
		end,
	},
	["dstein64/vim-startuptime"] = {
		opt = true,
		cmd = { "StartupTime" },
	},
	-- <~

	----------------------------------------------------------------------
	--                   ~> Common Libraries                            --
	----------------------------------------------------------------------
	["nvim-lua/plenary.nvim"] = {},
	["nvim-lua/popup.nvim"] = { after = "plenary.nvim" },
	-- <~

	----------------------------------------------------------------------
	--                        ~> Telescope                              --
	----------------------------------------------------------------------
	["nvim-telescope/telescope.nvim"] = {
		cmd = "Telescope",
		keys = require("safdar.plugins.telescope.maps").packer_keys,
		setup = function()
			require("fused").lazy_load("telescope")
		end,
		config = function()
			require("safdar.plugins.telescope").telescope()
		end,
	},
	["nvim-telescope/telescope-fzf-native.nvim"] = {
		after = "telescope.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		config = function()
			require("safdar.plugins.telescope.telescope-plugins").fzf()
		end,
	},
	-- TODO: look into telescope plugin ans config for searching
	-- ["nvim-telescope/telescope-live-grep-args.nvim"] = {
	-- 	after = "telescope-fzf-native.nvim",
	-- },
	["LukasPietzschmann/telescope-tabs"] = {
		after = "telescope-fzf-native.nvim",
		config = function()
			require("safdar.plugins.telescope.telescope-plugins").tabs()
		end,
	},
	-- <~

	----------------------------------------------------------------------
	--                      ~> Color Schemes                            --
	----------------------------------------------------------------------
	["TheSafdarAwan/fused.nvim"] = {
		config = function()
			require("safdar.plugins.fused")
		end,
	},
	["ellisonleao/gruvbox.nvim"] = {},
	-- ["catppuccin/nvim"] = {},
	["LunarVim/Colorschemes"] = {},
	["nvchad/base46"] = {
		config = function()
			-- local base46 = require("base46")
			-- base46.load_theme()
			-- base46.load_highlight("treesitter")
		end,
	},
	["folke/tokyonight.nvim"] = {
		-- config = function()
		-- 	require("safdar.plugins.tokyonight")
		-- end,
	},
	["Mofiqul/vscode.nvim"] = {
		cond = function()
			return false
		end,
		config = function()
			require("safdar.plugins.vscode")
		end,
	},
	["shaunsingh/nord.nvim"] = {},
	-- <~

	----------------------------------------------------------------------
	--                   ~> Navigation and enhancements                 --
	----------------------------------------------------------------------
	["kyazdani42/nvim-tree.lua"] = {
		config = function()
			require("safdar.plugins.nvim-tree")
			require("fused").lazy_load("nvimtree")
		end,
	},
	["kylechui/nvim-surround"] = {
		keys = {
			{ "v", "S" },
			{ "n", "cs" },
			{ "n", "ds" },
			{ "n", "ys" },
			{ "n", "yS" },
			{ "n", "ca" },
			{ "n", "da" },
		},
		-- tag = "main", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("safdar.plugins.surround")
		end,
	},
	["RRethy/vim-illuminate"] = {
		config = function()
			require("safdar.plugins.illuminate")
		end,
		event = { "CursorMoved" },
	},
	["s1n7ax/nvim-window-picker"] = {
		keys = { "n", "gf" },
		tag = "v1.*",
		config = function()
			require("safdar.plugins.window-picker")
		end,
	},
	["sindrets/winshift.nvim"] = { -- move window
		config = function()
			require("safdar.plugins.winshift")
		end,
		cmd = { "WinShift" },
		keys = {
			{ "n", "g;" },
			{ "n", "g:" },
		},
	},
	["beauwilliams/focus.nvim"] = {
		keys = { "gF", "go", "g," },
		config = function()
			require("safdar.plugins.focus")
		end,
		cmd = { "FocusToggle", "FocusEnable" },
	},
	-- <~

	----------------------------------------------------------------------
	--                          ~> Git                                  --
	----------------------------------------------------------------------
	["lewis6991/gitsigns.nvim"] = {
		opt = true,
		setup = function()
			local gitsigns = {
				name = "gitsigns.nvim",
			}
			require("safdar.core.lazy-loader").loaders.callback(gitsigns)
		end,
		config = function()
			require("safdar.plugins.gitsigns")
		end,
	},
	["TimUntersberger/neogit"] = {
		keys = { { "n", "ygo" }, { "n", "ygc" } },
		config = function()
			require("safdar.plugins.neogit")
			require("fused").lazy_load("neogit")
		end,
	},
	["sindrets/diffview.nvim"] = {
		keys = { { "n", "ygd" }, { "n", "ygD" } },
		config = function()
			require("safdar.plugins.diffview")
			require("fused").lazy_load("diffview")
		end,
	},

	----------------------------------------------------------------------
	--                     ~> UI                              --
	----------------------------------------------------------------------
	["rcarriga/nvim-notify"] = {
		after = "impatient.nvim",
	},
	["kyazdani42/nvim-web-devicons"] = {
		config = function()
			require("safdar.plugins.web-dev-icons")
			require("fused").lazy_load("devicons")
		end,
	}, -- icons for the nvim
	["feline-nvim/feline.nvim"] = {
		after = "nvim-web-devicons",
		config = function()
			require("safdar.plugins.feline")
		end,
	}, -- status line
	["lukas-reineke/indent-blankline.nvim"] = {
		event = "BufReadPost",
		config = function()
			require("safdar.plugins.indent-blank-line")
			require("fused").lazy_load("indentblankline")
		end,
	}, -- indent guides
	-- <~

	----------------------------------------------------------------------
	--                            ~> Lsp                                --
	----------------------------------------------------------------------
	["b0o/schemastore.nvim"] = {
		opt = true,
		setup = function()
			local plugin = {
				name = "schemastore.nvim",
			}
			require("safdar.core.lazy-loader").loaders.schedule_autocmd(plugin)
		end,
	}, -- for json schemas
	["neovim/nvim-lspconfig"] = {
		after = "schemastore.nvim",
		module_pattern = { "lspconfig.*" },
		config = function()
			require("safdar.lsp.lsp")
		end,
	},
	["jose-elias-alvarez/null-ls.nvim"] = {
		after = "nvim-lspconfig",
		config = function()
			require("safdar.lsp.null-ls")
			require("safdar.plugins.plugins_mappings.null-ls_map")
		end,
	},

	["AckslD/nvim-FeMaco.lua"] = { -- edit code from the markdown and neorg file using the lsp
		opt = true,
		setup = function()
			local femaco = {
				name = "nvim-FeMaco.lua",
				pattern = { "*.md", "*.norg" },
			}
			require("safdar.core.lazy-loader").loaders.schedule_autocmd(femaco)
		end,
		config = function()
			require("femaco").setup()
			require("safdar.plugins.plugins_mappings.FeMaco_map")
		end,
	},
	-- ~> linting files that null_ls does not support
	["dense-analysis/ale"] = {
		opt = true,
		setup = function()
			local ale = {
				name = "ale",
				pattern = { "*.html" },
			}
			require("safdar.core.lazy-loader").loaders.schedule_autocmd(ale)
		end,
		config = function()
			require("safdar.plugins.ale")
		end,
	},
	-- <~

	----------------------------------------------------------------------
	--                ~> Completion and Snippets                        --
	----------------------------------------------------------------------
	["L3MON4D3/LuaSnip"] = {
		opt = true,
		setup = function()
			local luasnip = {
				name = "LuaSnip",
				events = "BufRead",
			}
			require("safdar.core.lazy-loader").loaders.schedule_autocmd(luasnip)
		end,
		config = function()
			require("safdar.plugins.luasnip")
		end,
	},
	["saadparwaiz1/cmp_luasnip"] = { after = "nvim-cmp" },

	["hrsh7th/nvim-cmp"] = {
		opt = true,
		event = "InsertEnter",
		config = function()
			require("safdar.lsp.cmp")
			require("fused").lazy_load("cmp")
		end,
	},
	["hrsh7th/cmp-nvim-lsp"] = {
		after = "nvim-cmp",
		config = function()
			require("safdar.lsp.cmp.cmp-nvim-lsp")
		end,
	},
	["hrsh7th/cmp-buffer"] = { after = "cmp-nvim-lsp" },
	["hrsh7th/cmp-nvim-lsp-signature-help"] = { after = { "cmp-buffer" } },
	["hrsh7th/cmp-emoji"] = { after = "cmp-nvim-lsp-signature-help" },

	["hrsh7th/cmp-nvim-lua"] = {
		opt = true,
		setup = function()
			local plugin = {
				name = "cmp-nvim-lua",
			}
			require("safdar.core.lazy-loader").loaders.callback(plugin)
		end,
	},

	["tzachar/cmp-tabnine"] = {
		opt = true,
		run = "./install.sh",
		setup = function()
			local tabnine = {
				name = "cmp-tabnine",
				events = "InsertEnter",
			}
			require("safdar.core.lazy-loader").loaders.schedule_autocmd(tabnine)
		end,
		config = function()
			require("safdar.plugins.tabnine")
		end,
	},

	["uga-rosa/cmp-dictionary"] = {
		opt = true,
		-- event = "InsertEnter",
		-- ft = { "markdown", "norg", "html" },
		setup = function()
			local cmp_dictionary = {
				name = "cmp-dictionary",
				events = "InsertEnter",
				pattern = { "*.md", "*.html", "*.norg" },
			}
			require("safdar.core.lazy-loader").loaders.schedule_autocmd(cmp_dictionary)
		end,
		config = function()
			require("safdar.plugins.cmp.cmp-dictionary")
		end,
	},
	-- <~

	----------------------------------------------------------------------
	--                ~> Lsp utils & enhancements                       --
	----------------------------------------------------------------------
	["ray-x/lsp_signature.nvim"] = {
		event = "InsertEnter",
		after = "nvim-lspconfig",
		config = function()
			require("safdar.plugins.lspsignature")
		end,
	},
	["folke/trouble.nvim"] = {
		keys = { "n", "[" },
		config = function()
			require("safdar.plugins.lsp-trouble")
			require("fused").lazy_load("trouble")
		end,
	},
	["glepnir/lspsaga.nvim"] = {
		after = "trouble.nvim",
		config = function()
			require("safdar.plugins.lspsaga")
			require("fused").lazy_load("lspsaga")
		end,
	},
	["weilbith/nvim-code-action-menu"] = {
		config = function()
			require("safdar.plugins.code-action-menu")
		end,
		cmd = "CodeActionMenu",
		keys = {
			{ "n", "gca" },
		},
	},
	["filipdutescu/renamer.nvim"] = {
		branch = "master",
		requires = { { "nvim-lua/plenary.nvim" } },
		config = function()
			require("safdar.plugins.renamer")
			require("fused").lazy_load("renamer")
		end,
		keys = {
			{ "n", "yr" },
		},
	},
	-- <~

	----------------------------------------------------------------------
	--                         ~> Debugging                             --
	----------------------------------------------------------------------
	["mfussenegger/nvim-dap"] = {
		after = "nvim-dap-virtual-text",
		config = function()
			require("safdar.plugins.dap")
			--> plugins configs
			require("safdar.plugins.dap.dap-ui")
			require("safdar.plugins.dap.dap-virtual-text")
		end,
	},
	["rcarriga/nvim-dap-ui"] = {
		keys = { { "n", "_" } },
		requires = { "theHamsta/nvim-dap-virtual-text", after = "nvim-dap-ui" },
	},
	-- <~

	----------------------------------------------------------------------
	--                        ~> Treesitter                             --
	----------------------------------------------------------------------
	["nvim-treesitter/nvim-treesitter"] = {
		opt = true,
		setup = function()
			local nvim_ts = {
				name = "nvim-treesitter",
			}
			require("safdar.core.lazy-loader").loaders.on_file(nvim_ts)
		end,
		after = "plenary.nvim",
		run = ":TSUpdate",
		config = function()
			require("safdar.plugins.treesitter")
		end,
	},
	["nvim-treesitter/playground"] = {
		cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
		config = function()
			require("safdar.plugins.tsplayground")
		end,
	},
	["folke/paint.nvim"] = {
		after = "impatient.nvim",
		config = function()
			require("safdar.plugins.paint")
		end,
	},
	["windwp/nvim-ts-autotag"] = {
		opt = true,
		setup = function()
			local ts_autotag = {
				name = "nvim-ts-autotag",
				pattern = "*.html",
			}
			require("safdar.core.lazy-loader").loaders.schedule_autocmd(ts_autotag)
		end,
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	["p00f/nvim-ts-rainbow"] = {
		opt = true,
		setup = function()
			local ts_rainbow = {
				name = "nvim-ts-rainbow",
			}
			require("safdar.core.lazy-loader").loaders.schedule_autocmd(ts_rainbow)
		end,
		config = function()
			require("fused").lazy_load("tsrainbow")
		end,
	},
	-- <~

	----------------------------------------------------------------------
	--                           ~> Utils                               --
	----------------------------------------------------------------------
	["windwp/nvim-autopairs"] = {
		opt = true,
		setup = function()
			local autopairs = {
				name = "nvim-autopairs",
				events = { "InsertEnter" },
			}
			require("safdar.core.lazy-loader").loaders.schedule_autocmd(autopairs)
		end,
		config = function()
			require("safdar.plugins.autopairs")
		end,
	},
	["andymass/vim-matchup"] = { -- don't do lazy loading wit vim-matchup it breaks things
		after = "nvim-treesitter",
		config = function()
			require("safdar.plugins.vim-matchup")
		end,
	},
	["norcalli/nvim-colorizer.lua"] = {
		after = "nvim-autopairs",
		config = function()
			require("safdar.plugins.colorizer")
		end,
	}, -- shows the colors
	["mbbill/undotree"] = {
		opt = true,
		setup = function()
			local undotree = {
				name = "undotree",
				packadd = true,
				execute_cmd = "UndotreeToggle | wincmd h",
			}
			local keys = {
				{ "n", "<leader>u" },
			}
			require("safdar.core.lazy-loader").loaders.keymap(undotree, keys)
		end,
		config = function()
			require("safdar.plugins.undotree.maps")
		end,
	},
	["numToStr/Comment.nvim"] = {
		keys = {
			{ "v", "gc" },
			{ "n", "gc" },
		},
		config = function()
			require("Comment").setup({})
		end,
	}, -- comment out the blocks of text
	["folke/todo-comments.nvim"] = {
		event = "BufWinEnter",
		config = function()
			require("safdar.plugins.todo-comments")
			require("fused").lazy_load("todocomments")
		end,
	},
	["s1n7ax/nvim-comment-frame"] = {
		config = function()
			require("safdar.plugins.comment-frame")
		end,
		keys = {
			"<leader>cm",
			"<leader>cl",
		},
	},

	-- <~

	----------------------------------------------------------------------
	--                      ~> ThePrimeagen                             --
	----------------------------------------------------------------------
	["ThePrimeagen/vim-be-good"] = {
		opt = true,
		cmd = "VimBeGood",
		setup = function()
			local vim_be_good = {
				name = "vim-be-good",
				execute_cmd = "VimBeGood",
			}
			local keys = {
				{ "n", "<leader>gg" },
			}
			require("safdar.core.lazy-loader").loaders.keymap(vim_be_good, keys)
		end,
		config = function()
			require("safdar.plugins.vim-be-good.maps")
		end,
	},
	["ThePrimeagen/refactoring.nvim"] = {
		keys = { "n", "v" },
		config = function()
			require("safdar.plugins.refactoring")
		end,
	},
	["ThePrimeagen/harpoon"] = { -- the most amazing plugin i have yet discoverd
		keys = {
			{ "n", "<leader>ah" },
			{ "n", "<leader>af" },
			{ "n", "<leader>aa" },
			{ "n", "<leader>aH" },
			{ "n", "<leader>aj" },
			{ "n", "<leader>ak" },
			{ "n", "<leader>al" },
			{ "n", "<leader>tj" },
			{ "n", "<leader>tk" },
			{ "n", "<leader>tl" },
		},
		-- for harpoon telescope plugin
		requies = { "telescope.nvim" },
		config = function()
			require("safdar.plugins.harpoon")
			require("fused").lazy_load("harpoon")
		end,
	},
	-- TODO: work on this plugin as you explore more about git
	["ThePrimeagen/git-worktree.nvim"] = {
		after = "telescope.nvim",
		config = function()
			require("git-worktree").setup({
				change_directory_command = "cd", -- default: "cd",
				update_on_change = true, -- default: true,
				update_on_change_command = "e .", -- default: "e .",
				clearjumps_on_change = true, -- default: true,
				autopush = false, -- default: false,
			})
			require("safdar.plugins.plugins_mappings.git_worktree_map")
			require("safdar.plugins.telescope.telescope-plugins").git_worktree()
		end,
	},
	-- <~

	----------------------------------------------------------------------
	--                    ~> Note Takign Stuff Stuff                    --
	----------------------------------------------------------------------
	["nvim-neorg/neorg"] = {
		opt = true,
		setup = function()
			local neorg = {
				name = "neorg",
				pattern = "*.norg",
			}
			require("safdar.core.lazy-loader").loaders.callback(neorg)

			neorg = {
				name = "neorg",
				execute_cmd = "Neorg gtd capture",
				callback = function()
					require("safdar.plugins.neorg").load_conf()
				end,
			}
			local keys = {
				{ "n", "gtc" },
			}
			require("safdar.core.lazy-loader").loaders.keymap(neorg, keys)
		end,
		run = ":Neorg sync-parsers", -- This is the important bit!
	},
	["nvim-neorg/neorg-telescope"] = { after = "neorg" },
	["iamcco/markdown-preview.nvim"] = {
		opt = true,
		key = { "n", "<leader>mp" },
		setup = function()
			local md_preview = {
				name = "markdown-preview.nvim",
				pattern = "*.md",
			}
			require("safdar.core.lazy-loader").loaders.schedule_autocmd(md_preview)
		end,
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
		config = function()
			require("safdar.plugins.markdown-preview")
		end,
	},
	-- <~
}
local install = {}
for key, value in pairs(plugins) do
	plugins[key][1] = key
	install[#install + 1] = value
end

packer.startup({ install })
